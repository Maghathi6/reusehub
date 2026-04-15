package com.reusehub.servlet;

import com.reusehub.dao.RewardDAO;
import com.reusehub.model.RewardLog;
import com.reusehub.model.User;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

public class RewardsServlet extends HttpServlet {
    private RewardDAO rewardDAO = new RewardDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("/ReUseHub/login");
            return;
        }

        User user = (User) session.getAttribute("user");
        
        int totalPoints = rewardDAO.getTotalPoints(user.getId());
        user.setRewardPoints(totalPoints); // Keep session synced
        
        List<RewardLog> rewardLogList = rewardDAO.getRewardLogByUser(user.getId());
        
        String tier = "Bronze";
        if (totalPoints >= 300) {
            tier = "Gold";
        } else if (totalPoints >= 100) {
            tier = "Silver";
        }
        
        request.setAttribute("totalPoints", totalPoints);
        request.setAttribute("rewardLogList", rewardLogList);
        request.setAttribute("tier", tier);
        
        request.getRequestDispatcher("/jsp/rewards.jsp").forward(request, response);
    }
}
