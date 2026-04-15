package com.reusehub.servlet;

import com.reusehub.dao.ItemDAO;
import com.reusehub.dao.RewardDAO;
import com.reusehub.dao.UserDAO;
import com.reusehub.model.Item;
import com.reusehub.model.User;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class AddItemServlet extends HttpServlet {
    private ItemDAO itemDAO = new ItemDAO();
    private RewardDAO rewardDAO = new RewardDAO();
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("/ReUseHub/login");
            return;
        }
        User user = (User) session.getAttribute("user");
        if (!"seller".equals(user.getRole())) {
            response.sendRedirect("/ReUseHub/buyerDashboard");
            return;
        }
        request.getRequestDispatcher("/jsp/addItem.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("/ReUseHub/login");
            return;
        }

        User user = (User) session.getAttribute("user");
        if (!"seller".equals(user.getRole())) {
            response.sendRedirect("/ReUseHub/buyerDashboard");
            return;
        }

        String name = request.getParameter("name");
        String category = request.getParameter("category");
        String conditionType = request.getParameter("condition");
        String type = request.getParameter("type");
        String description = request.getParameter("description");
        double price = 0;

        if ("sell".equals(type) && request.getParameter("price") != null && !request.getParameter("price").isEmpty()) {
            price = Double.parseDouble(request.getParameter("price"));
        } // if donate, price remains 0

        Item item = new Item();
        item.setSellerId(user.getId());
        item.setName(name);
        item.setCategory(category);
        item.setConditionType(conditionType);
        item.setType(type);
        item.setPrice(price);
        item.setDescription(description);
        item.setPhotoUrl(request.getParameter("photoUrl"));

        if(itemDAO.addItem(item)) {
            int points = "donate".equals(type) ? 20 : 10;
            rewardDAO.addRewardLog(user.getId(), "Listed Item (" + type + ")", points);
            userDAO.updateRewardPoints(user.getId(), points);
            user.setRewardPoints(user.getRewardPoints() + points); // update session user
            
            session.setAttribute("success", "Item listed successfully!");
            response.sendRedirect("/ReUseHub/sellerDashboard");
        } else {
            request.setAttribute("error", "Failed to list item.");
            request.getRequestDispatcher("/jsp/addItem.jsp").forward(request, response);
        }
    }
}
