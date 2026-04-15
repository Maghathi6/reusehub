<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>My Rewards - ReUse Hub</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>
    <nav class="navbar">
        <div class="nav-brand">♻️ ReUse Hub</div>
        <div class="nav-links">
            <c:if test="${sessionScope.user.role == 'buyer'}">
                <a href="<%= request.getContextPath() %>/buyerDashboard" class="nav-link">Home</a>
            </c:if>
            <c:if test="${sessionScope.user.role == 'seller'}">
                <a href="<%= request.getContextPath() %>/sellerDashboard" class="nav-link">Dashboard</a>
            </c:if>
            <a href="<%= request.getContextPath() %>/logout" class="nav-link">Logout</a>
        </div>
    </nav>

    <div class="container">
        <div class="card text-center mb-4" style="max-width: 600px; margin: 0 auto;">
            <div class="medal tier-<c:out value="${tier.toLowerCase()}"/>">🪙</div>
            <h1 class="mb-2"><c:out value="${totalPoints}"/> Points</h1>
            <h3 class="tier-<c:out value="${tier.toLowerCase()}"/>"><c:out value="${tier}"/> Tier User</h3>
            
            <p class="text-gray mt-4 mb-2">Progress to next tier:</p>
            <div class="progress-container">
                <c:choose>
                    <c:when test="${totalPoints < 100}">
                        <div class="progress-bar" style="width: ${totalPoints}%;"></div>
                    </c:when>
                    <c:when test="${totalPoints < 300}">
                        <div class="progress-bar" style="width: ${(totalPoints - 100) / 200 * 100}%;"></div>
                    </c:when>
                    <c:otherwise>
                        <div class="progress-bar" style="width: 100%;"></div>
                    </c:otherwise>
                </c:choose>
            </div>
            <p class="text-gray" style="font-size: 0.875rem;">
                Bronze (0-99) &rarr; Silver (100-299) &rarr; Gold (300+)
            </p>
        </div>

        <div style="display:flex; gap: 2rem; flex-wrap: wrap; margin-top: 4rem;">
            <!-- Rewards Tiers Info -->
            <div class="card" style="flex: 1; min-width: 300px;">
                <h3>Unlockable Perks</h3>
                <ul class="text-gray mt-4" style="line-height: 2;">
                    <li>🥉 <strong>Bronze:</strong> Standard access.</li>
                    <li>🥈 <strong>Silver (100 pts):</strong> 10% Discount on selected items.</li>
                    <li>🥇 <strong>Gold (300 pts):</strong> One Free Item Coupon & Priority listed seller badge.</li>
                </ul>
            </div>

            <!-- Reward History -->
            <div class="card" style="flex: 2; min-width: 400px;">
                <h3>Reward History</h3>
                <table class="table mt-4">
                    <thead>
                        <tr>
                            <th>Action</th>
                            <th>Points</th>
                            <th>Date</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:if test="${empty rewardLogList}">
                            <tr><td colspan="3" class="text-center text-gray">No rewards earned yet.</td></tr>
                        </c:if>
                        <c:forEach var="log" items="${rewardLogList}">
                            <tr>
                                <td><c:out value="${log.eventType}"/></td>
                                <td class="text-green font-bold">+<c:out value="${log.pointsEarned}"/></td>
                                <td><c:out value="${log.createdAt}"/></td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</body>
</html>
