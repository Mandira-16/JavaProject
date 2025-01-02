package cinema.servlet;

import cinema.dao.HallDAO;
import cinema.dao.MovieDAO;
import cinema.dao.ShowDAO;
import cinema.model.Movie;
import cinema.model.Show;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.sql.SQLException;
import java.util.List;

@WebServlet("/MovieDatailsServlet")
public class MovieDatailsServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String movieIdParam = request.getParameter("movieId");
        String action = request.getParameter("action");
        
        if (movieIdParam != null) {
            try {
                int movieId = Integer.parseInt(movieIdParam);
                MovieDAO moviesDAO = new MovieDAO();
                Movie movie = moviesDAO.getMovieById(movieId);
                
                if (movie != null) {
                    request.setAttribute("movie", movie);
                    
                    try (Connection connection = cinema.connection.DbConnection.getConnection()) {
                        if (connection != null) {
                            // Retrieve shows for the movie
                            ShowDAO showDAO = new ShowDAO(connection);
                            List<Show> shows = showDAO.getShowsByMovieId(movieId);
                            request.setAttribute("shows", shows);
                            
                            // Check if a specific show is selected
                            String showIdParam = request.getParameter("showId");
                            if (showIdParam != null) {
                                int showId = Integer.parseInt(showIdParam);
                                Show selectedShow = showDAO.getShowById(showId);
                                request.setAttribute("selectedShow", selectedShow);
                                
                                // Fetch hall name for the selected show
                                HallDAO hallDAO = new HallDAO(connection);
                                String hallName = hallDAO.getHallNameById(selectedShow.getHallId());
                                request.setAttribute("hallName", hallName);
                            }
                            
                            // Handle different actions
                           
                                request.getRequestDispatcher("viewShowDetails.jsp").forward(request, response);
                                return;
                        
                            
                        } else {
                            request.setAttribute("error", "Failed to establish a database connection.");
                            request.getRequestDispatcher("error.jsp").forward(request, response);
                        }
                    } catch (SQLException e) {
                        e.printStackTrace();
                        request.setAttribute("error", "Database error occurred: " + e.getMessage());
                        request.getRequestDispatcher("error.jsp").forward(request, response);
                    }
                } else {
                    response.sendRedirect("index.jsp");
                }
            } catch (NumberFormatException e) {
                e.printStackTrace();
                response.sendRedirect("index.jsp");
            }
        } else {
            response.sendRedirect("index.jsp");
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        // Handle post requests if needed
        doGet(request, response);
    }
}