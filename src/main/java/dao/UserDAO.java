package main.java.dao;

import main.java.dto.BookingHistoryDTO;
import main.java.model.entity.User;

import java.util.List;

public interface UserDAO {
    User login(String account, String password);
    boolean register(User user);
    boolean checkUserExists(String username, String email);
    String getHashedPassword(int user_id);
    boolean updatePassword(int user_id, String newPassword);
    List<BookingHistoryDTO> getBookingHistory(int userId);
}
