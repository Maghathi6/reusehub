<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Payment Successful - ReUse Hub</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body style="background: #f0fdf4;">
    <div class="container" style="display:flex; align-items: center; justify-content: center; min-height: 80vh;">
        <div class="card text-center" style="max-width: 500px; padding: 3rem;">
            <div style="font-size: 5rem; margin-bottom: 2rem;">✅</div>
            <h1 class="text-green">Payment Successful!</h1>
            <p class="text-gray mb-4">Your order for <strong>${item.name}</strong> has been placed successfully.</p>
            
            <div style="background: #f9fafb; padding: 1.5rem; border-radius: 0.75rem; text-align: left; margin-bottom: 2rem; border: 1px solid #e5e7eb;">
                <h4 class="mb-2">Transaction Details</h4>
                <p class="small mb-1"><strong>Item:</strong> ${item.name}</p>
                <p class="small mb-1"><strong>Amount Paid:</strong> ₹<fmt:formatNumber value="${txn.amount}" pattern="#,##0.00"/></p>
                <p class="small mb-1"><strong>Payment Method:</strong> ${txn.paymentMethod}</p>
                <p class="small"><strong>Points Earned:</strong> +${item.type == 'donate' ? '20' : '10'} pts 🪙</p>
            </div>

            <p class="small text-gray mb-4">You can coordinate pickup/delivery with the seller: <br> <strong>${item.sellerEmail}</strong></p>

            <a href="<%= request.getContextPath() %>/buyerDashboard" class="btn btn-primary btn-block">Back to Dashboard</a>
        </div>
    </div>
</body>
</html>
