package cinema.servlet;

import cinema.dao.MovieDAO;
import cinema.model.Movie;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.nio.file.Files;
import java.nio.file.Paths;
import java.nio.file.StandardCopyOption;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;

@WebServlet(name = "AddMovieServlet", urlPatterns = {"/addMovie"})
@MultipartConfig
public class AddMovieServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        try {
            // Retrieve form parameters
            int movieId = Integer.parseInt(request.getParameter("movie-id"));
            String movieName = request.getParameter("movie-name");
            String movieLanguage = request.getParameter("movie-language");
            String movieContent = request.getParameter("movie-content");
            String movieTrailerLink = request.getParameter("movie-trailer");
            String movieStatus = request.getParameter("movie-status");
            int movieTicketPrice = Integer.parseInt(request.getParameter("movie-ticket-price"));
            String movieRated = request.getParameter("movie-rated");

            // Handle file upload
            Part filePart = request.getPart("movie-image");
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();

            // Define upload paths
            String uploadPath = "C:\\Users\\Mandira\\Desktop\\Cinema\\web\\images";
            String relativeImagePath = "images/" + fileName;

            // Ensure upload directory exists
            File uploadDir = new File(uploadPath);
            if (!uploadDir.exists()) {
                uploadDir.mkdirs();
            }

            // Save the file to the server
            String absoluteImagePath = uploadPath + File.separator + fileName;
            try (InputStream fileContent = filePart.getInputStream()) {
                Files.copy(fileContent, Paths.get(absoluteImagePath), StandardCopyOption.REPLACE_EXISTING);
            }

            // Create movie object
            Movie movie = new Movie(
                movieId, 
                movieName, 
                movieLanguage, 
                movieContent, 
                movieTrailerLink, 
                relativeImagePath, 
                movieStatus, 
                movieTicketPrice, 
                movieRated
            );

            // Save movie to the database
            MovieDAO moviesDAO = new MovieDAO();
            boolean isAdded = moviesDAO.addMovie(movie);

            if (isAdded) {
                request.setAttribute("message", "Movie added successfully!");
            } else {
                request.setAttribute("message", "Failed to add movie. Please try again.");
            }
        } catch (NumberFormatException e) {
            request.setAttribute("message", "Invalid input. Please check your data.");
        } catch (Exception e) {
            request.setAttribute("message", "An unexpected error occurred.");
            e.printStackTrace();
        }

        // Forward to response page
        request.getRequestDispatcher("/addMovie.jsp").forward(request, response);
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Servlet to add a new movie";
    }
}