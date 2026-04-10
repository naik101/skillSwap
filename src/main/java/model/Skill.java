package model;

public class Skill {
    private int skillId;
    private int userId;
    private String skillOffered;
    private String skillWanted;
    private User user; // Optional: To store user details alongside their skills

    public Skill() {}

    public Skill(int skillId, int userId, String skillOffered, String skillWanted) {
        this.skillId = skillId;
        this.userId = userId;
        this.skillOffered = skillOffered;
        this.skillWanted = skillWanted;
    }

    public int getSkillId() { return skillId; }
    public void setSkillId(int skillId) { this.skillId = skillId; }

    public int getUserId() { return userId; }
    public void setUserId(int userId) { this.userId = userId; }

    public String getSkillOffered() { return skillOffered; }
    public void setSkillOffered(String skillOffered) { this.skillOffered = skillOffered; }

    public String getSkillWanted() { return skillWanted; }
    public void setSkillWanted(String skillWanted) { this.skillWanted = skillWanted; }
    
    public User getUser() { return user; }
    public void setUser(User user) { this.user = user; }
}
