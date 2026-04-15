package com.reusehub.dao;

import com.reusehub.model.Transaction;
import com.reusehub.util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class TransactionDAO {

    public boolean addTransaction(Transaction txn) {
        String sql = "INSERT INTO transactions (buyer_id, seller_id, item_id, amount, payment_method) VALUES (?, ?, ?, ?, ?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, txn.getBuyerId());
            ps.setInt(2, txn.getSellerId());
            ps.setInt(3, txn.getItemId());
            ps.setDouble(4, txn.getAmount());
            ps.setString(5, txn.getPaymentMethod());
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }
}
