package main.java.mapper;

import main.java.model.entity.Movie;
import main.java.model.enums.MovieStatus;

import java.sql.ResultSet;
import java.sql.SQLException;

public class MovieMapper {
    public static Movie map(ResultSet rs) throws SQLException {
        // 1. Khởi tạo một đối tượng rỗng (Bắt buộc class Movie phải có Constructor rỗng)
        Movie movie = new Movie();

        // 2. Dùng hàm Set để bơm từng trường một (Bao chuẩn 100%)
        // Lưu ý: Nếu IDE báo đỏ ở các chữ set..., sếp sửa lại tên hàm cho khớp với file Movie.java của sếp nhé (ví dụ: setMovie_id)
        movie.setMovieId(rs.getInt("movie_id"));
        movie.setTitle(rs.getString("title"));
        movie.setDescription(rs.getString("description"));
        movie.setPosterUrl(rs.getString("poster_url"));
        movie.setTrailerUrl(rs.getString("trailer_url"));
        movie.setDuration(rs.getInt("duration"));

        // Bắt an toàn cho ngày tháng
        if (rs.getDate("release_date") != null) {
            movie.setReleaseDate(rs.getDate("release_date"));
        }

        // Bắt an toàn cho Status
        String status = rs.getString("movie_status");
        if (status != null && !status.isEmpty()) {
            movie.setMovieStatus(MovieStatus.valueOf(status));
        }

        // Bắt an toàn cho series_id
        int seriesId = rs.getInt("series_id");
        if (!rs.wasNull()) {
            movie.setSeriesId(seriesId);
        }

        movie.setGenre(rs.getString("genre"));

        // 3. Bơm 3 trường mới (Bọc try-catch để lỡ hàm lấy danh sách không gọi 3 trường này thì web vẫn không sập)
        try {
            movie.setSeriesName(rs.getString("series_name"));
            movie.setDirectors(rs.getString("directors"));
            movie.setActors(rs.getString("actors"));
        } catch (SQLException e) {
        }

        return movie;
    }
}