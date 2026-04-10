<%@ page import="model.User" %>
<%@ page import="model.Request" %>
<%@ page import="dao.RequestDAO" %>
<%@ page import="java.util.List" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
    User user = (User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    RequestDAO requestDAO = new RequestDAO();
    List<Request> incomingRequests = requestDAO.getIncomingRequests(user.getUserId());
    List<Request> outgoingRequests = requestDAO.getOutgoingRequests(user.getUserId());
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Requests | Skill Swap</title>
    <link rel="stylesheet" href="css/styles.css">
</head>
<body>
    <nav class="navbar">
        <a href="dashboard.jsp" class="nav-brand">✨ <span>SkillSwap</span></a>
        <div class="nav-links">
            <a href="dashboard.jsp" class="nav-link">Dashboard</a>
            <a href="profile.jsp" class="nav-link">My Skills</a>
            <a href="${pageContext.request.contextPath}/match" class="nav-link">Find Matches</a>
            <a href="requests.jsp" class="nav-link" style="color: var(--text-primary);">Requests</a>
            <a href="${pageContext.request.contextPath}/logout" class="btn-logout">Logout</a>
        </div>
    </nav>

    <div class="container">
        <h1>Connection Requests 📬</h1>

        <% String error = request.getParameter("error"); %>
        <% if(error != null) { %>
            <div class="alert alert-error"><%= error %></div>
        <% } %>

        <% String success = request.getParameter("success"); %>
        <% if(success != null) { %>
            <div class="alert alert-success"><%= success %></div>
        <% } %>

        <div style="margin-top: 3rem;">
            <h2>Incoming Requests</h2>
            <% if (incomingRequests.isEmpty()) { %>
                <p>You have no pending incoming requests.</p>
            <% } else { %>
                <div class="table-container">
                    <table>
                        <thead>
                            <tr>
                                <th>From User</th>
                                <th>Email</th>
                                <th>Status</th>
                                <th>Action</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (Request req : incomingRequests) { %>
                                <tr>
                                    <td><%= req.getSender().getName() %></td>
                                    <td>
                                        <% if("Accepted".equals(req.getStatus())) { %>
                                            <a href="mailto:<%= req.getSender().getEmail() %>" style="color: var(--primary-color)"><%= req.getSender().getEmail() %></a>
                                        <% } else { %>
                                            Can view after accepting
                                        <% } %>
                                    </td>
                                    <td><span class="status <%= req.getStatus().toLowerCase() %>"><%= req.getStatus() %></span></td>
                                    <td>
                                        <% if ("Pending".equals(req.getStatus())) { %>
                                            <div style="display: flex; gap: 0.5rem;">
                                                <form action="${pageContext.request.contextPath}/request" method="post">
                                                    <input type="hidden" name="action" value="update">
                                                    <input type="hidden" name="requestId" value="<%= req.getRequestId() %>">
                                                    <input type="hidden" name="status" value="Accepted">
                                                    <button type="submit" class="btn" style="padding: 0.4rem 1rem;">Accept</button>
                                                </form>
                                                <form action="${pageContext.request.contextPath}/request" method="post">
                                                    <input type="hidden" name="action" value="update">
                                                    <input type="hidden" name="requestId" value="<%= req.getRequestId() %>">
                                                    <input type="hidden" name="status" value="Rejected">
                                                    <button type="submit" class="btn btn-secondary" style="padding: 0.4rem 1rem;">Reject</button>
                                                </form>
                                            </div>
                                        <% } else { %>
                                            - 
                                        <% } %>
                                    </td>
                                </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            <% } %>
        </div>

        <div style="margin-top: 4rem;">
            <h2>Sent Requests</h2>
            <% if (outgoingRequests.isEmpty()) { %>
                <p>You haven't sent any requests yet.</p>
            <% } else { %>
                <div class="table-container">
                    <table>
                        <thead>
                            <tr>
                                <th>To User</th>
                                <th>Contact Email</th>
                                <th>Status</th>
                            </tr>
                        </thead>
                        <tbody>
                            <% for (Request req : outgoingRequests) { %>
                                <tr>
                                    <td><%= req.getReceiver().getName() %></td>
                                    <td>
                                        <% if("Accepted".equals(req.getStatus())) { %>
                                            <a href="mailto:<%= req.getReceiver().getEmail() %>" style="color: var(--primary-color)"><%= req.getReceiver().getEmail() %></a>
                                        <% } else { %>
                                            Waiting for approval
                                        <% } %>
                                    </td>
                                    <td><span class="status <%= req.getStatus().toLowerCase() %>"><%= req.getStatus() %></span></td>
                                </tr>
                            <% } %>
                        </tbody>
                    </table>
                </div>
            <% } %>
        </div>
    </div>
</body>
</html>
