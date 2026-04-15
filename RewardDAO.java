package com.reusehub.dao;

import com.reusehub.util.DBUtil;
import com.reusehub.model.RewardLog;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class RewardDAO {

    public boolean addRewardLog(int userId, String eventType, int points) {
        String sql = "INSERT INTO reward_log (user_id, event_type, points_earned) VALUES (?, ?, ?)";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ps.setString(2, eventType);
            ps.setInt(3, points);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<RewardLog> getRewardLogByUser(int userId) {
        List<RewardLog> logs = new ArrayList<>();
        String sql = "SELECT * FROM reward_log WHERE user_id = ? ORDER BY created_at DESC";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                RewardLog r = new RewardLog();
                r.setId(rs.getInt("id"));
                r.setUserId(rs.getInt("user_id"));
                r.setEventType(rs.getString("event_type"));
                r.setPointsEarned(rs.getInt("points_earned"));
                r.setCreatedAt(rs.getString("created_at"));
                logs.add(r);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return logs;
    }

    public int getTotalPoints(int userId) {
        String sql = "SELECT reward_points FROM users WHERE id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getInt("reward_points");
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return 0;
    }
}
