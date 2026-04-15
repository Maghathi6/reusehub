package com.reusehub.model;

public class RewardLog {
    private int id;
    private int userId;
    private String eventType;
    private int pointsEarned;
    private String createdAt;

    public RewardLog() {}

    public RewardLog(int id, int userId, String eventType, int pointsEarned, String createdAt) {
        this.id = id;
        this.userId = userId;
        this.eventType = eventType;
        this.pointsEarned = pointsEarned;
        this.createdAt = createdAt;
    }

    public int getId() { return id; }
    public void setId(int id) { this.id = id; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getEventType() { return eventType; }
    public void setEventType(String eventType) { this.eventType = eventType; }

    public int getPointsEarned() { return pointsEarned; }
    public void setPointsEarned(int pointsEarned) { this.pointsEarned = pointsEarned; }

    public String getCreatedAt() { return createdAt; }
    public void setCreatedAt(String createdAt) { this.createdAt = createdAt; }
}
