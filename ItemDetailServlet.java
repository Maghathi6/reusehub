package com.reusehub.servlet;

import com.reusehub.dao.ItemDAO;
import com.reusehub.dao.WishlistDAO;
import com.reusehub.model.Item;
import com.reusehub.model.User;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;

public class ItemDetailServlet extends HttpServlet {
    private ItemDAO itemDAO = new ItemDAO();
    private WishlistDAO wishlistDAO = new WishlistDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("/ReUseHub/login");
            return;
        }

        User user = (User) session.getAttribute("user");
        String idStr = request.getParameter("id");
        
        if (idStr != null) {
            int itemId = Integer.parseInt(idStr);
            Item item = itemDAO.getItemById(itemId);
            
            if (item != null) {
                boolean isWishlisted = wishlistDAO.isWishlisted(user.getId(), itemId);
                request.setAttribute("item", item);
                request.setAttribute("isWishlisted", isWishlisted);
                request.getRequestDispatcher("/jsp/itemDetail.jsp").forward(request, response);
                return;
            }
        }
        
        response.sendRedirect("/ReUseHub/error.jsp");
    }
}
