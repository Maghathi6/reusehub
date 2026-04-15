<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Login - ReUse Hub</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>
    <nav class="navbar">
        <div class="nav-brand">
            <a href="<%= request.getContextPath() %>/jsp/index.jsp">♻️ ReUse Hub</a>
        </div>
    </nav>

    <div class="container text-center mt-4">
        <div class="card" style="max-width: 400px; margin: 0 auto; text-align: left;">
            <h2 class="mb-4 text-center">Login</h2>
            
            <c:if test="${not empty error}">
                <div class="alert alert-error">${error}</div>
            </c:if>
            <c:if test="${not empty sessionScope.success}">
                <div class="alert alert-success">${sessionScope.success}</div>
                <c:remove var="success" scope="session" />
            </c:if>

            <form action="<%= request.getContextPath() %>/login" method="post">
                <div class="form-group">
                    <label class="form-label">Email</label>
                    <input type="email" name="email" class="form-control" required>
                </div>
                <div class="form-group">
                    <label class="form-label">Password</label>
                    <input type="password" name="password" class="form-control" required>
                </div>
                <button type="submit" class="btn btn-primary btn-block mb-4">Login</button>
            </form>

            <div class="text-center">
                <span class="text-gray">Don't have an account?</span> 
                <a href="<%= request.getContextPath() %>/jsp/register.jsp" class="text-green">Register here</a>
            </div>
        </div>
    </div>
</body>
</html>
