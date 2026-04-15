package com.reusehub.servlet;

import com.reusehub.dao.ItemDAO;
import com.reusehub.model.Item;
import com.reusehub.model.User;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

public class BuyerDashboardServlet extends HttpServlet {
    private ItemDAO itemDAO = new ItemDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("/ReUseHub/login");
            return;
        }

        User user = (User) session.getAttribute("user");
        if (!"buyer".equals(user.getRole())) {
            response.sendRedirect("/ReUseHub/selectRole");
            return;
        }

        String keyword = request.getParameter("keyword");
        String category = request.getParameter("category");
        String condition = request.getParameter("condition");
        String type = request.getParameter("type");

        List<Item> items;

        if (keyword != null && !keyword.trim().isEmpty()) {
            items = itemDAO.getItemsByKeyword(keyword);
        } else if ((category != null && !category.isEmpty()) || 
                   (condition != null && !condition.isEmpty()) || 
                   (type != null && !type.isEmpty())) {
            items = itemDAO.getItemsByFilter(category, condition, type);
        } else {
            items = itemDAO.getAllItems();
        }

        request.setAttribute("items", items);
        request.getRequestDispatcher("/jsp/buyerDashboard.jsp").forward(request, response);
    }
}
