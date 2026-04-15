<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Select Role - ReUse Hub</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>
    <nav class="navbar">
        <div class="nav-brand">♻️ ReUse Hub</div>
        <div class="nav-links">
            <a href="<%= request.getContextPath() %>/logout" class="nav-link">Logout</a>
        </div>
    </nav>

    <div class="container text-center mt-4">
        <h2>Welcome, <c:out value="${sessionScope.user.name}"/>!</h2>
        <p class="text-gray mt-4 mb-4">What would you like to do today?</p>
        
        <div class="role-cards">
            <form action="<%= request.getContextPath() %>/selectRole" method="post" id="buyerForm">
                <input type="hidden" name="role" value="buyer">
                <div class="role-card" onclick="document.getElementById('buyerForm').submit();">
                    <div class="role-icon">🛍️</div>
                    <div class="role-title">I want to BUY</div>
                    <p class="text-gray mt-4">Browse items, add to wishlist, and purchase</p>
                </div>
            </form>
            
            <form action="<%= request.getContextPath() %>/selectRole" method="post" id="sellerForm">
                <input type="hidden" name="role" value="seller">
                <div class="role-card" onclick="document.getElementById('sellerForm').submit();">
                    <div class="role-icon">📦</div>
                    <div class="role-title">I want to SELL</div>
                    <p class="text-gray mt-4">List items, manage inventory, and donate</p>
                </div>
            </form>
        </div>
    </div>
</body>
</html>
