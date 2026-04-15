<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <title>Error - ReUse Hub</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/style.css">
</head>
<body>
    <div class="container text-center mt-4">
        <div class="card" style="max-width: 500px; margin: 0 auto;">
            <h1 class="text-danger mb-4">Oops! Something went wrong.</h1>
            <p class="mb-4 text-gray">We couldn't process your request. Please try again.</p>
            <a href="<%= request.getContextPath() %>/jsp/index.jsp" class="btn btn-primary">Go to Home</a>
        </div>
    </div>
</body>
</html>
