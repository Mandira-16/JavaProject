package cinema.dao;

import cinema.connection.DbConnection;
import java.sql.*;
import java.util.*;

public class FeedbackDAO {

    public List<Map<String, String>> getAllFeedback() {
        List<Map<String, String>> feedbackList = new ArrayList<>();

        try (Connection conn = DbConnection.getConnection()) {
            if (conn != null) {
                String sql = "SELECT * FROM feedback ORDER BY submission_date DESC";
                try (Statement stmt = conn.createStatement(); ResultSet rs = stmt.executeQuery(sql)) {

                    while (rs.next()) {
                        Map<String, String> feedback = new HashMap<>();
                        feedback.put("name", rs.getString("name"));
                        feedback.put("phone", rs.getString("phone"));
                        feedback.put("email", rs.getString("email"));
                        feedback.put("movieRating", rs.getString("movie_rating"));
                        feedback.put("storylineRating", rs.getString("storyline_rating"));
                        feedback.put("cinematographyRating", rs.getString("cinematography_rating"));
                        feedback.put("cleanliness", rs.getString("cleanliness"));
                        feedback.put("comfort", rs.getString("comfort"));
                        feedback.put("soundQuality", rs.getString("sound_quality"));
                        feedback.put("otherfeedback",rs.getString("other_feedback"));
                        feedback.put("submissionDate", rs.getString("submission_date"));

                        feedbackList.add(feedback);
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return feedbackList;
    }
}
