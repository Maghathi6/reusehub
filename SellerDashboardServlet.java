package com.reusehub.servlet;

import com.reusehub.dao.ItemDAO;
import com.reusehub.dao.RewardDAO;
import com.reusehub.model.Item;
import com.reusehub.model.User;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

public class SellerDashboardServlet extends HttpServlet {
    private ItemDAO itemDAO = new ItemDAO();
    private RewardDAO rewardDAO = new RewardDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("/ReUseHub/login");
            return;
        }

        User user = (User) session.getAttribute("user");
        if (!"seller".equals(user.getRole())) {
            response.sendRedirect("/ReUseHub/selectRole");
            return;
        }

        List<Item> sellerItems = itemDAO.getItemsBySeller(user.getId());
        
        long totalListed = sellerItems.size();
        long totalSold = sellerItems.stream().filter(i -> i.getIsSold() == 1).count();
        int rewardPoints = rewardDAO.getTotalPoints(user.getId());

        request.setAttribute("sellerItems", sellerItems);
        request.setAttribute("totalListed", totalListed);
        request.setAttribute("totalSold", totalSold);
        request.setAttribute("rewardPoints", rewardPoints);

        request.getRequestDispatcher("/jsp/sellerDashboard.jsp").forward(request, response);
    }
}
