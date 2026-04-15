package com.reusehub.util;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
import java.sql.Connection;
import java.sql.Statement;

@WebListener
public class DBInitListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        System.out.println("============================================");
        System.out.println("  ReUse Hub - Verifying Supabase Connection");
        System.out.println("============================================");

        try (Connection conn = DBUtil.getConnection();
             Statement st = conn.createStatement()) {
            System.out.println("[DB] ✅ Connected to Supabase (PostgreSQL) successfully!");
            System.out.println("============================================");
        } catch (Exception e) {
            System.err.println("[DB] ❌ Could not connect to Supabase: " + e.getMessage());
            System.err.println("[DB]    Check DBUtil.java credentials and run schema.sql in Supabase SQL Editor.");
            e.printStackTrace();
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
        System.out.println("[DB] ReUse Hub shutting down.");
    }
}
