package service;

import dto.MovieDetailDTO;
import dto.MovieThumnailDTO;
import model.Movie;

import java.util.List;

public interface MovieServices {
    List<MovieThumnailDTO> getTop7NewestMovies();
    MovieDetailDTO getMovieById(int id);
    List<MovieThumnailDTO> getMovieByStatusAndPage(String statusRaw, int pageRaw);
    int countMovieByStatus(String statusRaw);
}
