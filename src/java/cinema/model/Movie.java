package cinema.model;

public class Movie {
    private int movieId;
    private String movieName;
    private String movieLanguage;
    private String movieContent;
    private String movieTrailerLink;
    private String movieImagePath;
    private String movieStatus;
    private int movieTicketPrice;
    private String movieRate;

    // Default constructor
    public Movie() {
    }

    // Parameterized constructor
    public Movie(int movieId, String movieName, String movieLanguage, 
                 String movieContent, String movieTrailerLink, 
                 String movieImagePath, String movieStatus, 
                 int movieTicketPrice, String movieRate) {
        this.movieId = movieId;
        this.movieName = movieName;
        this.movieLanguage = movieLanguage;
        this.movieContent = movieContent;
        this.movieTrailerLink = movieTrailerLink;
        this.movieImagePath = movieImagePath;
        this.movieStatus = movieStatus;
        this.movieTicketPrice = movieTicketPrice;
        this.movieRate = movieRate;
    }

    // Getters and setters
    public int getMovieId() { return movieId; }
    public void setMovieId(int movieId) { this.movieId = movieId; }

    public String getMovieName() { return movieName; }
    public void setMovieName(String movieName) { this.movieName = movieName; }

    public String getMovieLanguage() { return movieLanguage; }
    public void setMovieLanguage(String movieLanguage) { this.movieLanguage = movieLanguage; }

    public String getMovieContent() { return movieContent; }
    public void setMovieContent(String movieContent) { this.movieContent = movieContent; }

    public String getMovieTrailerLink() { return movieTrailerLink; }
    public void setMovieTrailerLink(String movieTrailerLink) { this.movieTrailerLink = movieTrailerLink; }

    public String getMovieImagePath() { return movieImagePath; }
    public void setMovieImagePath(String movieImagePath) { this.movieImagePath = movieImagePath; }

    public String getMovieStatus() { return movieStatus; }
    public void setMovieStatus(String movieStatus) { this.movieStatus = movieStatus; }

    public int getMovieTicketPrice() { return movieTicketPrice; }
    public void setMovieTicketPrice(int movieTicketPrice) { this.movieTicketPrice = movieTicketPrice; }

    public String getMovieRate() { return movieRate; }
    public void setMovieRate(String movieRate) { this.movieRate = movieRate; }
}