package main.java.service;

import main.java.dto.BookingHistoryDTO;
import main.java.model.entity.User;

import java.util.List;

public interface UserServices {
    User login(String account, String rawPassword);
    String register(User newUser, String confirmPassword);
    String updatePassword(User currentUser, String oldPassword, String newPassword, String confirmNewPassword);
    List<BookingHistoryDTO> getBookingHistory(int userId);
}
