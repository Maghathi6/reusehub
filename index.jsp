<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ReUse Hub - Buy. Sell. Donate. Earn.</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
</head>
<body>
    <nav class="navbar">
        <div class="nav-brand">
            <span>♻️</span> ReUse Hub
        </div>
        <div class="nav-links">
            <a href="<%= request.getContextPath() %>/login" class="btn btn-secondary">Login</a>
            <a href="<%= request.getContextPath() %>/jsp/register.jsp" class="btn btn-primary">Register</a>
        </div>
    </nav>

    <div class="container">
        <div class="hero">
            <h1>Buy. Sell. Donate. Earn.</h1>
            <p>Join the community marketplace that rewards you for reducing waste.</p>
            <div style="margin-top: 2rem;">
                <a href="<%= request.getContextPath() %>/jsp/register.jsp" class="btn btn-secondary" style="font-size: 1.25rem;">Get Started Today</a>
            </div>
        </div>

        <div class="item-grid" style="grid-template-columns: repeat(3, 1fr);">
            <div class="card text-center">
                <div style="font-size: 3rem; margin-bottom: 1rem;">♻️</div>
                <h3>Reduce Waste</h3>
                <p class="text-gray mt-4">Give your second-hand items a new life and keep them out of landfills.</p>
            </div>
            <div class="card text-center">
                <div style="font-size: 3rem; margin-bottom: 1rem;">🎁</div>
                <h3>Donate Items</h3>
                <p class="text-gray mt-4">Help the community by listing items for free and earn double the reward points!</p>
            </div>
            <div class="card text-center">
                <div style="font-size: 3rem; margin-bottom: 1rem;">🪙</div>
                <h3>Earn Rewards</h3>
                <p class="text-gray mt-4">Collect points for every action and redeem them for exclusive discounts and perks.</p>
            </div>
        </div>
    </div>
</body>
</html>
