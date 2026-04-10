<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register | Skill Swap</title>
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>
    <div class="container">
        <a href="index.jsp" class="nav-brand" style="justify-content: center; margin-top: 2rem;">✨ <span>SkillSwap</span></a>
        
        <div class="center-box">
            <h2>Create Account</h2>
            <p style="text-align: center;">Join our student learning community.</p>

            <% String error = request.getParameter("error"); %>
            <% if(error != null) { %>
                <div class="alert alert-error"><%= error %></div>
            <% } %>

            <form action="${pageContext.request.contextPath}/register" method="post">
                <div class="form-group">
                    <label for="name">Full Name</label>
                    <input type="text" id="name" name="name" class="form-control" required placeholder="John Doe">
                </div>
                <div class="form-group">
                    <label for="email">Email Address</label>
                    <input type="email" id="email" name="email" class="form-control" required placeholder="you@example.com">
                </div>
                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" class="form-control" required placeholder="••••••••" minlength="4">
                </div>
                <button type="submit" class="btn">Sign Up</button>
            </form>

            <div class="auth-links">
                <p>Already have an account? <a href="login.jsp">Log in here</a></p>
            </div>
        </div>
    </div>
</body>
</html>
