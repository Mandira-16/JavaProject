package cinema.model;

import java.time.LocalDate;
import java.util.Date;
import java.util.List;

public class Show {

    private int showId;
    private int movieId;
    private int hallId;
    private Date startDate;
    private Date endDate;
    private int slotId;

    // Constructors
    public Show() {
    }

    public Show(int movieId, int hallId, Date startDate, Date endDate, int slotId) {
        this.movieId = movieId;
        this.hallId = hallId;
        this.startDate = startDate;
        this.endDate = endDate;
        this.slotId = slotId;
    }

    // Getters and Setters
    public int getShowId() {
        return showId;
    }

    public void setShowId(int showId) {
        this.showId = showId;
    }

    public int getMovieId() {
        return movieId;
    }

    public void setMovieId(int movieId) {
        this.movieId = movieId;
    }

    public int getHallId() {
        return hallId;
    }

    public void setHallId(int hallId) {
        this.hallId = hallId;
    }

    public Date getStartDate() {
        return startDate;
    }

    public void setStartDate(Date startDate) {
        this.startDate = startDate;
    }

    public Date getEndDate() {
        return endDate;
    }

    public void setEndDate(Date endDate) {
        this.endDate = endDate;
    }

    public int getSlotId() {
        return slotId;
    }

    public void setSlotId(int slotId) {
        this.slotId = slotId;
    }


    public void setShowDate(java.sql.Date date) {

    }
    private List<LocalDate> showDates;
    private List<String> timeSlots;

    public List<LocalDate> getShowDates() {
        return showDates;
    }

    public void setShowDates(List<LocalDate> showDates) {
        this.showDates = showDates;
    }

    public List<String> getTimeSlots() {
        return timeSlots;
    }

    public void setTimeSlots(List<String> timeSlots) {
        this.timeSlots = timeSlots;
    }

}