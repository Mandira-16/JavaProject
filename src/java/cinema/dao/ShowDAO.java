package cinema.dao;

import cinema.model.Show;
import cinema.model.Movie;
import cinema.model.Hall;
import java.sql.*;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

public class ShowDAO {

    private Connection connection;

    public ShowDAO(Connection connection) {
        this.connection = connection;
    }

    public boolean addShow(Show show) {
        String query = "INSERT INTO shows (movie_id, hall_id, start_date, end_date) VALUES (?, ?, ?, ?, ?)";
        try (PreparedStatement pstmt = connection.prepareStatement(query, Statement.RETURN_GENERATED_KEYS)) {
            pstmt.setInt(1, show.getMovieId());
            pstmt.setInt(2, show.getHallId());
            pstmt.setDate(3, new java.sql.Date(show.getStartDate().getTime()));
            pstmt.setDate(4, new java.sql.Date(show.getEndDate().getTime()));
            pstmt.setInt(5, show.getSlotId());

            int rowsAffected = pstmt.executeUpdate();

            if (rowsAffected > 0) {
                try (ResultSet generatedKeys = pstmt.getGeneratedKeys()) {
                    if (generatedKeys.next()) {
                        show.setShowId(generatedKeys.getInt(1));
                        // Populate seats for this show
                        populateSeatsForShow(show.getShowId());
                        return true;
                    }
                }
            }
            return false;
        } catch (SQLException e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<Show> getShowsByMovieId(int movieId) {
        List<Show> shows = new ArrayList<>();
        String query = "SELECT * FROM shows WHERE movie_id = ?";

        try (PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setInt(1, movieId);

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Show show = new Show();
                    show.setShowId(rs.getInt("show_id"));
                    show.setMovieId(rs.getInt("movie_id"));
                    show.setHallId(rs.getInt("hall_id"));
                    show.setStartDate(rs.getDate("start_date"));
                    show.setEndDate(rs.getDate("end_date"));

                    shows.add(show);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return shows;
    }

    public Show getUniqueShow(int movieId, int hallId, Date showDate, int slotId) {
        String query = "SELECT show_id FROM shows WHERE movie_id = ? AND hall_id = ? AND start_date <= ? AND end_date >= ? ";

        try (PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setInt(1, movieId);
            pstmt.setInt(2, hallId);
            pstmt.setDate(3, new java.sql.Date(showDate.getTime()));
            pstmt.setDate(4, new java.sql.Date(showDate.getTime()));
            pstmt.setInt(5, slotId);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    int showId = rs.getInt("show_id");

                    // Retrieve full show details
                    return getShowById(showId);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

// Helper method to get full show details by show ID
    public Show getShowById(int showId) {
        String query = "SELECT * FROM shows WHERE show_id = ?";

        try (PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setInt(1, showId);

            try (ResultSet rs = pstmt.executeQuery()) {
                if (rs.next()) {
                    Show show = new Show();
                    show.setShowId(rs.getInt("show_id"));
                    show.setMovieId(rs.getInt("movie_id"));
                    show.setHallId(rs.getInt("hall_id"));
                    show.setStartDate(rs.getDate("start_date"));
                    show.setEndDate(rs.getDate("end_date"));

                    return show;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return null;
    }

    private void populateSeatsForShow(int showId) {
        String query = "INSERT INTO seats (show_id, seat_number, is_booked) "
                + "WITH RECURSIVE seat_generator AS ( "
                + "    SELECT 1 AS seat_num "
                + "    UNION ALL "
                + "    SELECT seat_num + 1 "
                + "    FROM seat_generator "
                + "    WHERE seat_num < 40 "
                + ") "
                + "SELECT ?, "
                + "    CONCAT( "
                + "        CHAR(64 + (seat_generator.seat_num - 1) DIV 10 + 1), "
                + "        (seat_generator.seat_num - 1) MOD 10 + 1 "
                + "    ) AS seat_number, "
                + "    FALSE "
                + "FROM seat_generator";

        try (PreparedStatement pstmt = connection.prepareStatement(query)) {
            pstmt.setInt(1, showId);
            pstmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }

    // Other CRUD methods...
    public List<Show> getAllShows() {
        List<Show> shows = new ArrayList<>();
        String query = "SELECT show_id, movie_id, hall_id, start_date, end_date FROM shows";

        try (PreparedStatement pstmt = connection.prepareStatement(query); ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                Show show = new Show();
                show.setShowId(rs.getInt("show_id"));
                show.setMovieId(rs.getInt("movie_id"));
                show.setHallId(rs.getInt("hall_id"));
                show.setStartDate(rs.getDate("start_date"));
                show.setEndDate(rs.getDate("end_date"));

                shows.add(show);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return shows;
    }

    public List<Show> getFilteredShows(int movieId, int hallId, Date showDate) {
        List<Show> shows = new ArrayList<>();
        StringBuilder queryBuilder = new StringBuilder(
                "SELECT show_id, movie_id, hall_id, start_date, end_date "
                + "FROM shows WHERE 1=1 "
        );

        // Dynamic query building
        List<Object> params = new ArrayList<>();

        if (movieId > 0) {
            queryBuilder.append(" AND movie_id = ?");
            params.add(movieId);
        }

        if (hallId > 0) {
            queryBuilder.append(" AND hall_id = ?");
            params.add(hallId);
        }

        if (showDate != null) {
            queryBuilder.append(" AND ? BETWEEN start_date AND end_date");
            params.add(showDate);
        }

        try (PreparedStatement pstmt = connection.prepareStatement(queryBuilder.toString())) {
            // Set parameters dynamically
            for (int i = 0; i < params.size(); i++) {
                Object param = params.get(i);
                if (param instanceof Integer) {
                    pstmt.setInt(i + 1, (Integer) param);
                } else if (param instanceof Date) {
                    pstmt.setDate(i + 1, (Date) param);
                }
            }

            try (ResultSet rs = pstmt.executeQuery()) {
                while (rs.next()) {
                    Show show = new Show();
                    show.setShowId(rs.getInt("show_id"));
                    show.setMovieId(rs.getInt("movie_id"));
                    show.setHallId(rs.getInt("hall_id"));
                    show.setStartDate(rs.getDate("start_date"));
                    show.setEndDate(rs.getDate("end_date"));

                    shows.add(show);
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }

        return shows;
    }

    public List<Show> getAvailableShows(Date date) {
        List<Show> shows = new ArrayList<>();
        try {
            PreparedStatement stmt = connection.prepareStatement(
                    "SELECT s.*, m.movie_name, h.hall_name "
                    + "FROM shows s "
                    + "JOIN movies m ON s.movie_id = m.movie_id "
                    + "JOIN halls h ON s.hall_id = h.hall_id "
                    + "WHERE s.show_date = ?"
            );
            stmt.setDate(1, new java.sql.Date(date.getTime()));
            ResultSet rs = stmt.executeQuery();

            while (rs.next()) {
                Show show = new Show();
                Movie movie = new Movie();
                Hall hall = new Hall();

                movie.setMovieId(rs.getInt("movie_id"));
                movie.setMovieName(rs.getString("movie_name"));

                hall.setHallId(rs.getInt("hall_id"));
                hall.setHallName(rs.getString("hall_name"));

                show.setShowId(rs.getInt("show_id"));
                show.setMovieId(rs.getInt("movie_id"));
                show.setHallId(rs.getInt("hall_id"));
                show.setShowDate(rs.getDate("show_date"));

                shows.add(show);
            }
        } catch (SQLException e) {
            e.printStackTrace();
        }
        return shows;
    }

//newly added
    public List<LocalDate> getShowDatesByShowId(int showId) throws SQLException {
        String query = "SELECT DISTINCT show_date FROM show_schedule WHERE show_id = ?";
        List<LocalDate> showDates = new ArrayList<>();
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setInt(1, showId);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                showDates.add(resultSet.getDate("show_date").toLocalDate());
            }
        }
        return showDates;
    }

    public List<String> getTimeSlotsByShowId(int showId) throws SQLException {
        String query = "SELECT DISTINCT time_slot FROM show_schedule WHERE show_id = ?";
        List<String> timeSlots = new ArrayList<>();
        try (PreparedStatement preparedStatement = connection.prepareStatement(query)) {
            preparedStatement.setInt(1, showId);
            ResultSet resultSet = preparedStatement.executeQuery();
            while (resultSet.next()) {
                timeSlots.add(resultSet.getString("time_slot"));
            }
        }
        return timeSlots;
    }
}
