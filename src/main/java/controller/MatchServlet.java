package controller;

import java.io.IOException;
import java.util.List;

import dao.SkillDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Skill;
import model.User;

@WebServlet("/match")
public class MatchServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
	private SkillDAO skillDAO;

    public void init() {
        skillDAO = new SkillDAO();
    }

    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        List<Skill> matchedSkills = skillDAO.findMatches(user.getUserId());
        
        request.setAttribute("matches", matchedSkills);
        request.getRequestDispatcher("match.jsp").forward(request, response);
    }
}
