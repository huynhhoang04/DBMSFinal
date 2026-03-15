package main.java.dto;

import java.sql.Timestamp;

public class ShowtimeDetailDTO {
    private int theatreId;
    private String theatreName;
    private int roomId;
    private String roomName;
    private String roomType;
    private int movieId;
    private int showtimeId;
    private Timestamp startAt;
    private double price;
    private int seatRemain;

    public ShowtimeDetailDTO() {
    }

    public ShowtimeDetailDTO(int theatreId, String theatreName, int roomId, String roomName,
                             String roomType, int movieId, int showtimeId,
                             Timestamp startAt, double price, int seatRemain) {
        this.theatreId = theatreId;
        this.theatreName = theatreName;
        this.roomId = roomId;
        this.roomName = roomName;
        this.roomType = roomType;
        this.movieId = movieId;
        this.showtimeId = showtimeId;
        this.startAt = startAt;
        this.price = price;
        this.seatRemain = seatRemain;
    }

    public int getTheatreId() { return theatreId; }
    public void setTheatreId(int theatreId) { this.theatreId = theatreId; }

    public String getTheatreName() { return theatreName; }
    public void setTheatreName(String theatreName) { this.theatreName = theatreName; }

    public int getRoomId() { return roomId; }
    public void setRoomId(int roomId) { this.roomId = roomId; }

    public String getRoomName() { return roomName; }
    public void setRoomName(String roomName) { this.roomName = roomName; }

    public String getRoomType() { return roomType; }
    public void setRoomType(String roomType) { this.roomType = roomType; }

    public int getMovieId() { return movieId; }
    public void setMovieId(int movieId) { this.movieId = movieId; }

    public int getShowtimeId() { return showtimeId; }
    public void setShowtimeId(int showtimeId) { this.showtimeId = showtimeId; }

    public Timestamp getStartAt() { return startAt; }
    public void setStartAt(Timestamp startAt) { this.startAt = startAt; }

    public double getPrice() { return price; }
    public void setPrice(double price) { this.price = price; }

    public int getSeatRemain() { return seatRemain; }
    public void setSeatRemain(int seatRemain) { this.seatRemain = seatRemain; }
}