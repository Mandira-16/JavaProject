package cinema.dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class HallDAO {
    private final Connection connection;

    public HallDAO(Connection connection) {
        this.connection = connection;
    }

    // Method to get the hall name by its ID
    public String getHallNameById(int hallId) throws SQLException {
        String hallName = null;
        String query = "SELECT name FROM halls WHERE id = ?";
        
        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setInt(1, hallId);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    hallName = resultSet.getString("name");
                }
            }
        }
        return hallName;
    }

    // Method to get the hall ID by its name
    public int getHallIdByName(String hallName) throws SQLException {
        int hallId = -1; // Default value if no hall is found
        String query = "SELECT id FROM halls WHERE name = ?";

        try (PreparedStatement statement = connection.prepareStatement(query)) {
            statement.setString(1, hallName);
            try (ResultSet resultSet = statement.executeQuery()) {
                if (resultSet.next()) {
                    hallId = resultSet.getInt("id");
                }
            }
        }
        return hallId;
    }
}
