-- =====================================================================
--  ReUse Hub - PostgreSQL / Supabase Schema
--  Run this in the Supabase Dashboard → SQL Editor
-- =====================================================================

-- Users table
CREATE TABLE IF NOT EXISTS users (
    id            SERIAL PRIMARY KEY,
    name          VARCHAR(100) NOT NULL,
    email         VARCHAR(100) UNIQUE NOT NULL,
    password      VARCHAR(255) NOT NULL,
    role          VARCHAR(10) DEFAULT NULL,
    reward_points INT DEFAULT 0,
    created_at    TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Items table
CREATE TABLE IF NOT EXISTS items (
    id             SERIAL PRIMARY KEY,
    seller_id      INT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    name           VARCHAR(150) NOT NULL,
    category       VARCHAR(50),
    condition_type VARCHAR(50),
    type           VARCHAR(10) NOT NULL,  -- 'sell' or 'donate'
    price          DOUBLE PRECISION DEFAULT 0,
    description    TEXT,
    is_sold        INT DEFAULT 0,
    created_at     TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- Wishlist table
CREATE TABLE IF NOT EXISTS wishlist (
    id        SERIAL PRIMARY KEY,
    user_id   INT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    item_id   INT NOT NULL REFERENCES items(id) ON DELETE CASCADE,
    UNIQUE (user_id, item_id)
);

-- Reward log table
CREATE TABLE IF NOT EXISTS reward_log (
    id           SERIAL PRIMARY KEY,
    user_id      INT NOT NULL REFERENCES users(id) ON DELETE CASCADE,
    event_type   VARCHAR(100),
    points_earned INT,
    created_at   TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
