<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Item Detail - ReUse Hub</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>
    <nav class="navbar">
        <div class="nav-brand">
            <a href="<%= request.getContextPath() %>/jsp/index.jsp">♻️ ReUse Hub</a>
        </div>
        <div class="nav-links">
            <a href="javascript:history.back()" class="nav-link">← Back</a>
        </div>
    </nav>

    <div class="container mt-4">
        <c:if test="${not empty item}">
            <div class="card" style="max-width: 800px; margin: 0 auto; display:flex; gap: 2rem; flex-wrap: wrap;">
                
                <div style="flex: 1; min-width: 300px;">
                    <div class="item-detail-image-container">
                        <c:choose>
                            <c:when test="${not empty item.photoUrl}">
                                <img src="<c:out value='${item.photoUrl}'/>" alt="<c:out value='${item.name}'/>" class="item-detail-img">
                            </c:when>
                            <c:otherwise>
                                <div class="item-detail-img-placeholder">📷</div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
                
                <div style="flex: 1; min-width: 300px;">
                    <h2><c:out value="${item.name}"/></h2>
                    
                    <c:choose>
                        <c:when test="${item.type == 'donate'}">
                            <div class="item-price text-green" style="font-size: 2rem;">FREE</div>
                            <span class="badge badge-free mb-4">Donated</span>
                        </c:when>
                        <c:otherwise>
                            <div class="item-price" style="font-size: 2rem;">₹<fmt:formatNumber value="${item.price}" pattern="#,##0.00"/></div>
                        </c:otherwise>
                    </c:choose>

                    <p class="text-gray mb-1"><strong>Category:</strong> <c:out value="${item.category}"/></p>
                    <p class="text-gray mb-1"><strong>Condition:</strong> <c:out value="${item.conditionType}"/></p>
                    <p class="text-gray mb-4"><strong>Listed on:</strong> <c:out value="${item.createdAt}"/></p>

                    <h4>Description</h4>
                    <p class="text-gray" style="white-space: pre-line; margin-bottom: 2rem;"><c:out value="${item.description}"/></p>

                    <div style="background: #f9fafb; padding: 1rem; border-radius: 0.5rem; margin-bottom: 2rem; border: 1px solid #e5e7eb;">
                        <h4>Seller Contact</h4>
                        <p class="mb-1">Name: <c:out value="${item.sellerName}"/></p>
                        <p>Email: <a href="mailto:<c:out value='${item.sellerEmail}'/>" class="text-green"><c:out value="${item.sellerEmail}"/></a></p>
                    </div>
                    
                    <c:if test="${sessionScope.user.role == 'buyer'}">
                        <div style="display:flex; gap: 1rem; flex-wrap: wrap;">
                            <c:if test="${item.isSold == 0}">
                                <form action="<%= request.getContextPath() %>/addWishlist" method="post" style="flex:1;">
                                    <input type="hidden" name="itemId" value="${item.id}">
                                    <c:choose>
                                        <c:when test="${isWishlisted}">
                                            <input type="hidden" name="action" value="remove">
                                            <button type="submit" class="btn btn-secondary btn-block mt-0">💔 Remove from Wishlist</button>
                                        </c:when>
                                        <c:otherwise>
                                            <input type="hidden" name="action" value="add">
                                            <button type="submit" class="btn btn-secondary btn-block mt-0">❤️ Add to Wishlist</button>
                                        </c:otherwise>
                                    </c:choose>
                                </form>

                                <a href="<%= request.getContextPath() %>/checkout?itemId=${item.id}" class="btn btn-primary btn-block mt-0" style="flex:1; text-align:center;">Buy Now</a>
                            </c:if>
                            
                            <c:if test="${item.isSold == 1}">
                                <div class="alert alert-error" style="width: 100%; text-align:center;">This item has already been marked as sold.</div>
                            </c:if>
                        </div>
                    </c:if>
                </div>
            </div>
        </c:if>
    </div>
</body>
</html>
