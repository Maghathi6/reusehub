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

public class CheckoutServlet extends HttpServlet {
    private ItemDAO itemDAO = new ItemDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("/ReUseHub/login");
            return;
        }

        String itemIdStr = request.getParameter("itemId");
        if (itemIdStr == null || itemIdStr.isEmpty()) {
            response.sendRedirect("/ReUseHub/buyerDashboard");
            return;
        }

        int itemId = Integer.parseInt(itemIdStr);
        Item item = itemDAO.getItemById(itemId);

        if (item == null || item.getIsSold() == 1) {
            session.setAttribute("error", "Item is no longer available.");
            response.sendRedirect("/ReUseHub/buyerDashboard");
            return;
        }

        request.setAttribute("item", item);
        request.getRequestDispatcher("/jsp/checkout.jsp").forward(request, response);
    }
}
