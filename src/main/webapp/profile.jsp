<%@ page import="model.User" %>
<%@ page import="model.Skill" %>
<%@ page import="dao.SkillDAO" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    SkillDAO skillDAO = new SkillDAO();
    Skill mySkill = skillDAO.getSkillByUserId(user.getUserId());
    String currentOffered = mySkill != null ? mySkill.getSkillOffered() : "";
    String currentWanted = mySkill != null ? mySkill.getSkillWanted() : "";
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Skills | Skill Swap</title>
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>
    <nav class="navbar">
        <a href="dashboard.jsp" class="nav-brand">✨ <span>SkillSwap</span></a>
        <div class="nav-links">
            <a href="dashboard.jsp" class="nav-link">Dashboard</a>
            <a href="profile.jsp" class="nav-link" style="color: var(--text-primary);">My Skills</a>
            <a href="${pageContext.request.contextPath}/match" class="nav-link">Find Matches</a>
            <a href="requests.jsp" class="nav-link">Requests</a>
            <a href="${pageContext.request.contextPath}/logout" class="btn-logout">Logout</a>
        </div>
    </nav>

    <div class="container">
        <div class="center-box">
            <h2>Manage Your Skills</h2>
            <p style="text-align: center;">Define what you can teach and what you want to learn.</p>

            <% String error = request.getParameter("error"); %>
            <% if(error != null) { %>
                <div class="alert alert-error"><%= error %></div>
            <% } %>

            <% String success = request.getParameter("success"); %>
            <% if(success != null) { %>
                <div class="alert alert-success"><%= success %></div>
            <% } %>

            <form action="${pageContext.request.contextPath}/profile" method="post">
                <div class="form-group">
                    <label for="skillOffered">Skill You Offer (e.g. Java, Math, Photoshop)</label>
                    <input type="text" id="skillOffered" name="skillOffered" class="form-control" required value="<%= currentOffered %>" placeholder="What can you teach?">
                </div>
                <div class="form-group">
                    <label for="skillWanted">Skill You Want (e.g. Python, Piano, Spanish)</label>
                    <input type="text" id="skillWanted" name="skillWanted" class="form-control" required value="<%= currentWanted %>" placeholder="What do you want to learn?">
                </div>
                <button type="submit" class="btn">Update Skills</button>
            </form>
        </div>
    </div>
</body>
</html>
