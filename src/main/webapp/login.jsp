<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Log In | Skill Swap</title>
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>
    <div class="container">
        <a href="index.jsp" class="nav-brand" style="justify-content: center; margin-top: 2rem;">✨ <span>SkillSwap</span></a>
        
        <div class="center-box">
            <h2>Welcome Back</h2>
            <p style="text-align: center;">Log in to discover new skill matches.</p>

            <% String error = request.getParameter("error"); %>
            <% if(error != null) { %>
                <div class="alert alert-error"><%= error %></div>
            <% } %>

            <% String success = request.getParameter("success"); %>
            <% if(success != null) { %>
                <div class="alert alert-success"><%= success %></div>
            <% } %>

            <form action="${pageContext.request.contextPath}/login" method="post">
                <div class="form-group">
                    <label for="email">Email Address</label>
                    <input type="email" id="email" name="email" class="form-control" required placeholder="you@example.com">
                </div>
                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" class="form-control" required placeholder="••••••••">
                </div>
                <button type="submit" class="btn">Log In</button>
            </form>

            <div class="auth-links">
                <p>Don't have an account? <a href="register.jsp">Sign up here</a></p>
            </div>
        </div>
    </div>
</body>
</html>
