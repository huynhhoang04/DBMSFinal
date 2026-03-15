package main.java.service.impl;

import main.java.dao.ShowtimeDAO;
import main.java.dto.ShowtimeDetailDTO;
import main.java.service.ShowtimeServices;

import java.util.Date;
import java.util.List;

public class ShowtimeServiceImpl implements ShowtimeServices {
    private final ShowtimeDAO showtimeDAO;

    public ShowtimeServiceImpl(ShowtimeDAO showtimeDAO) {
        this.showtimeDAO = showtimeDAO;
    }

    @Override
    public List<ShowtimeDetailDTO> getMovieShowtimes(Date date, int movie_id, String city) {
        return showtimeDAO.getShowtimesFormMovie(date, movie_id, city);
    }
}
