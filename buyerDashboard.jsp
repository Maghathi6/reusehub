<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Buyer Dashboard - ReUse Hub</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>
    <nav class="navbar">
        <div class="nav-brand">♻️ ReUse Hub</div>
        <div class="nav-links">
            <a href="<%= request.getContextPath() %>/buyerDashboard" class="nav-link" style="color:white; font-weight:bold;">Home</a>
            <a href="<%= request.getContextPath() %>/wishlist" class="nav-link">Wishlist</a>
            <a href="<%= request.getContextPath() %>/rewards" class="nav-link">Rewards (<c:out value="${sessionScope.user.rewardPoints}"/> 🪙)</a>
            <a href="<%= request.getContextPath() %>/selectRole" class="nav-link">Switch Role</a>
            <a href="<%= request.getContextPath() %>/logout" class="nav-link">Logout</a>
        </div>
    </nav>

    <div class="container">
        <c:if test="${not empty sessionScope.success}">
            <div class="alert alert-success">${sessionScope.success}</div>
            <c:remove var="success" scope="session" />
        </c:if>

        <!-- Search and Filter Bar -->
        <form action="<%= request.getContextPath() %>/buyerDashboard" method="get" class="filter-bar mb-4">
            <input type="text" name="keyword" class="form-control search-input" placeholder="Search items..." value="${param.keyword}">
            
            <select name="category" class="form-control" style="flex:1;">
                <option value="">All Categories</option>
                <option value="Electronics" ${param.category == 'Electronics' ? 'selected' : ''}>Electronics</option>
                <option value="Clothing" ${param.category == 'Clothing' ? 'selected' : ''}>Clothing</option>
                <option value="Furniture" ${param.category == 'Furniture' ? 'selected' : ''}>Furniture</option>
                <option value="Books" ${param.category == 'Books' ? 'selected' : ''}>Books</option>
                <option value="Toys" ${param.category == 'Toys' ? 'selected' : ''}>Toys</option>
                <option value="Other" ${param.category == 'Other' ? 'selected' : ''}>Other</option>
            </select>

            <select name="condition" class="form-control" style="flex:1;">
                <option value="">All Conditions</option>
                <option value="New" ${param.condition == 'New' ? 'selected' : ''}>New</option>
                <option value="Like New" ${param.condition == 'Like New' ? 'selected' : ''}>Like New</option>
                <option value="Good" ${param.condition == 'Good' ? 'selected' : ''}>Good</option>
                <option value="Fair" ${param.condition == 'Fair' ? 'selected' : ''}>Fair</option>
            </select>

            <select name="type" class="form-control" style="flex:1;">
                <option value="">All Types</option>
                <option value="sell" ${param.type == 'sell' ? 'selected' : ''}>Buy</option>
                <option value="donate" ${param.type == 'donate' ? 'selected' : ''}>Free/Donate</option>
            </select>

            <button type="submit" class="btn btn-primary">Filter</button>
        </form>

        <!-- Item Grid -->
        <div class="item-grid">
            <c:if test="${empty items}">
                <p class="text-gray text-center" style="grid-column: 1 / -1; padding: 2rem;">No items found matching your criteria.</p>
            </c:if>

            <c:forEach var="item" items="${items}">
                <div class="item-card">
                    <!-- Badges -->
                    <c:if test="${item.type == 'donate'}">
                        <div class="badge-donated">DONATED</div>
                    </c:if>
                    
                    <div class="item-image-container">
                        <c:choose>
                            <c:when test="${not empty item.photoUrl}">
                                <img src="<c:out value='${item.photoUrl}'/>" alt="<c:out value='${item.name}'/>" class="item-img">
                            </c:when>
                            <c:otherwise>
                                <div class="item-img-placeholder">📷</div>
                            </c:otherwise>
                        </c:choose>
                    </div>

                    <h3><c:out value="${item.name}"/></h3>
                    
                    <c:choose>
                        <c:when test="${item.type == 'donate'}">
                            <div class="item-price text-green">FREE</div>
                        </c:when>
                        <c:otherwise>
                            <div class="item-price">₹<fmt:formatNumber value="${item.price}" pattern="#,##0.00"/></div>
                        </c:otherwise>
                    </c:choose>

                    <p class="text-gray mb-1"><strong>Category:</strong> <c:out value="${item.category}"/></p>
                    <p class="text-gray mb-2"><strong>Condition:</strong> <c:out value="${item.conditionType}"/></p>
                    
                    <c:if test="${item.isSold == 1}">
                        <div class="badge badge-sold mb-2" style="align-self: flex-start;">SOLD OUT</div>
                    </c:if>

                    <div class="item-actions mt-4">
                        <c:if test="${item.isSold == 0}">
                            <form action="<%= request.getContextPath() %>/addWishlist" method="post" style="flex:1;">
                                <input type="hidden" name="itemId" value="${item.id}">
                                <input type="hidden" name="action" value="add">
                                <button type="submit" class="btn btn-secondary btn-block">❤️ Wishlist</button>
                            </form>
                        </c:if>
                        <a href="<%= request.getContextPath() %>/itemDetail?id=${item.id}" class="btn btn-primary" style="flex:1; margin-top:1rem; display:block;">Details</a>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>
</body>
</html>
