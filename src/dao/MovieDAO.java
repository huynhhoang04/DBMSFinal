package dao;

import model.Movie;

import java.util.List;

public interface MovieDAO {
    List<Movie> getTop7NewestMovies();
    Movie getMovieById(int id);
    List<Movie> getMovieByStatusAndPage(String status, int page, int size);
    int countMovieByStatus(String status);
}
