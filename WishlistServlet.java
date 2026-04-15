package com.reusehub.servlet;

import com.reusehub.dao.WishlistDAO;
import com.reusehub.model.Item;
import com.reusehub.model.User;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

public class WishlistServlet extends HttpServlet {
    private WishlistDAO wishlistDAO = new WishlistDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("/ReUseHub/login");
            return;
        }

        User user = (User) session.getAttribute("user");
        List<Item> wishlistItems = wishlistDAO.getWishlistByUser(user.getId());
        
        request.setAttribute("wishlistItems", wishlistItems);
        request.getRequestDispatcher("/jsp/wishlist.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("/ReUseHub/login");
            return;
        }
        User user = (User) session.getAttribute("user");
        int itemId = Integer.parseInt(request.getParameter("itemId"));
        String action = request.getParameter("action"); // 'add' or 'remove'
        
        if ("add".equals(action)) {
            wishlistDAO.addToWishlist(user.getId(), itemId);
            session.setAttribute("success", "Added to wishlist.");
        } else if ("remove".equals(action)) {
            wishlistDAO.removeFromWishlist(user.getId(), itemId);
            session.setAttribute("success", "Removed from wishlist.");
        }
        
        String referer = request.getHeader("Referer");
        if (referer != null && !referer.isEmpty()) {
            response.sendRedirect(referer);
        } else {
            response.sendRedirect("/ReUseHub/buyerDashboard");
        }
    }
}
