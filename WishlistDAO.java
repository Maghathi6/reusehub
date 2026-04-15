package com.reusehub.dao;

import com.reusehub.util.DBUtil;
import com.reusehub.model.Item;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class WishlistDAO {

    public boolean addToWishlist(int userId, int itemId) {
        String sql = "INSERT INTO wishlist (user_id, item_id) VALUES (?, ?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, itemId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean removeFromWishlist(int userId, int itemId) {
        String sql = "DELETE FROM wishlist WHERE user_id = ? AND item_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, itemId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<Item> getWishlistByUser(int userId) {
        List<Item> items = new ArrayList<>();
        String sql = "SELECT i.*, u.name as sellerName, u.email as sellerEmail FROM wishlist w JOIN items i ON w.item_id = i.id JOIN users u ON i.seller_id = u.id WHERE w.user_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Item i = new Item();
                i.setId(rs.getInt("id"));
                i.setSellerId(rs.getInt("seller_id"));
                i.setName(rs.getString("name"));
                i.setCategory(rs.getString("category"));
                i.setConditionType(rs.getString("condition_type"));
                i.setType(rs.getString("type"));
                i.setPrice(rs.getDouble("price"));
                i.setDescription(rs.getString("description"));
                i.setIsSold(rs.getInt("is_sold"));
                i.setCreatedAt(rs.getString("created_at"));
                i.setSellerName(rs.getString("sellerName"));
                i.setSellerEmail(rs.getString("sellerEmail"));
                items.add(i);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return items;
    }

    public boolean isWishlisted(int userId, int itemId) {
        String sql = "SELECT id FROM wishlist WHERE user_id = ? AND item_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setInt(2, itemId);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
