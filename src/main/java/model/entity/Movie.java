package main.java.model.entity;

import main.java.model.enums.MovieStatus;
import java.sql.Date;

public class Movie {
    private int movieId;
    private String title;
    private String description;
    private String posterUrl;
    private String trailerUrl;
    private int duration;
    private Date releaseDate;
    private MovieStatus movieStatus;
    private Integer seriesId;
    private String genre;
    private String seriesName;
    private String directors;
    private String actors;

    public Movie() {
    }

    public Movie(int movieId, String title, String description, String posterUrl,
                 String trailerUrl, int duration, Date releaseDate,
                 MovieStatus movieStatus, Integer seriesId, String genre) {
        this.movieId = movieId;
        this.title = title;
        this.description = description;
        this.posterUrl = posterUrl;
        this.trailerUrl = trailerUrl;
        this.duration = duration;
        this.releaseDate = releaseDate;
        this.movieStatus = movieStatus;
        this.seriesId = seriesId;
        this.genre = genre;
    }

    public int getMovieId() {
        return movieId;
    }

    public String getTitle() {
        return title;
    }

    public String getDescription() {
        return description;
    }

    public String getPosterUrl() {
        return posterUrl;
    }

    public String getTrailerUrl() {
        return trailerUrl;
    }

    public int getDuration() {
        return duration;
    }

    public Date getReleaseDate() {
        return releaseDate;
    }

    public MovieStatus getMovieStatus() {
        return movieStatus;
    }

    public Integer getSeriesId() {
        return seriesId;
    }

    public String getGenre() {
        return genre;
    }

    public void setMovieId(int movieId) {
        this.movieId = movieId;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public void setPosterUrl(String posterUrl) {
        this.posterUrl = posterUrl;
    }

    public void setTrailerUrl(String trailerUrl) {
        this.trailerUrl = trailerUrl;
    }

    public void setDuration(int duration) {
        this.duration = duration;
    }

    public void setReleaseDate(Date releaseDate) {
        this.releaseDate = releaseDate;
    }

    public void setMovieStatus(MovieStatus movieStatus) {
        this.movieStatus = movieStatus;
    }

    public void setSeriesId(Integer seriesId) {
        this.seriesId = seriesId;
    }

    public void setGenre(String genre) {
        this.genre = genre;
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