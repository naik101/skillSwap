package model;

public class Request {
    private int requestId;
    private int senderId;
    private int receiverId;
    private String status;
    private User sender; // Navigation property for UI
    private User receiver; // Navigation property for UI

    public Request() {}

    public Request(int requestId, int senderId, int receiverId, String status) {
        this.requestId = requestId;
        this.senderId = senderId;
        this.receiverId = receiverId;
        this.status = status;
    }

    public int getRequestId() { return requestId; }
    public void setRequestId(int requestId) { this.requestId = requestId; }

    public int getSenderId() { return senderId; }
    public void setSenderId(int senderId) { this.senderId = senderId; }

    public int getReceiverId() { return receiverId; }
    public void setReceiverId(int receiverId) { this.receiverId = receiverId; }

    public String getStatus() { return status; }
    public void setStatus(String status) { this.status = status; }

    public User getSender() { return sender; }
    public void setSender(User sender) { this.sender = sender; }

    public User getReceiver() { return receiver; }
    public void setReceiver(User receiver) { this.receiver = receiver; }
}
