package main.java.dao.impl;

import main.java.dao.BookingDAO;
import main.java.dto.RoomCapacityDTO;
import main.java.util.DBConnection;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class BookingDAOImpl implements BookingDAO {
    @Override
    public RoomCapacityDTO getRoomCapacity(int showtimeId) {
        String sql = "SELECT * FROM get_room_capacity(?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, showtimeId);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                return new RoomCapacityDTO(
                        rs.getString("room_name"),
                        rs.getInt("capacity"),
                        rs.getDouble("standard_price")
                );
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return null;
    }

    @Override
    public List<String> getUnavailableSeats(int showtimeId) {
        List<String> bookedSeats = new ArrayList<>();
        String sql = "SELECT * FROM get_unavailable_seat(?)";

        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setInt(1, showtimeId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                bookedSeats.add(rs.getString("seat_number"));
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return bookedSeats;
    }

    @Override
    public String createBooking(int userId, int showtimeId, double totalPayment, String paymentMethod, String[] seats) {
        String sql = "CALL create_booking_with_tickets(?, ?, ?::decimal, ?, ?)";

        try (Connection conn = DBConnection.getConnection();
             CallableStatement cs = conn.prepareCall(sql)) {

            cs.setInt(1, userId);
            cs.setInt(2, showtimeId);
            cs.setDouble(3, totalPayment);
            cs.setString(4, paymentMethod);

            Array sqlArray = conn.createArrayOf("TEXT", seats);
            cs.setArray(5, sqlArray);

            cs.execute();
            return "SUCCESS";

        } catch (SQLException e) {
            e.printStackTrace();
            return e.getMessage();
        }
    }

    @Override
    public int getLatestPendingBookingId(int userId) {
        String sql = "SELECT booking_id FROM bookings WHERE user_id = ? AND payment_status = 'PENDING' ORDER BY booking_id DESC LIMIT 1";
        try (Connection conn = DBConnection.getConnection();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, userId);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) return rs.getInt("booking_id");
        } catch (SQLException e) { e.printStackTrace(); }
        return -1;
    }

    @Override
    public boolean updateBookingStatus(int bookingId, int userId, String newStatus) {
        String sql = "CALL update_booking_status(?, ?, ?)";
        try (Connection conn = DBConnection.getConnection();
             CallableStatement cs = conn.prepareCall(sql)) {

            cs.setInt(1, bookingId);
            cs.setInt(2, userId);
            cs.setString(3, newStatus);

            cs.execute();
            return true;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }


}
