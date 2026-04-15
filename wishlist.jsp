<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Wishlist - ReUse Hub</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>
    <nav class="navbar">
        <div class="nav-brand">♻️ ReUse Hub</div>
        <div class="nav-links">
            <c:if test="${sessionScope.user.role == 'buyer'}">
                <a href="<%= request.getContextPath() %>/buyerDashboard" class="nav-link">Home</a>
            </c:if>
            <a href="<%= request.getContextPath() %>/wishlist" class="nav-link" style="color:white; font-weight:bold;">Wishlist</a>
            <a href="<%= request.getContextPath() %>/logout" class="nav-link">Logout</a>
        </div>
    </nav>

    <div class="container">
        <h2 class="mb-4">My Wishlist ❤️</h2>

        <c:if test="${not empty sessionScope.success}">
            <div class="alert alert-success">${sessionScope.success}</div>
            <c:remove var="success" scope="session" />
        </c:if>

        <div class="item-grid">
            <c:if test="${empty wishlistItems}">
                <p class="text-gray" style="grid-column: 1 / -1; padding: 2rem;">Your wishlist is empty. Go find some awesome stuff!</p>
            </c:if>

            <c:forEach var="item" items="${wishlistItems}">
                <div class="item-card bg-white">
                    <c:if test="${item.type == 'donate'}">
                        <div class="badge-donated">DONATED</div>
                    </c:if>
                    
                    <h3><c:out value="${item.name}"/></h3>
                    
                    <c:choose>
                        <c:when test="${item.type == 'donate'}">
                            <div class="item-price text-green">FREE</div>
                        </c:when>
                        <c:otherwise>
                            <div class="item-price">₹<fmt:formatNumber value="${item.price}" pattern="#,##0.00"/></div>
                        </c:otherwise>
                    </c:choose>

                    <p class="text-gray mb-1"><strong>Seller:</strong> <c:out value="${item.sellerName}"/></p>
                    
                    <c:if test="${item.isSold == 1}">
                        <div class="badge badge-sold mb-2" style="align-self: flex-start;">SOLD OUT</div>
                    </c:if>

                    <div class="item-actions mt-4">
                        <form action="<%= request.getContextPath() %>/addWishlist" method="post" style="flex:1;">
                            <input type="hidden" name="itemId" value="${item.id}">
                            <input type="hidden" name="action" value="remove">
                            <button type="submit" class="btn btn-secondary btn-block">Remove</button>
                        </form>
                        <a href="<%= request.getContextPath() %>/itemDetail?id=${item.id}" class="btn btn-primary" style="flex:1; margin-top:1rem; display:block;">Details</a>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</body>
</html>
