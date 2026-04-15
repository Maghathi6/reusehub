<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Edit Item - ReUse Hub</title>
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
            <h2 class="mb-4 text-center">Edit Item</h2>

            <form action="<%= request.getContextPath() %>/editItem" method="post">
                <input type="hidden" name="id" value="${item.id}">
                
                <div class="form-group">
                    <label class="form-label">Item Name</label>
                    <input type="text" name="name" class="form-control" value="<c:out value='${item.name}'/>" required>
                </div>

                <div style="display:flex; gap:1rem;" class="mb-2">
                    <div class="form-group" style="flex:1;">
                        <label class="form-label">Category</label>
                        <select name="category" class="form-control" required>
                            <option value="Electronics" ${item.category == 'Electronics' ? 'selected' : ''}>Electronics</option>
                            <option value="Clothing" ${item.category == 'Clothing' ? 'selected' : ''}>Clothing</option>
                            <option value="Furniture" ${item.category == 'Furniture' ? 'selected' : ''}>Furniture</option>
                            <option value="Books" ${item.category == 'Books' ? 'selected' : ''}>Books</option>
                            <option value="Toys" ${item.category == 'Toys' ? 'selected' : ''}>Toys</option>
                            <option value="Other" ${item.category == 'Other' ? 'selected' : ''}>Other</option>
                        </select>
                    </div>
                    <div class="form-group" style="flex:1;">
                        <label class="form-label">Condition</label>
                        <select name="condition" class="form-control" required>
                            <option value="New" ${item.conditionType == 'New' ? 'selected' : ''}>New</option>
                            <option value="Like New" ${item.conditionType == 'Like New' ? 'selected' : ''}>Like New</option>
                            <option value="Good" ${item.conditionType == 'Good' ? 'selected' : ''}>Good</option>
                            <option value="Fair" ${item.conditionType == 'Fair' ? 'selected' : ''}>Fair</option>
                        </select>
                    </div>
                </div>

                <div class="form-group">
                    <label class="form-label">Listing Type</label>
                    <div style="display:flex; gap:2rem;">
                        <label><input type="radio" name="type" value="sell" ${item.type == 'sell' ? 'checked' : ''}> Sell for Money 💰</label>
                        <label><input type="radio" name="type" value="donate" ${item.type == 'donate' ? 'checked' : ''}> Donate for Free 🎁</label>
                    </div>
                </div>

                <div class="form-group" id="priceGroup" style="${item.type == 'donate' ? 'display:none;' : ''}">
                    <label class="form-label">Price (₹)</label>
                    <input type="number" name="price" id="priceInput" class="form-control" min="0" step="0.01" value="${item.price}">
                </div>

                <div class="form-group">
                    <label class="form-label">Description</label>
                    <textarea name="description" class="form-control" rows="4"><c:out value='${item.description}'/></textarea>
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

                <button type="submit" class="btn btn-primary btn-block mb-4 mt-4">Update Item</button>
            </form>
        </div>
    </div>
</body>
</html>
