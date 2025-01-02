package cinema.model;

public class Seat {
    private String seatNumber;
    private boolean isReserved;

    public Seat(String seatNumber, boolean isReserved) {
        this.seatNumber = seatNumber;
        this.isReserved = isReserved;
    }

    public String getSeatNumber() {
        return seatNumber;
    }

    public void setSeatNumber(String seatNumber) {
        this.seatNumber = seatNumber;
    }

    public boolean isReserved() {
        return isReserved;
    }

    public void setReserved(boolean reserved) {
        isReserved = reserved;
    }
}
