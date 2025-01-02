package cinema.model;

import java.util.ArrayList;
import java.util.List;

public class Ticket {

    private String movieId;
    private int hallNo; // Changed to int
    private List<String> timeSlots;
    private String startDate;
    private String endDate;

    public Ticket() {
        // Default constructor
    }

    public Ticket(String movieId, int hallNo, List<String> timeSlots, String startDate, String endDate) {
        this.movieId = movieId;
        this.hallNo = hallNo;
        this.timeSlots = timeSlots != null ? timeSlots : new ArrayList<>();
        this.startDate = startDate;
        this.endDate = endDate;
    }

    public String getMovieId() {
        return movieId;
    }

    public void setMovieId(String movieId) {
        this.movieId = movieId;
    }

    public int getHallNo() {
        return hallNo;
    }

    public void setHallNo(int hallNo) {
        this.hallNo = hallNo;
    }

    public List<String> getTimeSlots() {
        return timeSlots;
    }

    public void setTimeSlots(List<String> timeSlots) {
        this.timeSlots = timeSlots;
    }

    public String getStartDate() {
        return startDate;
    }

    public void setStartDate(String startDate) {
        this.startDate = startDate;
    }

    public String getEndDate() {
        return endDate;
    }

    public void setEndDate(String endDate) {
        this.endDate = endDate;
    }

    @Override
    public String toString() {
        return "Ticket{"
                + "movieId='" + movieId + '\''
                + ", hallNo=" + hallNo
                + ", timeSlots=" + String.join(", ", timeSlots)
                + ", startDate='" + startDate + '\''
                + ", endDate='" + endDate + '\''
                + '}';
    }
}
