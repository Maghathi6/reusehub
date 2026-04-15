package com.reusehub.dao;

import com.reusehub.util.DBUtil;
import com.reusehub.model.Item;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class ItemDAO {

    public boolean addItem(Item item) {
        String sql = "INSERT INTO items (seller_id, name, category, condition_type, type, price, description, is_sold, photo_url) VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, item.getSellerId());
            ps.setString(2, item.getName());
            ps.setString(3, item.getCategory());
            ps.setString(4, item.getConditionType());
            ps.setString(5, item.getType());
            ps.setDouble(6, item.getPrice());
            ps.setString(7, item.getDescription());
            ps.setInt(8, 0); // is_sold = 0 by default
            ps.setString(9, item.getPhotoUrl());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<Item> getAllItems() {
        return getItemsQuery("SELECT i.*, u.name as sellerName, u.email as sellerEmail FROM items i JOIN users u ON i.seller_id = u.id ORDER BY i.created_at DESC", null);
    }

    public List<Item> getItemsByKeyword(String keyword) {
        String sql = "SELECT i.*, u.name as sellerName, u.email as sellerEmail FROM items i JOIN users u ON i.seller_id = u.id WHERE i.name LIKE ? ORDER BY i.created_at DESC";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, "%" + keyword + "%");
            return extractItems(ps.executeQuery());
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return new ArrayList<>();
    }

    public List<Item> getItemsByFilter(String category, String condition, String type) {
        StringBuilder sql = new StringBuilder("SELECT i.*, u.name as sellerName, u.email as sellerEmail FROM items i JOIN users u ON i.seller_id = u.id WHERE 1=1");
        List<String> params = new ArrayList<>();
        
        if (category != null && !category.isEmpty()) {
            sql.append(" AND i.category = ?");
            params.add(category);
        }
        if (condition != null && !condition.isEmpty()) {
            sql.append(" AND i.condition_type = ?");
            params.add(condition);
        }
        if (type != null && !type.isEmpty()) {
            sql.append(" AND i.type = ?");
            params.add(type);
        }
        sql.append(" ORDER BY i.created_at DESC");

        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql.toString())) {
            for (int i = 0; i < params.size(); i++) {
                ps.setString(i + 1, params.get(i));
            }
            return extractItems(ps.executeQuery());
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return new ArrayList<>();
    }

    public Item getItemById(int id) {
        String sql = "SELECT i.*, u.name as sellerName, u.email as sellerEmail FROM items i JOIN users u ON i.seller_id = u.id WHERE i.id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            List<Item> items = extractItems(ps.executeQuery());
            if (!items.isEmpty()) return items.get(0);
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Item> getItemsBySeller(int sellerId) {
        String sql = "SELECT i.*, u.name as sellerName, u.email as sellerEmail FROM items i JOIN users u ON i.seller_id = u.id WHERE i.seller_id = ? ORDER BY i.created_at DESC";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, sellerId);
            return extractItems(ps.executeQuery());
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return new ArrayList<>();
    }

    public boolean updateItem(Item item) {
        String sql = "UPDATE items SET name=?, category=?, condition_type=?, type=?, price=?, description=?, photo_url=? WHERE id=?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, item.getName());
            ps.setString(2, item.getCategory());
            ps.setString(3, item.getConditionType());
            ps.setString(4, item.getType());
            ps.setDouble(5, item.getPrice());
            ps.setString(6, item.getDescription());
            ps.setString(7, item.getPhotoUrl());
            ps.setInt(8, item.getId());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean deleteItem(int id) {
        String sql = "DELETE FROM items WHERE id=?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean markAsSold(int id) {
        String sql = "UPDATE items SET is_sold = 1 WHERE id=?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    private List<Item> getItemsQuery(String sql, String param) {
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            if (param != null) ps.setString(1, param);
            return extractItems(ps.executeQuery());
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return new ArrayList<>();
    }

    private List<Item> extractItems(ResultSet rs) throws SQLException {
        List<Item> list = new ArrayList<>();
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
            i.setPhotoUrl(rs.getString("photo_url"));
            // joined fields
            i.setSellerName(rs.getString("sellerName"));
            i.setSellerEmail(rs.getString("sellerEmail"));
            list.add(i);
        }
        return list;
    }
}
