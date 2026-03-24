package main.java.model.entity;

public class Director {
    private int directorId;
    private String directorName;
    private String avatarUrl;
    private String bio;

    public Director() {}

    public Director(int directorId, String directorName, String avatarUrl, String bio) {
        this.directorId = directorId;
        this.directorName = directorName;
        this.avatarUrl = avatarUrl;
        this.bio = bio;
    }

    public int getDirectorId() {
        return directorId;
    }

    public String getDirectorName() {
        return directorName;
    }

    public String getAvatarUrl() {
        return avatarUrl;
    }

    public String getBio() {
        return bio;
    }

    public void setDirectorId(int directorId) {
        this.directorId = directorId;
    }

    public void setDirectorName(String directorName) {
        this.directorName = directorName;
    }

    public void setAvatarUrl(String avatarUrl) {
        this.avatarUrl = avatarUrl;
    }

    public void setBio(String bio) {
        this.bio = bio;
    }
}