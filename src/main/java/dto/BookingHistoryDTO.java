package main.java.dto;

import main.java.model.enums.PaymentStatus;

import java.sql.Timestamp;

public class BookingHistoryDTO {
    private int bookingId;
    private String movieTitle;
    private String showTime;
    private String roomName;
    private String seats;
    private double totalPayment;
    private PaymentStatus paymentStatus;
    private Timestamp bookingDate;

    public BookingHistoryDTO() {
    }

    public BookingHistoryDTO(int bookingId, String movieTitle, String showTime, String roomName, String seats, double totalPayment, PaymentStatus paymentStatus, Timestamp bookingDate) {
        this.bookingId = bookingId;
        this.movieTitle = movieTitle;
        this.showTime = showTime;
        this.roomName = roomName;
        this.seats = seats;
        this.totalPayment = totalPayment;
        this.paymentStatus = paymentStatus;
        this.bookingDate = bookingDate;
    }

    public int getBookingId() {
        return bookingId;
    }

    public String getMovieTitle() {
        return movieTitle;
    }


    public String getShowTime() {
        return showTime;
    }

    public String getRoomName() {
        return roomName;
    }

    public String getSeats() {
        return seats;
    }

    public double getTotalPayment() {
        return totalPayment;
    }

    public PaymentStatus getPaymentStatus() {
        return paymentStatus;
    }

    public Timestamp getBookingDate() {
        return bookingDate;
    }

    public void setBookingId(int bookingId) {
        this.bookingId = bookingId;
    }

    public void setMovieTitle(String movieTitle) {
        this.movieTitle = movieTitle;
    }


    public void setShowTime(String showTime) {
        this.showTime = showTime;
    }

    public void setRoomName(String roomName) {
        this.roomName = roomName;
    }

    public void setSeats(String seats) {
        this.seats = seats;
    }

    public void setTotalPayment(double totalPayment) {
        this.totalPayment = totalPayment;
    }

    public void setPaymentStatus(PaymentStatus paymentStatus) {
        this.paymentStatus = paymentStatus;
    }

    public void setBookingDate(Timestamp bookingDate) {
        this.bookingDate = bookingDate;
    }
}
