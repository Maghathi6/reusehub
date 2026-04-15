<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Seller Dashboard - ReUse Hub</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
    <script src="<%= request.getContextPath() %>/js/app.js"></script>
</head>
<body>
    <nav class="navbar">
        <div class="nav-brand">♻️ ReUse Hub</div>
        <div class="nav-links">
            <a href="<%= request.getContextPath() %>/sellerDashboard" class="nav-link" style="color:white; font-weight:bold;">Dashboard</a>
            <a href="<%= request.getContextPath() %>/addItem" class="nav-link">Add Item</a>
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
        <c:if test="${not empty sessionScope.error}">
            <div class="alert alert-error">${sessionScope.error}</div>
            <c:remove var="error" scope="session" />
        </c:if>

        <h2 class="mb-4">Seller Overview</h2>
        
        <!-- Summary Cards -->
        <div class="item-grid" style="grid-template-columns: repeat(3, 1fr); margin-bottom: 2rem;">
            <div class="card text-center">
                <h3>Total Listed</h3>
                <div class="mt-4" style="font-size: 2.5rem; font-weight: bold; color: #1f2937;">${totalListed}</div>
            </div>
            <div class="card text-center">
                <h3>Total Sold/Donated</h3>
                <div class="mt-4" style="font-size: 2.5rem; font-weight: bold; color: #22c55e;">${totalSold}</div>
            </div>
            <div class="card text-center">
                <h3>Reward Points</h3>
                <div class="mt-4" style="font-size: 2.5rem; font-weight: bold; color: #ffd700;">${rewardPoints} 🪙</div>
            </div>
        </div>

        <div class="card">
            <div style="display:flex; justify-content:space-between; align-items:center;" class="mb-4">
                <h3>My Listings (Manage)</h3>
                <a href="<%= request.getContextPath() %>/addItem" class="btn btn-primary">+ Add New Item</a>
            </div>

            <table class="table">
                <thead>
                    <tr>
                        <th>Photo</th>
                        <th>Item Name</th>
                        <th>Category</th>
                        <th>Type</th>
                        <th>Price</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:if test="${empty sellerItems}">
                        <tr><td colspan="6" class="text-center text-gray">You haven't listed any items yet.</td></tr>
                    </c:if>
                    <c:forEach var="item" items="${sellerItems}">
                        <tr>
                            <td>
                                <c:choose>
                                    <c:when test="${not empty item.photoUrl}">
                                        <img src="<c:out value='${item.photoUrl}'/>" alt="Thumbnail" class="item-thumbnail">
                                    </c:when>
                                    <c:otherwise>
                                        <div class="item-thumbnail-placeholder">📷</div>
                                    </c:otherwise>
                                </c:choose>
                            </td>
                            <td><c:out value="${item.name}"/></td>
                            <td><c:out value="${item.category}"/></td>
                            <td>
                                <c:if test="${item.type == 'donate'}"><span class="badge badge-free">Donate</span></c:if>
                                <c:if test="${item.type == 'sell'}"><span class="badge" style="background:#e5e7eb; color:#374151;">Sell</span></c:if>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${item.type == 'donate'}"><span class="text-green">Free</span></c:when>
                                    <c:otherwise>₹<fmt:formatNumber value="${item.price}" pattern="#,##0.00"/></c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <c:choose>
                                    <c:when test="${item.isSold == 1}"><span class="text-danger" style="font-weight:bold;">Sold</span></c:when>
                                    <c:otherwise><span class="text-green">Active</span></c:otherwise>
                                </c:choose>
                            </td>
                            <td>
                                <a href="<%= request.getContextPath() %>/editItem?id=${item.id}" class="btn btn-secondary" style="padding:0.25rem 0.5rem; font-size:0.875rem;">Edit</a>
                                <form id="deleteForm_${item.id}" action="<%= request.getContextPath() %>/deleteItem" method="post" style="display:inline;">
                                    <input type="hidden" name="id" value="${item.id}">
                                    <button type="button" onclick="confirmDelete(${item.id})" class="btn btn-danger" style="padding:0.25rem 0.5rem; font-size:0.875rem;">Delete</button>
                                </form>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </div>
</body>
</html>
