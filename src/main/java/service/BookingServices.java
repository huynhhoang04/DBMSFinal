package main.java.service;

import main.java.dto.RoomCapacityDTO;

import java.util.List;

public interface BookingServices {
    RoomCapacityDTO getRoomCapacity(int showtimeId);
    List<String> getUnavailableSeats(int showtimeId);
    String createBooking(int userId, int showtimeId, double totalPayment, String paymentMethod, String[] seats);
    int getLatestPendingBookingId(int userId);
    boolean updateBookingStatus(int bookingId, int userId, String newStatus);
}
