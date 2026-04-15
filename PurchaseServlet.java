package com.reusehub.servlet;

import com.reusehub.dao.ItemDAO;
import com.reusehub.dao.RewardDAO;
import com.reusehub.dao.UserDAO;
import com.reusehub.model.User;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class PurchaseServlet extends HttpServlet {
    private ItemDAO itemDAO = new ItemDAO();
    private RewardDAO rewardDAO = new RewardDAO();
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("/ReUseHub/login");
            return;
        }
        User user = (User) session.getAttribute("user");
        
        String idStr = request.getParameter("itemId");
        String paymentMethod = request.getParameter("paymentMethod");

        if (idStr != null) {
            int itemId = Integer.parseInt(idStr);
            com.reusehub.model.Item item = itemDAO.getItemById(itemId);
            
            if (item != null && itemDAO.markAsSold(itemId)) {
                
                // 1. Create Transaction Record
                com.reusehub.model.Transaction txn = new com.reusehub.model.Transaction();
                txn.setBuyerId(user.getId());
                txn.setSellerId(item.getSellerId());
                txn.setItemId(itemId);
                txn.setAmount(item.getPrice());
                txn.setPaymentMethod(paymentMethod != null ? paymentMethod : "Simulation");
                
                com.reusehub.dao.TransactionDAO txnDAO = new com.reusehub.dao.TransactionDAO();
                txnDAO.addTransaction(txn);

                // 2. Award Points (+10 for buying, +20 for donation pickup)
                int points = "donate".equals(item.getType()) ? 20 : 10;
                rewardDAO.addRewardLog(user.getId(), "Purchased/Picked up: " + item.getName(), points);
                userDAO.updateRewardPoints(user.getId(), points);
                user.setRewardPoints(user.getRewardPoints() + points);
                
                request.setAttribute("item", item);
                request.setAttribute("txn", txn);
                request.getRequestDispatcher("/jsp/paymentSuccess.jsp").forward(request, response);
                return;
            } else {
                session.setAttribute("error", "Failed to process payment.");
            }
        }
        response.sendRedirect("/ReUseHub/buyerDashboard");
    }
}
