package service.impl;

import dao.MovieDAO;
import dto.MovieDetailDTO;
import dto.MovieThumnailDTO;
import model.Movie;
import service.MovieServices;

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
        movies.forEach(movie -> {
            dtos.add(new MovieThumnailDTO(movie.getMovie_id(), movie.getTitle(), movie.getPoster_url(), movie.getDuration()));
        });
        return dtos;
    }

    @Override
    public MovieDetailDTO getMovieById(int id) {
        Movie movie = movieDAO.getMovieById(id);
        MovieDetailDTO movieDetailDTO = new MovieDetailDTO(movie.getMovie_id(), movie.getTitle(), movie.getDescription(), movie.getPoster_url(), movie.getTrailer_url(), movie.getGenre(), movie.getDuration(), movie.getRelease_date());
        return movieDetailDTO;
    }

    @Override
    public List<MovieThumnailDTO> getMovieByStatusAndPage(String statusRaw, int pageRaw) {
        int pageSize = 8;
        int offset = (pageRaw - 1) * pageSize;
        String status = statusRaw.toUpperCase();
        List<Movie> movies = movieDAO.getMovieByStatusAndPage(status, offset, pageSize);
        List<MovieThumnailDTO> dtos = new ArrayList<>();
        movies.forEach(movie -> {
            dtos.add(new MovieThumnailDTO(movie.getMovie_id(), movie.getTitle(), movie.getPoster_url(), movie.getDuration()));
        });
        return dtos;
    }

    @Override
    public int countMovieByStatus(String statusRaw) {
        String status = statusRaw.toUpperCase();
        return movieDAO.countMovieByStatus(status);
    }
}
