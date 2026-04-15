<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Add New Item - ReUse Hub</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
    <script src="<%= request.getContextPath() %>/js/app.js"></script>
</head>
<body>
    <nav class="navbar">
        <div class="nav-brand">♻️ ReUse Hub</div>
        <div class="nav-links">
            <a href="<%= request.getContextPath() %>/sellerDashboard" class="nav-link">Dashboard</a>
            <a href="<%= request.getContextPath() %>/logout" class="nav-link">Logout</a>
        </div>
    </nav>

    <div class="container text-center mt-4">
        <div class="card" style="max-width: 600px; margin: 0 auto; text-align: left;">
            <h2 class="mb-4 text-center">List an Item</h2>
            
            <c:if test="${not empty error}">
                <div class="alert alert-error">${error}</div>
            </c:if>

            <form action="<%= request.getContextPath() %>/addItem" method="post">
                <div class="form-group">
                    <label class="form-label">Item Name</label>
                    <input type="text" name="name" class="form-control" required>
                </div>

                <div style="display:flex; gap:1rem;" class="mb-2">
                    <div class="form-group" style="flex:1;">
                        <label class="form-label">Category</label>
                        <select name="category" class="form-control" required>
                            <option value="Electronics">Electronics</option>
                            <option value="Clothing">Clothing</option>
                            <option value="Furniture">Furniture</option>
                            <option value="Books">Books</option>
                            <option value="Toys">Toys</option>
                            <option value="Other">Other</option>
                        </select>
                    </div>
                    <div class="form-group" style="flex:1;">
                        <label class="form-label">Condition</label>
                        <select name="condition" class="form-control" required>
                            <option value="New">New</option>
                            <option value="Like New">Like New</option>
                            <option value="Good">Good</option>
                            <option value="Fair">Fair</option>
                        </select>
                    </div>
                </div>

                <div class="form-group">
                    <label class="form-label">Listing Type</label>
                    <div style="display:flex; gap:2rem;">
                        <label><input type="radio" name="type" value="sell" checked> Sell for Money 💰</label>
                        <label><input type="radio" name="type" value="donate"> Donate for Free 🎁 (+20 pts)</label>
                    </div>
                </div>

                <div class="form-group" id="priceGroup">
                    <label class="form-label">Price (₹)</label>
                    <input type="number" name="price" id="priceInput" class="form-control" min="0" step="0.01">
                </div>

                <div class="form-group">
                    <label class="form-label">Description</label>
                    <textarea name="description" class="form-control" rows="4"></textarea>
                </div>

                <div class="form-group">
                    <label class="form-label">Photo URL</label>
                    <input type="text" name="photoUrl" class="form-control" value="<c:out value='${item.photoUrl}'/>" placeholder="Paste image link here">
                </div>

                <div id="photoPreviewContainer" style="display:none; margin-top:1rem;">
                    <p class="form-label">Photo Preview:</p>
                    <div class="item-preview-box">
                        <img id="photoPreviewImage" src="" alt="Preview" class="item-img">
                    </div>
                </div>

                <button type="submit" class="btn btn-primary btn-block mb-4 mt-4">List Item</button>
            </form>
        </div>
    </div>
</body>
</html>
