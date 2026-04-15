package com.reusehub.util;

import java.sql.Connection;
import java.sql.Statement;

public class DBMigration {
    public static void main(String[] args) {
        System.out.println("Starting Supabase Schema Migration...");
        try (Connection conn = DBUtil.getConnection();
             Statement stmt = conn.createStatement()) {
            
            System.out.println("Adding 'photo_url' column to 'items' table...");
            stmt.execute("ALTER TABLE items ADD COLUMN IF NOT EXISTS photo_url TEXT;");
            
            System.out.println("✅ Supabase successfully updated!");
        } catch (Exception e) {
            System.err.println("❌ Migration failed: " + e.getMessage());
            e.printStackTrace();
        }
    }
}
