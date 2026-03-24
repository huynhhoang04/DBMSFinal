package main.java.service.impl;

import main.java.dao.MovieDAO;
import main.java.dto.MovieDetailDTO;
import main.java.dto.MovieThumnailDTO;
import main.java.model.entity.Movie;
import main.java.service.MovieServices;

import java.util.ArrayList;
import java.util.List;

public class MovieServiesImpl implements MovieServices {
    private final MovieDAO movieDAO;

    public MovieServiesImpl(MovieDAO movieDAO) {
        this.movieDAO = movieDAO;
    }

    @Override
    public List<MovieThumnailDTO> getTop7NewestMovies() {
        List<Movie> movies = movieDAO.getTop7NewestMovies();
        List<MovieThumnailDTO> dtos = new ArrayList<>();

        // Bọc lót an toàn tránh NullPointerException
        if (movies != null) {
            movies.forEach(movie -> {
                dtos.add(new MovieThumnailDTO(movie.getMovieId(), movie.getTitle(), movie.getPosterUrl(), movie.getDuration()));
            });
        }
        return dtos;
    }

    @Override
    public MovieDetailDTO getMovieById(int id) {
        Movie movie = movieDAO.getMovieById(id);

        if (movie != null) {
            MovieDetailDTO movieDetailDTO = new MovieDetailDTO(
                    movie.getMovieId(),
                    movie.getTitle(),
                    movie.getDescription(),
                    movie.getPosterUrl(),
                    movie.getTrailerUrl(),
                    movie.getGenre(),
                    movie.getDuration(),
                    movie.getReleaseDate() != null ? movie.getReleaseDate().toLocalDate() : null,
                    movie.getSeriesName(),
                    movie.getDirectors(),
                    movie.getActors()
            ); return movieDetailDTO;
        }
        return null;
    }

    @Override
    public List<MovieThumnailDTO> getMovieByStatusAndPage(String statusRaw, int pageRaw,  String keywordRaw, String tagRaw) {
        int pageSize = 8;

        // ĐÃ XÓA DÒNG TÍNH OFFSET BỊ TRÙNG LẶP Ở ĐÂY

        String status = statusRaw.toUpperCase();
        String keyword = (keywordRaw == null) ? "" : keywordRaw.trim();
        String tag = (tagRaw == null) ? "" : tagRaw.trim();

        // Truyền thẳng pageRaw xuống DAO
        List<Movie> movies = movieDAO.getMovieByStatusAndPage(status, pageRaw, pageSize, keyword, tag);
        List<MovieThumnailDTO> dtos = new ArrayList<>();

        if (movies != null) {
            movies.forEach(movie -> {
                dtos.add(new MovieThumnailDTO(movie.getMovieId(), movie.getTitle(), movie.getPosterUrl(), movie.getDuration()));
            });
        }
        return dtos;
    }

    @Override
    public int countMovieByStatus(String statusRaw, String tagRaw,  String keywordRaw) {
        String status = statusRaw.toUpperCase();
        String keyword = (keywordRaw == null) ? "" : keywordRaw.trim();
        String tag = (tagRaw == null) ? "" : tagRaw.trim();
        return movieDAO.countMovieByStatus(status, keyword, tag);
    }
}