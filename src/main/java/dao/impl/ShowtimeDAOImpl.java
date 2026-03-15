package main.java.dao.impl;

import main.java.dao.ShowtimeDAO;
import main.java.dto.ShowtimeDetailDTO;
import main.java.mapper.ShowtimeDTOMapper;
import main.java.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class ShowtimeDAOImpl implements ShowtimeDAO {
    @Override
    public List<ShowtimeDetailDTO> getShowtimesFormMovie(Date date, int movie_id, String city) {
        String sql = "select * from get_showtime_for_movie_by_date(?, ?, ?)";
        try (Connection con = DBConnection.getConnection();
            PreparedStatement ps = con.prepareStatement(sql)){
            List<ShowtimeDetailDTO> showtimedetail = new ArrayList<>();
            ps.setDate(1, new java.sql.Date(date.getTime()));
            ps.setInt(2, movie_id);
            ps.setString(3, city);
            ResultSet rs = ps.executeQuery();
            while(rs.next()){
                showtimedetail.add(ShowtimeDTOMapper.map(rs));
            }
            return showtimedetail;
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
    }
}
