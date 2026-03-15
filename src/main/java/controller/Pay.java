package main.java.controller;

import main.java.dao.impl.BookingDAOImpl;
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

@WebServlet(value = "/pay")
public class Pay extends HttpServlet {
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

        Integer pendingBookingId = (Integer) session.getAttribute("pending_booking_id");

        if (pendingBookingId == null) {
            response.sendRedirect(request.getContextPath() + "/home");
            return;
        }

        request.setAttribute("bookingId", pendingBookingId);
        session.removeAttribute("pending_booking_id");
        request.getRequestDispatcher("/views/user/pay.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        HttpSession session = request.getSession();
        User currentUser = (User) session.getAttribute("currentUser");

        if (currentUser == null) {
            response.sendRedirect(request.getContextPath() + "/auth?action=login");
            return;
        }

        try {
            int bookingId = Integer.parseInt(request.getParameter("booking_id"));
            boolean isSuccess = bookingServices.updateBookingStatus(bookingId, currentUser.getUser_id(), "COMPLETED");

            if (isSuccess) {
                request.setAttribute("successMessage", "Thanh toán thành công! Chúc bạn xem phim vui vẻ.");
                request.setAttribute("bookingId", bookingId);
                request.getRequestDispatcher("/views/user/pay.jsp").forward(request, response);
            } else {
                request.setAttribute("error", "Lỗi xác nhận thanh toán. Vui lòng thử lại hoặc liên hệ CSKH!");
                request.setAttribute("bookingId", bookingId);
                request.getRequestDispatcher("/views/user/pay.jsp").forward(request, response);
            }
        } catch (Exception e) {
            e.printStackTrace();
            request.setAttribute("error", "Lỗi hệ thống gián đoạn: " + e.getMessage());
            request.setAttribute("bookingId", request.getParameter("booking_id"));
            request.getRequestDispatcher("/views/user/pay.jsp").forward(request, response);
        }
    }
}
