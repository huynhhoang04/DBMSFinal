package main.java.model.entity;

public class Actor {
    private int actorId;
    private String actorName;
    private String avatarUrl;
    private String bio;

    // Constructors
    public Actor() {}

    public Actor(int actorId, String actorName, String avatarUrl, String bio) {
        this.actorId = actorId;
        this.actorName = actorName;
        this.avatarUrl = avatarUrl;
        this.bio = bio;
    }

    public int getActorId() {
        return actorId;
    }

    public String getActorName() {
        return actorName;
    }

    public String getAvatarUrl() {
        return avatarUrl;
    }

    public String getBio() {
        return bio;
    }

    public void setActorId(int actorId) {
        this.actorId = actorId;
    }

    public void setActorName(String actorName) {
        this.actorName = actorName;
    }

    public void setAvatarUrl(String avatarUrl) {
        this.avatarUrl = avatarUrl;
    }

    public void setBio(String bio) {
        this.bio = bio;
    }
}
