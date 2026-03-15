package main.java.dao.impl;

import main.java.dao.UserDAO;
import main.java.dto.BookingHistoryDTO;
import main.java.mapper.UserMaapper;
import main.java.model.entity.User;
import main.java.model.enums.PaymentStatus;
import org.mindrot.jbcrypt.BCrypt;
import main.java.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class UserDAOImpl implements UserDAO {
    @Override
    public User login(String account, String password) {
        String sql = "select * from get_user_for_login(?)";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);) {
            ps.setString(1, account);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                String dbPassword = rs.getString("password");
                if (BCrypt.checkpw(password, dbPassword)) {
                    return UserMaapper.map(rs);
                }
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return null;
    }

    @Override
    public boolean register(User user) {
        System.out.print(user.getUsername() + " " + user.getPassword() + " " + user.getEmail() + " " + user.getFull_name());
        String hashedPassword = BCrypt.hashpw(user.getPassword(), BCrypt.gensalt(12));
        String sql = "call register_user(?, ?, ?, ?)";
        try (Connection con = DBConnection.getConnection();
             CallableStatement ps = con.prepareCall(sql);){
            ps.setString(1, user.getUsername());
            ps.setString(2, hashedPassword);
            ps.setString(3, user.getFull_name());
            ps.setString(4, user.getEmail());

            ps.execute();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return  false;
    }

    @Override
    public boolean checkUserExists(String username, String email) {
        String sql = "select * from check_user_exists(?, ?)";
        try (Connection con = DBConnection.getConnection();
        PreparedStatement ps = con.prepareStatement(sql);) {
            ps.setString(1, username);
            ps.setString(2, email);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getBoolean(1);
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return false;
    }

    @Override
    public String getHashedPassword(int user_id) {
        String sql = "select * from get_password_by_id(?);";
        try (Connection con = DBConnection.getConnection();
             PreparedStatement ps = con.prepareStatement(sql)){
            ps.setInt(1, user_id);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                return rs.getString("password");
            }
        } catch (SQLException e) {
            throw new RuntimeException(e);
        }
        return null;
    }

    @Override
    public boolean updatePassword(int user_id, String newPassword) {
        String sql = "call update_password(?, ?)";
        try (Connection con = DBConnection.getConnection();
        CallableStatement ps = con.prepareCall(sql);) {
            ps.setString(1, newPassword);
            ps.setInt(2, user_id);
            ps.execute();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return false;
    }

    @Override
    public List<BookingHistoryDTO> getBookingHistory(int userId) {
        List<BookingHistoryDTO> list = new ArrayList<>();

        String sql = "SELECT b.booking_id, b.booking_date, b.total_payment, b.payment_status, " +
                "m.title AS movie_title, s.start_at, r.room_name, " +
                "STRING_AGG(t.seat_number, ', ') AS seats " +
                "FROM bookings b " +
                "JOIN tickets t ON b.booking_id = t.booking_id " +
                "JOIN showtime s ON t.showtime_id = s.showtime_id " +
                "JOIN movies m ON s.movie_id = m.movie_id " +
                "JOIN room r ON s.room_id = r.room_id " +
                "WHERE b.user_id = ? " +
                "GROUP BY b.booking_id, b.booking_date, b.total_payment, b.payment_status, " +
                "m.title, s.start_at, r.room_name " +
                "ORDER BY b.booking_date DESC";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                BookingHistoryDTO dto = new BookingHistoryDTO();
                dto.setBookingId(rs.getInt("booking_id"));
                dto.setBookingDate(rs.getTimestamp("booking_date"));
                dto.setTotalPayment(rs.getDouble("total_payment"));
                dto.setPaymentStatus(PaymentStatus.valueOf(rs.getString("payment_status")));
                dto.setMovieTitle(rs.getString("movie_title"));
                dto.setShowTime(rs.getString("start_at"));
                dto.setRoomName(rs.getString("room_name"));
                dto.setSeats(rs.getString("seats"));

                list.add(dto);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
}
