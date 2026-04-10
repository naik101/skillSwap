package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import model.Request;
import model.User;
import util.DBConnection;

public class RequestDAO {

    public boolean sendRequest(int senderId, int receiverId) {
        // Check if request already exists
        String checkQuery = "SELECT * FROM requests WHERE sender_id = ? AND receiver_id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement checkPs = con.prepareStatement(checkQuery)) {
            checkPs.setInt(1, senderId);
            checkPs.setInt(2, receiverId);
            ResultSet rs = checkPs.executeQuery();
            if (rs.next()) {
                return false; // Request already sent
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        String query = "INSERT INTO requests (sender_id, receiver_id, status) VALUES (?, ?, 'Pending')";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            ps.setInt(1, senderId);
            ps.setInt(2, receiverId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public boolean updateRequestStatus(int requestId, String status) {
        String query = "UPDATE requests SET status = ? WHERE request_id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            ps.setString(1, status);
            ps.setInt(2, requestId);
            return ps.executeUpdate() > 0;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    public List<Request> getIncomingRequests(int receiverId) {
        List<Request> requests = new ArrayList<>();
        String query = "SELECT r.*, u.name as sender_name, u.email as sender_email " +
                       "FROM requests r JOIN users u ON r.sender_id = u.user_id " +
                       "WHERE r.receiver_id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            ps.setInt(1, receiverId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Request req = new Request(rs.getInt("request_id"), rs.getInt("sender_id"), rs.getInt("receiver_id"), rs.getString("status"));
                User sender = new User(rs.getInt("sender_id"), rs.getString("sender_name"), rs.getString("sender_email"), null);
                req.setSender(sender);
                requests.add(req);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return requests;
    }
    
    public List<Request> getOutgoingRequests(int senderId) {
        List<Request> requests = new ArrayList<>();
        String query = "SELECT r.*, u.name as receiver_name, u.email as receiver_email " +
                       "FROM requests r JOIN users u ON r.receiver_id = u.user_id " +
                       "WHERE r.sender_id = ?";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(query)) {
            ps.setInt(1, senderId);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Request req = new Request(rs.getInt("request_id"), rs.getInt("sender_id"), rs.getInt("receiver_id"), rs.getString("status"));
                User receiver = new User(rs.getInt("receiver_id"), rs.getString("receiver_name"), rs.getString("receiver_email"), null);
                req.setReceiver(receiver);
                requests.add(req);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return requests;
    }
}
