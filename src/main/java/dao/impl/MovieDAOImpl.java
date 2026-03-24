package main.java.dao.impl;

import main.java.dao.MovieDAO;
import main.java.mapper.MovieMapper;
import main.java.model.entity.Movie;
import main.java.util.DBConnection;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class MovieDAOImpl implements MovieDAO {
    @Override
    public List<Movie> getTop7NewestMovies() {
        List<Movie> list = new ArrayList<>();
        String sql = "SELECT * FROM get_top_7_movies()";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(MovieMapper.map(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public Movie getMovieById(int id) {
        String sql = "SELECT * FROM get_movie_detail_by_id(?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return MovieMapper.map(rs);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<Movie> getMovieByStatusAndPage(String status, int page, int size, String keyword, String tag) {
        List<Movie> list = new ArrayList<>();
        int offset = (page - 1) * size;

        // Gọi thẳng Function, truyền tham số sạch sẽ
        String sql = "SELECT * FROM get_movies_by_status_and_page(?, ?, ?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, status);
            ps.setString(2, keyword);
            ps.setString(3, tag);
            ps.setInt(4, size);
            ps.setInt(5, offset);

            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(MovieMapper.map(rs));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return list;
    }

    @Override
    public int countMovieByStatus(String status, String keyword, String tag) {
        int total = 0;

        // Gọi thẳng Function đếm
        String sql = "SELECT count_movies_by_status(?, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, status);
            ps.setString(2, keyword);
            ps.setString(3, tag);

            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                total = rs.getInt(1);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return total;
    }
}
