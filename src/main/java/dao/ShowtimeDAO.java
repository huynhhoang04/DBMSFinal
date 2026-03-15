package main.java.dao;

import main.java.dto.ShowtimeDetailDTO;

import java.util.Date;
import java.util.List;

public interface ShowtimeDAO {
    List<ShowtimeDetailDTO> getShowtimesFormMovie(Date date, int movie_id, String city);
}
