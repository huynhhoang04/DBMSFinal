package main.java.dto;

import java.time.LocalDate;

public class MovieDetailDTO {
    private int movie_id;
    private String title;
    private String description;
    private String poster_url;
    private String trailer_url;
    private String genre;
    private int duration;
    private LocalDate release_date;

    // TRƯỜNG MỚI THÊM VÀO ĐÂY SẾP
    private String seriesName;
    private String directors;
    private String actors;

    public MovieDetailDTO() {}

    // Generate lại Constructor đầy đủ cho 3 trường mới
    public MovieDetailDTO(int movie_id, String title, String description, String poster_url,
                          String trailer_url, String genre, int duration, LocalDate release_date,
                          String seriesName, String directors, String actors) {
        this.movie_id = movie_id;
        this.title = title;
        this.description = description;
        this.poster_url = poster_url;
        this.trailer_url = trailer_url;
        this.genre = genre;
        this.duration = duration;
        this.release_date = release_date;
        this.seriesName = seriesName;
        this.directors = directors;
        this.actors = actors;
    }

    public int getMovie_id() {
        return movie_id;
    }

    public String getTitle() {
        return title;
    }

    public String getDescription() {
        return description;
    }

    public String getPoster_url() {
        return poster_url;
    }

    public String getTrailer_url() {
        return trailer_url;
    }

    public String getGenre() {
        return genre;
    }

    public int getDuration() {
        return duration;
    }

    public LocalDate getRelease_date() {
        return release_date;
    }

    public String getSeriesName() {
        return seriesName;
    }

    public String getDirectors() {
        return directors;
    }

    public String getActors() {
        return actors;
    }

    public void setMovie_id(int movie_id) {
        this.movie_id = movie_id;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setPoster_url(String poster_url) {
        this.poster_url = poster_url;
    }

    public void setTrailer_url(String trailer_url) {
        this.trailer_url = trailer_url;
    }

    public void setGenre(String genre) {
        this.genre = genre;
    }

    public void setDuration(int duration) {
        this.duration = duration;
    }

    public void setRelease_date(LocalDate release_date) {
        this.release_date = release_date;
    }

    public void setSeriesName(String seriesName) {
        this.seriesName = seriesName;
    }

    public void setDirectors(String directors) {
        this.directors = directors;
    }

    public void setActors(String actors) {
        this.actors = actors;
    }
}