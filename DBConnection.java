package com.reusehub.db;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    // =====================================================================
    //  SUPABASE (PostgreSQL) Connection
    //  ⚠️  REPLACE these with your actual Supabase credentials!
    //
    //  Find them at:
    //    Supabase Dashboard → Your Project → Settings → Database
    //    → Connection string → JDBC tab
    // =====================================================================
    private static final String DB_URL      = "jdbc:postgresql://db.kdljonsmtgbwvyxmbwgs.supabase.co:5432/postgres?sslmode=require";
    private static final String DB_USER     = "postgres";
    private static final String DB_PASSWORD = "ReUsEhUb2123";

    static {
        try {
            Class.forName("org.postgresql.Driver");
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("PostgreSQL JDBC Driver not found!", e);
        }
    }

    public static Connection getConnection() {
        Connection conn = null;
        try {
            conn = DriverManager.getConnection(DB_URL, DB_USER, DB_PASSWORD);
        } catch (SQLException e) {
            System.err.println("Database connection failed: " + e.getMessage());
            e.printStackTrace();
        }
        return conn;
    }
}
