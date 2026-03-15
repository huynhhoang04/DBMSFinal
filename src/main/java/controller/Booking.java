package main.java.controller;

import com.google.gson.Gson;
import main.java.dao.impl.BookingDAOImpl;
import main.java.dto.RoomCapacityDTO;
import main.java.model.entity.User;
import main.java.service.BookingServices;
import main.java.service.impl.BookingServicesImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.util.List;

@WebServlet(name = "Booking", value = "/booking")
public class Booking extends HttpServlet {
    private BookingServices bookingServices;

    @Override
    public void init() throws ServletException {
        this.bookingServices = new BookingServicesImpl(new BookingDAOImpl());
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("currentUser");


        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/auth?action=login");
            return;
        }
        System.out.println("Current User: " + currentUser.getUser_id());
        try {
            int showtimeId = Integer.parseInt(request.getParameter("showtime_id"));

            RoomCapacityDTO roomInfo = bookingServices.getRoomCapacity(showtimeId);
            List<String> bookedSeats = bookingServices.getUnavailableSeats(showtimeId);

            if (roomInfo != null) {
                request.setAttribute("roomInfo", roomInfo);
                request.setAttribute("showtimeId", showtimeId);

                Gson gson = new Gson();
                String bookedSeatsJson = gson.toJson(bookedSeats);
                request.setAttribute("bookedSeatsJson", bookedSeatsJson);

                request.getRequestDispatcher("/views/user/booking.jsp").forward(request, response);
            } else {
                response.sendRedirect(request.getContextPath() + "/home");
            }
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect(request.getContextPath() + "/home");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        request.setCharacterEncoding("UTF-8");

        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("currentUser");

        if (currentUser == null) {
            // Chưa đăng nhập -> Đá ra trang Login
            response.sendRedirect(request.getContextPath() + "/auth?action=login");
            return;
        }

        try {
            int userId = currentUser.getUser_id();
            int showtimeId = Integer.parseInt(request.getParameter("showtime_id"));
            double totalPayment = Double.parseDouble(request.getParameter("total_payment"));
            String paymentMethod = request.getParameter("payment_method");
            String[] selectedSeats = request.getParameterValues("seats");

            // Gọi Service
            String resultMsg = bookingServices.createBooking(userId, showtimeId, totalPayment, paymentMethod, selectedSeats);

            if ("SUCCESS".equals(resultMsg)) {
                int newBookingId = bookingServices.getLatestPendingBookingId(userId);
                session.setAttribute("pending_booking_id", newBookingId);
                response.sendRedirect(request.getContextPath() + "/pay");
            } else {
                request.setAttribute("error", resultMsg);
                doGet(request, response);
            }

        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lý do hệ thống, vui lòng thử lại sau!");
            doGet(request, response);
        }
    }
}
