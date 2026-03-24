package main.java.model.entity;

public class Series {
    private int seriesId;
    private String seriesName;
    private String description;

    public Series() {}

    public Series(int seriesId, String seriesName, String description) {
        this.seriesId = seriesId;
        this.seriesName = seriesName;
        this.description = description;
    }

    public String getDescription() {
        return description;
    }

    public String getSeriesName() {
        return seriesName;
    }

    public int getSeriesId() {
        return seriesId;
    }

    public void setSeriesId(int seriesId) {
        this.seriesId = seriesId;
    }

    public void setSeriesName(String seriesName) {
        this.seriesName = seriesName;
    }

    public void setDescription(String description) {
        this.description = description;
    }
}