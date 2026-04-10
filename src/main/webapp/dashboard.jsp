<%@ page import="model.User" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard | Skill Swap</title>
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>
    <nav class="navbar">
        <a href="dashboard.jsp" class="nav-brand">✨ <span>SkillSwap</span></a>
        <div class="nav-links">
            <a href="dashboard.jsp" class="nav-link" style="color: var(--text-primary);">Dashboard</a>
            <a href="profile.jsp" class="nav-link">My Skills</a>
            <a href="${pageContext.request.contextPath}/match" class="nav-link">Find Matches</a>
            <a href="requests.jsp" class="nav-link">Requests</a>
            <a href="${pageContext.request.contextPath}/logout" class="btn-logout">Logout</a>
        </div>
    </nav>

    <div class="container">
        <h1>Welcome, <%= user.getName() %>! 👋</h1>
        <p>What would you like to do today?</p>

        <div class="grid-container">
            <div class="card">
                <h3>🛠️ Update Skills</h3>
                <p>Keep your offered and wanted skills up to date to get better matches.</p>
                <div class="card-actions">
                    <a href="profile.jsp" class="btn">Edit Profile</a>
                </div>
            </div>
            
            <div class="card">
                <h3>🔍 Find Partners</h3>
                <p>Look for students who need your skills and can teach you what you want.</p>
                <div class="card-actions">
                    <a href="${pageContext.request.contextPath}/match" class="btn">Explore Matches</a>
                </div>
            </div>

            <div class="card">
                <h3>📬 Manage Requests</h3>
                <p>Check pending requests from others or see the status of your sent requests.</p>
                <div class="card-actions">
                    <a href="requests.jsp" class="btn btn-secondary">View Requests</a>
                </div>
            </div>
        </div>
    </div>
</body>
</html>
