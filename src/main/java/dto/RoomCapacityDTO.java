package main.java.dto;

public class RoomCapacityDTO {
    private String roomName;
    private int capacity;
    private double standardPrice;

    public RoomCapacityDTO(String roomName, int capacity, double standardPrice) {
        this.roomName = roomName;
        this.capacity = capacity;
        this.standardPrice = standardPrice;
    }

    public String getRoomName() {
        return roomName;
    }

    public int getCapacity() {
        return capacity;
    }

    public double getStandardPrice() {
        return standardPrice;
    }
}
