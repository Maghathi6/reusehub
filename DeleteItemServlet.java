package com.reusehub.servlet;

import com.reusehub.dao.ItemDAO;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class DeleteItemServlet extends HttpServlet {
    private ItemDAO itemDAO = new ItemDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("/ReUseHub/login");
            return;
        }
        
        String idStr = request.getParameter("id");
        if (idStr != null) {
            int id = Integer.parseInt(idStr);
            if (itemDAO.deleteItem(id)) {
                session.setAttribute("success", "Item deleted successfully!");
            } else {
                session.setAttribute("error", "Failed to delete item.");
            }
        }
        response.sendRedirect("/ReUseHub/sellerDashboard");
    }
}
