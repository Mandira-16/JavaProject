package cinema.model;

public class Hall {

    private int hallId;
    private String hallName;

    // Constructors, getters, setters
    public Hall(int hallId, String hallName) {
        this.hallId = hallId;
        this.hallName = hallName;
    }

    public Hall() {
        throw new UnsupportedOperationException("Not supported yet."); //To change body of generated methods, choose Tools | Templates.
    }

    public Hall(int hallId) {

    }

    public int getHallId() {
        return hallId;
    }

    public void setHallId(int hallId) {
        this.hallId = hallId;
    }

    public String getHallName() {
        return hallName;
    }

    public void setHallName(String hallName) {
        this.hallName = hallName;
    }
}
