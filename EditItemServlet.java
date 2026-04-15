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

public class EditItemServlet extends HttpServlet {
    private ItemDAO itemDAO = new ItemDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("/ReUseHub/login");
            return;
        }

        String idStr = request.getParameter("id");
        if (idStr != null) {
            Item item = itemDAO.getItemById(Integer.parseInt(idStr));
            if (item != null) {
                request.setAttribute("item", item);
                request.getRequestDispatcher("/jsp/editItem.jsp").forward(request, response);
                return;
            }
        }
        response.sendRedirect("/ReUseHub/sellerDashboard");
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("/ReUseHub/login");
            return;
        }
        
        int id = Integer.parseInt(request.getParameter("id"));
        String name = request.getParameter("name");
        String category = request.getParameter("category");
        String conditionType = request.getParameter("condition");
        String type = request.getParameter("type");
        String description = request.getParameter("description");
        double price = 0;

        if ("sell".equals(type) && request.getParameter("price") != null && !request.getParameter("price").isEmpty()) {
            price = Double.parseDouble(request.getParameter("price"));
        } 

        Item item = new Item();
        item.setId(id);
        item.setName(name);
        item.setCategory(category);
        item.setConditionType(conditionType);
        item.setType(type);
        item.setPrice(price);
        item.setDescription(description);
        item.setPhotoUrl(request.getParameter("photoUrl"));

        if (itemDAO.updateItem(item)) {
            session.setAttribute("success", "Item updated successfully!");
        } else {
            session.setAttribute("error", "Failed to update item.");
        }
        response.sendRedirect("/ReUseHub/sellerDashboard"); // Or manageItems if created
    }
}
