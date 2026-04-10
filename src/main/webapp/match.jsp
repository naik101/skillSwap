<%@ page import="model.User" %>
<%@ page import="model.Skill" %>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    // We expect the MatchServlet to set this attribute
    List<Skill> matches = (List<Skill>) request.getAttribute("matches");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Find Matches | Skill Swap</title>
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>
    <nav class="navbar">
        <a href="dashboard.jsp" class="nav-brand">✨ <span>SkillSwap</span></a>
        <div class="nav-links">
            <a href="dashboard.jsp" class="nav-link">Dashboard</a>
            <a href="profile.jsp" class="nav-link">My Skills</a>
            <a href="${pageContext.request.contextPath}/match" class="nav-link" style="color: var(--text-primary);">Find Matches</a>
            <a href="requests.jsp" class="nav-link">Requests</a>
            <a href="${pageContext.request.contextPath}/logout" class="btn-logout">Logout</a>
        </div>
    </nav>

    <div class="container">
        <h1>Your Skill Matches 🎯</h1>
        <p>These students are offering exactly what you want, and they want what you are offering.</p>

        <% String error = request.getParameter("error"); %>
        <% if(error != null) { %>
            <div class="alert alert-error" style="max-width: 600px;"><%= error %></div>
        <% } %>

        <% String success = request.getParameter("success"); %>
        <% if(success != null) { %>
            <div class="alert alert-success" style="max-width: 600px;"><%= success %></div>
        <% } %>

        <% if (matches == null) { %>
            <div class="empty-state">
                <h2>Opps! Direct access not allowed via JSP.</h2>
                <p>Please access this page by clicking the button below to load the matches properly.</p>
                <a href="${pageContext.request.contextPath}/match" class="btn" style="width: auto; margin-top: 1rem;">Load My Matches</a>
            </div>
        <% } else if (matches.isEmpty()) { %>
            <div class="empty-state">
                <div style="font-size: 3rem; margin-bottom: 1rem;">😢</div>
                <h2>No matches found right now.</h2>
                <p>Ensure you have added your skills in your profile. If you have, check back later as more students join!</p>
                <a href="profile.jsp" class="btn" style="width: auto; margin-top: 1rem;">Check My Skills</a>
            </div>
        <% } else { %>
            <div class="grid-container">
                <% for (Skill match : matches) { %>
                    <div class="card">
                        <h3><%= match.getUser().getName() %></h3>
                        
                        <div class="badges">
                            <span class="badge badge-offer">Offers: <%= match.getSkillOffered() %></span>
                            <span class="badge badge-want">Wants: <%= match.getSkillWanted() %></span>
                        </div>
                        
                        <div class="card-actions">
                            <form action="${pageContext.request.contextPath}/request" method="post" style="width: 100%;">
                                <input type="hidden" name="action" value="send">
                                <input type="hidden" name="receiverId" value="<%= match.getUserId() %>">
                                <button type="submit" class="btn">Send Match Request</button>
                            </form>
                        </div>
                    </div>
                <% } %>
            </div>
        <% } %>
    </div>
</body>
</html>
