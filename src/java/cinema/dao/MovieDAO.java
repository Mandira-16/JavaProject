package cinema.dao;

import cinema.connection.DbConnection;
import cinema.model.Movie;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

public class MovieDAO {
    public MovieDAO() {
    }

    public List<Movie> getAllMovies() {
        List<Movie> movies = new ArrayList<>();
        String query = "SELECT * FROM movies";
        try (Connection connection = DbConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(query);
             ResultSet rs = ps.executeQuery()) {

            while (rs.next()) {
                Movie movie = new Movie(
                    rs.getInt("movie_id"),
                    rs.getString("movie_name"),
                    rs.getString("movie_language"),
                    rs.getString("movie_content"),
                    rs.getString("movie_trailer_link"),
                    rs.getString("movie_image_path"),
                    rs.getString("movie_status"),
                    rs.getInt("movie_ticket_price"),
                    rs.getString("movie_rating")  // Note: Changed from r_rate
                );
                movies.add(movie);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return movies;
    }

    public Movie getMovieById(int movieId) {
        Movie movie = null;
        String query = "SELECT * FROM movies WHERE movie_id = ?";
        try (Connection connection = DbConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(query)) {

            ps.setInt(1, movieId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    movie = new Movie(
                        rs.getInt("movie_id"),
                        rs.getString("movie_name"),
                        rs.getString("movie_language"),
                        rs.getString("movie_content"),
                        rs.getString("movie_trailer_link"),
                        rs.getString("movie_image_path"),
                        rs.getString("movie_status"),
                        rs.getInt("movie_ticket_price"),
                        rs.getString("movie_rating")  // Note: Changed from r_rate
                    );
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return movie;
    }

    public boolean addMovie(Movie movie) {
        String query = "INSERT INTO movies " +
            "(movie_id, movie_name, movie_language, movie_content, " +
            "movie_trailer_link, movie_image_path, movie_status, " +
            "movie_ticket_price, movie_rating) " +  // Note: Changed from r_rate
            "VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?)";
        
        try (Connection connection = DbConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(query)) {
            
            ps.setInt(1, movie.getMovieId());
            ps.setString(2, movie.getMovieName());
            ps.setString(3, movie.getMovieLanguage());
            ps.setString(4, movie.getMovieContent());
            ps.setString(5, movie.getMovieTrailerLink());
            ps.setString(6, movie.getMovieImagePath());
            ps.setString(7, movie.getMovieStatus());
            ps.setInt(8, movie.getMovieTicketPrice());
            ps.setString(9, movie.getMovieRate());

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0;

        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Movie> getMoviesByStatus(String status) {
        List<Movie> movies = new ArrayList<>();
        String query = "SELECT * FROM movies WHERE movie_status = ?";
        
        try (Connection connection = DbConnection.getConnection();
             PreparedStatement ps = connection.prepareStatement(query)) {
            
            ps.setString(1, status);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Movie movie = new Movie(
                        rs.getInt("movie_id"),
                        rs.getString("movie_name"),
                        rs.getString("movie_language"),
                        rs.getString("movie_content"),
                        rs.getString("movie_trailer_link"),
                        rs.getString("movie_image_path"),
                        rs.getString("movie_status"),
                        rs.getInt("movie_ticket_price"),
                        rs.getString("movie_rating")  // Note: Changed from r_rate
                    );
                    movies.add(movie);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        
        return movies;
    }
}