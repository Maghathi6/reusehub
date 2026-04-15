准确<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Checkout - ReUse Hub</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
    <style>
        .payment-option {
            border: 2px solid #e5e7eb;
            border-radius: 0.75rem;
            padding: 1rem;
            margin-bottom: 1rem;
            cursor: pointer;
            transition: all 0.2s;
            display: flex;
            align-items: center;
            gap: 1rem;
        }
        .payment-option:hover { border-color: #059669; background: #f0fdf4; }
        .payment-option input[type="radio"] { width: 20px; height: 20px; accent-color: #059669; }
        .payment-option label { cursor: pointer; font-weight: 500; flex: 1; }
        .payment-badge { font-size: 0.75rem; padding: 2px 8px; border-radius: 1rem; background: #e5e7eb; }
    </style>
</head>
<body>
    <nav class="navbar">
        <div class="nav-brand">
            <a href="<%= request.getContextPath() %>/buyerDashboard">♻️ ReUse Hub</a>
        </div>
        <div class="nav-links">
            <span class="nav-link">Secure Checkout</span>
        </div>
    </nav>

    <div class="container mt-4 mb-4">
        <div style="display: grid; grid-template-columns: 1.5fr 1fr; gap: 2rem; align-items: start;">
            
            <!-- Left: Payment Method -->
            <div class="card">
                <h2 class="mb-4">Select Payment Method</h2>
                <form action="<%= request.getContextPath() %>/purchase" method="post" id="paymentForm">
                    <input type="hidden" name="itemId" value="${item.id}">
                    
                    <div class="payment-option">
                        <input type="radio" id="upi" name="paymentMethod" value="UPI" checked>
                        <label for="upi">
                            <div>UPI (GPay / PhonePe / Paytm)</div>
                            <span class="payment-badge">Instant</span>
                        </label>
                        <span style="font-size: 1.5rem;">📱</span>
                    </div>

                    <div class="payment-option">
                        <input type="radio" id="card" name="paymentMethod" value="Credit/Debit Card">
                        <label for="card">
                            <div>Credit / Debit Card</div>
                            <span class="payment-badge">Visa/Mastercard</span>
                        </label>
                        <span style="font-size: 1.5rem;">💳</span>
                    </div>

                    <div class="payment-option">
                        <input type="radio" id="points" name="paymentMethod" value="Reward Points">
                        <label for="points">
                            <div>Reward Points</div>
                            <span class="payment-badge">Available: ${sessionScope.user.rewardPoints} pts</span>
                        </label>
                        <span style="font-size: 1.5rem;">🪙</span>
                    </div>

                    <p class="text-gray mt-4 small">
                        * This is a simulation. No real money will be charged.
                    </p>

                    <button type="submit" class="btn btn-primary btn-block mt-4" style="font-size: 1.1rem; padding: 1rem;">
                        Complete Purchase
                    </button>
                    <a href="javascript:history.back()" class="btn btn-secondary btn-block mt-2">Cancel</a>
                </form>
            </div>

            <!-- Right: Order Summary -->
            <div>
                <div class="card">
                    <h3 class="mb-4">Order Summary</h3>
                    <div style="display:flex; gap: 1rem; margin-bottom: 1.5rem;">
                        <img src="${item.photoUrl != null ? item.photoUrl : 'https://via.placeholder.com/80'}" 
                             style="width: 80px; height: 80px; object-fit: cover; border-radius: 8px;">
                        <div>
                            <div style="font-weight: 600;">${item.name}</div>
                            <div class="text-gray small">${item.category}</div>
                        </div>
                    </div>
                    
                    <hr>
                    
                    <div style="display:flex; justify-content: space-between; margin: 1rem 0;">
                        <span>Price</span>
                        <span>₹<fmt:formatNumber value="${item.price}" pattern="#,##0.00"/></span>
                    </div>
                    <div style="display:flex; justify-content: space-between; margin: 1rem 0;">
                        <span>Processing Fee</span>
                        <span class="text-green">FREE</span>
                    </div>
                    
                    <hr>
                    
                    <div style="display:flex; justify-content: space-between; margin: 1rem 0; font-size: 1.25rem; font-weight: 700;">
                        <span>Total Pay</span>
                        <span>₹<fmt:formatNumber value="${item.price}" pattern="#,##0.00"/></span>
                    </div>

                    <div style="background: #ecfdf5; padding: 1rem; border-radius: 8px; margin-top: 1.5rem; text-align: center;">
                        <span class="text-green" style="font-weight: 600;">✨ You'll earn ${item.type == 'donate' ? '20' : '10'} Reward Points!</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
