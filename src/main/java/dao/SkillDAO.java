package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.Skill;
import model.User;
import util.DBConnection;

public class SkillDAO {

    public boolean addOrUpdateSkill(Skill skill) {
        String checkQuery = "SELECT * FROM skills WHERE user_id = ?";
        String insertQuery = "INSERT INTO skills (user_id, skill_offered, skill_wanted) VALUES (?, ?, ?)";
        String updateQuery = "UPDATE skills SET skill_offered = ?, skill_wanted = ? WHERE user_id = ?";
        
        try (Connection con = DBConnection.getConnection();
             PreparedStatement checkPs = con.prepareStatement(checkQuery)) {
            
            checkPs.setInt(1, skill.getUserId());
            ResultSet rs = checkPs.executeQuery();
            
            if (rs.next()) {
                // Update existing
                try (PreparedStatement updatePs = con.prepareStatement(updateQuery)) {
                    updatePs.setString(1, skill.getSkillOffered());
                    updatePs.setString(2, skill.getSkillWanted());
                    updatePs.setInt(3, skill.getUserId());
                    return updatePs.executeUpdate() > 0;
                }
            } else {
                // Insert new
                try (PreparedStatement insertPs = con.prepareStatement(insertQuery)) {
                    insertPs.setInt(1, skill.getUserId());
                    insertPs.setString(2, skill.getSkillOffered());
                    insertPs.setString(3, skill.getSkillWanted());
                    return insertPs.executeUpdate() > 0;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public Skill getSkillByUserId(int userId) {
        String query = "SELECT * FROM skills WHERE user_id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return new Skill(rs.getInt("skill_id"), rs.getInt("user_id"), rs.getString("skill_offered"), rs.getString("skill_wanted"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<Skill> findMatches(int userId) {
        List<Skill> matches = new ArrayList<>();
        // Get the current user's skills
        Skill mySkill = getSkillByUserId(userId);
        if (mySkill == null) return matches;

        // Match Logic: 
        // Find users where their 'skill_offered' matches my 'skill_wanted'
        // AND their 'skill_wanted' matches my 'skill_offered'
        String query = "SELECT s.*, u.name, u.email FROM skills s JOIN users u ON s.user_id = u.user_id " +
                       "WHERE s.user_id != ? AND LOWER(s.skill_offered) = LOWER(?) AND LOWER(s.skill_wanted) = LOWER(?)";
                       
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            ps.setInt(1, userId);
            ps.setString(2, mySkill.getSkillWanted());
            ps.setString(3, mySkill.getSkillOffered());
            
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Skill match = new Skill(rs.getInt("skill_id"), rs.getInt("user_id"), rs.getString("skill_offered"), rs.getString("skill_wanted"));
                User matchUser = new User(rs.getInt("user_id"), rs.getString("name"), rs.getString("email"), null);
                match.setUser(matchUser);
                matches.add(match);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return matches;
    }
}
