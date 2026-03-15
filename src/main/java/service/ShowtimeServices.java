package main.java.service;

import main.java.dto.ShowtimeDetailDTO;

import java.util.Date;
import java.util.List;

public interface ShowtimeServices {
    List<ShowtimeDetailDTO> getMovieShowtimes(Date date, int movie_id, String city);
}
