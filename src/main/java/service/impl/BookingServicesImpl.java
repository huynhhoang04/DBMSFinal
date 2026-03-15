package main.java.service.impl;

import main.java.dao.BookingDAO;
import main.java.dto.RoomCapacityDTO;
import main.java.service.BookingServices;

import java.util.List;

public class BookingServicesImpl implements BookingServices {
    private final BookingDAO bookingDAO;

    public BookingServicesImpl(BookingDAO bookingDAO) {
        this.bookingDAO = bookingDAO;
    }

    @Override
    public RoomCapacityDTO getRoomCapacity(int showtimeId) {
        return bookingDAO.getRoomCapacity(showtimeId);
    }

    @Override
    public List<String> getUnavailableSeats(int showtimeId) {
        return bookingDAO.getUnavailableSeats(showtimeId);
    }

    @Override
    public String createBooking(int userId, int showtimeId, double totalPayment, String paymentMethod, String[] seats) {
        if (seats == null || seats.length == 0) {
            return "Vui lòng chọn ít nhất 1 ghế để tiếp tục!";
        }

        return bookingDAO.createBooking(userId, showtimeId, totalPayment, paymentMethod, seats);
    }

    @Override
    public int getLatestPendingBookingId(int userId) {
        return bookingDAO.getLatestPendingBookingId(userId);
    }

    @Override
    public boolean updateBookingStatus(int bookingId, int userId, String newStatus) {
        return bookingDAO.updateBookingStatus(bookingId, userId, newStatus);
    }
}
