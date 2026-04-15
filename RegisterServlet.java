package com.reusehub.servlet;

import com.reusehub.dao.RewardDAO;
import com.reusehub.dao.UserDAO;
import com.reusehub.model.User;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public class RegisterServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAO();
    private RewardDAO rewardDAO = new RewardDAO();

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        User u = new User();
        u.setName(name);
        u.setEmail(email);
        u.setPassword(password);
        
        boolean success = userDAO.registerUser(u);
        if (success) {
            request.getSession().setAttribute("success", "Registration successful! Please login.");
            response.sendRedirect(request.getContextPath() + "/login");
        } else {
            request.setAttribute("error", "Registration failed. Email might already exist.");
            request.getRequestDispatcher("/jsp/register.jsp").forward(request, response);
        }
    }
}
