package controller;

import java.io.IOException;

import dao.SkillDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import model.Skill;
import model.User;

@WebServlet("/profile")
public class ProfileServlet extends HttpServlet {
    private static final long serialVersionUID = 1L;
	private SkillDAO skillDAO;

    public void init() {
        skillDAO = new SkillDAO();
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        String skillOffered = request.getParameter("skillOffered");
        String skillWanted = request.getParameter("skillWanted");

        Skill skill = new Skill();
        skill.setUserId(user.getUserId());
        skill.setSkillOffered(skillOffered);
        skill.setSkillWanted(skillWanted);

        boolean success = skillDAO.addOrUpdateSkill(skill);

        if (success) {
            response.sendRedirect("profile.jsp?success=Skills updated successfully");
        } else {
            response.sendRedirect("profile.jsp?error=Failed to update skills");
        }
    }
}
