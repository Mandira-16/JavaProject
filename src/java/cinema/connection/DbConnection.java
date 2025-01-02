package cinema.connection;

import java.sql.Connection;
import java.sql.DriverManager;

public class DbConnection {

    private static Connection connection = null;

    public static Connection getConnection() {
        if (connection == null) {
            try {
                Class.forName("com.mysql.cj.jdbc.Driver");
                String url = "jdbc:mysql://localhost:3314/cinema";
                String username = "root";
                String password = "";
                Connection connection = DriverManager.getConnection(url, username, password);
                System.out.println("Database connection established successfully");
                return connection;
            } catch (Exception e) {
                System.err.println("Error establishing database connection: " + e.getMessage());
                e.printStackTrace();
            }
            return null;
        }
        return connection;
    }
}
