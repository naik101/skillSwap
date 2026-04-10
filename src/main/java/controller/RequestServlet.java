package controller;

import java.io.IOException;

import dao.RequestDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.User;

@WebServlet("/request")
public class RequestServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
	private RequestDAO requestDAO;

    public void init() {
        requestDAO = new RequestDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        String action = request.getParameter("action");

        if ("send".equals(action)) {
            int receiverId = Integer.parseInt(request.getParameter("receiverId"));
            boolean success = requestDAO.sendRequest(user.getUserId(), receiverId);
            if(success) {
                response.sendRedirect("match?success=Request sent successfully");
            } else {
                response.sendRedirect("match?error=Failed to send request or request already sent");
            }
        } else if ("update".equals(action)) {
            int requestId = Integer.parseInt(request.getParameter("requestId"));
            String status = request.getParameter("status"); // 'Accepted' or 'Rejected'
            boolean success = requestDAO.updateRequestStatus(requestId, status);
            if(success) {
                response.sendRedirect("requests.jsp?success=Request " + status + " successfully");
            } else {
                response.sendRedirect("requests.jsp?error=Failed to update request");
            }
        }
    }
}
