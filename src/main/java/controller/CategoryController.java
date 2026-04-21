package controller;

import dao.CategoryDAO;
import java.io.IOException;
import java.util.List;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import model.Category;

@WebServlet(name = "CategoryController", urlPatterns = {"/CategoryController"})
public class CategoryController extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse res)
            throws ServletException, IOException {

        CategoryDAO dao = new CategoryDAO();
        List<Category> list = dao.getAll();

        req.setAttribute("data", list);
        req.getRequestDispatcher("/view/admin/category-list.jsp").forward(req, res);
    }
    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        doGet(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Category Controller";
    }
}
