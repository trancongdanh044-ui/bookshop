package controller;

import dao.UserDAO;
import java.io.IOException;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.User;

@WebServlet(name = "CustomerController", urlPatterns = {"/CustomerController"})
public class CustomerController extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        String action = req.getParameter("action");

        if (action == null || "home".equals(action)) {
            res.sendRedirect("BookController");
            return;
        }

        switch (action) {
            case "login":
                req.getRequestDispatcher("/view/auth/login.jsp").forward(req, res);
                break;
            case "register":
                req.getRequestDispatcher("/view/auth/register.jsp").forward(req, res);
                break;
            case "logout":
                req.getSession().invalidate();
                res.sendRedirect("BookController");
                break;
            case "profile":
                User user = (User) req.getSession().getAttribute("user");
                if (user == null) {
                    res.sendRedirect("AuthController?action=login");
                    return;
                }
                req.setAttribute("user", user);
                req.getRequestDispatcher("/view/customer/profile.jsp").forward(req, res);
                break;
            default:
                res.sendRedirect("BookController");
                break;
        }
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String action = req.getParameter("action");
        UserDAO dao = new UserDAO();

        if ("login".equals(action)) {
            User user = dao.login(req.getParameter("username"), req.getParameter("password"));
            if (user == null) {
                req.setAttribute("error", "Sai tài khoản hoặc mật khẩu");
                req.getRequestDispatcher("/view/auth/login.jsp").forward(req, res);
                return;
            }

            req.getSession().setAttribute("user", user);
            req.getSession().setAttribute("userId", user.getId());
            req.getSession().setAttribute("userRole", user.getRole());
            res.sendRedirect("BookController");
            return;
        }

        if ("register".equals(action)) {
            User user = new User();
            user.setUsername(req.getParameter("username"));
            user.setFullName(req.getParameter("fullName"));
            user.setEmail(req.getParameter("email"));
            user.setPassword(req.getParameter("password"));
            user.setPhone(req.getParameter("phone"));
            user.setAddress(req.getParameter("address"));
            user.setRole("user");

            dao.insert(user);
            req.setAttribute("success", "Đăng ký thành công. Vui lòng đăng nhập.");
            req.getRequestDispatcher("/view/auth/login.jsp").forward(req, res);
            return;
        }

        res.sendRedirect("BookController");
    }
}
