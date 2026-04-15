package com.reusehub.util;

import com.reusehub.db.DBConnection;
import java.sql.Connection;
import java.sql.SQLException;

/**
 * Utility wrapper around DBConnection.
 * All DAOs can use either DBUtil.getConnection() or DBConnection.getConnection().
 */
public class DBUtil {

    public static Connection getConnection() throws SQLException {
        Connection conn = DBConnection.getConnection();
        if (conn == null) {
            throw new SQLException("Failed to obtain database connection. Check Supabase credentials in DBConnection.java");
        }
        return conn;
    }

    public static void close(AutoCloseable... resources) {
        for (AutoCloseable res : resources) {
            if (res != null) {
                try {
                    res.close();
                } catch (Exception e) {
                    // log silently
                }
            }
        }
    }
}
