package com.reusehub.servlet;

import com.reusehub.dao.UserDAO;
import com.reusehub.model.User;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class RoleSelectServlet extends HttpServlet {
    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("/ReUseHub/login");
            return;
        }
        request.getRequestDispatcher("/jsp/roleSelect.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("/ReUseHub/login");
            return;
        }

        User user = (User) session.getAttribute("user");
        String role = request.getParameter("role");

        if (role != null && (role.equals("buyer") || role.equals("seller"))) {
            user.setRole(role);
            userDAO.updateUserRole(user.getId(), role);
            
            if ("buyer".equals(role)) {
                response.sendRedirect("/ReUseHub/buyerDashboard");
            } else {
                response.sendRedirect("/ReUseHub/sellerDashboard");
            }
        } else {
            response.sendRedirect("/ReUseHub/selectRole");
        }
    }
}
