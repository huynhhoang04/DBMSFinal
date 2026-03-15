package main.java.mapper;

import main.java.dto.ShowtimeDetailDTO;

import java.sql.ResultSet;
import java.sql.SQLException;

public class ShowtimeDTOMapper {
    public static ShowtimeDetailDTO map(ResultSet rs) throws SQLException {
        ShowtimeDetailDTO dto = new ShowtimeDetailDTO();
        dto.setTheatreId(rs.getInt("theatre_id"));
        dto.setTheatreName(rs.getString("theatre_name"));
        dto.setRoomId(rs.getInt("room_id"));
        dto.setRoomName(rs.getString("room_name"));
        dto.setRoomType(rs.getString("room_type"));
        dto.setMovieId(rs.getInt("movie_id"));
        dto.setShowtimeId(rs.getInt("showtime_id"));
        dto.setStartAt(rs.getTimestamp("start_at"));
        dto.setPrice(rs.getDouble("price"));
        dto.setSeatRemain((int) rs.getLong("seat_remain"));

        return dto;
    }
}
