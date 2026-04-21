package controller;

import dao.UserDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.User;

@WebServlet(name = "AuthController", urlPatterns = {"/AuthController"})
public class AuthController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String action = request.getParameter("action");
        
        if ("logout".equals(action)) {
            request.getSession().invalidate();
            response.sendRedirect("BookController");
        } else if ("login".equals(action)) {
            request.getRequestDispatcher("/view/auth/login.jsp").forward(request, response);
        } else if ("register".equals(action)) {
            request.getRequestDispatcher("/view/auth/register.jsp").forward(request, response);
        } else {
            request.getRequestDispatcher("/view/auth/login.jsp").forward(request, response);
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");

        if ("login".equals(action)) {
            UserDAO dao = new UserDAO();
            User acc = dao.login(
                req.getParameter("username"),
                req.getParameter("password")
            );

            if (acc != null) {
                req.getSession().setAttribute("user", acc);
                req.getSession().setAttribute("userId", acc.getId());
                req.getSession().setAttribute("userRole", acc.getRole());
                req.getSession().setAttribute("cartCount", 0);
                
                // Redirect based on role
                if("admin".equals(acc.getRole())) {
                    res.sendRedirect("AdminController?action=dashboard");
                } else {
                    res.sendRedirect("BookController");
                }
            } else {
                req.setAttribute("error", "Tên đăng nhập hoặc mật khẩu không đúng");
                req.getRequestDispatcher("/view/auth/login.jsp").forward(req, res);
            }
        } else if ("register".equals(action)) {
            UserDAO dao = new UserDAO();
            
            User newUser = new User();
            newUser.setUsername(req.getParameter("username"));
            newUser.setPassword(req.getParameter("password"));
            newUser.setEmail(req.getParameter("email"));
            newUser.setFullName(req.getParameter("fullName"));
            newUser.setPhone(req.getParameter("phone"));
            newUser.setAddress(req.getParameter("address"));
            newUser.setRole("user");
            
            dao.insert(newUser);
            
            req.setAttribute("success", "Đăng ký thành công. Vui lòng đăng nhập");
            req.getRequestDispatcher("/view/auth/login.jsp").forward(req, res);
        }
    }

    @Override
    public String getServletInfo() {
        return "Authentication Controller";
    }
}
//    public String getServletInfo() {
//        return "Short description";
//    }// </editor-fold>
//
//}
