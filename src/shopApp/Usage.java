package shopApp;

import java.sql.*;

public class Usage {
	public static Connection connection() throws Exception {

		Class.forName("org.postgresql.Driver");
        String SQLusername = "postgres";
        String SQLpassword = "postgres";
        // Open a connection to the database using DriverManager
        Connection conn = DriverManager.getConnection(
            "jdbc:postgresql://localhost:5432/test", SQLusername, SQLpassword
            );
        return conn;
    }
	
	public static String success(String s) {
        return "<div class=\"alert alert-success\">" + s + "</div>";
    }
	
	public static String failure(String s) {
        return "<div class=\"alert alert-danger\">" + s + "</div>";
    }
}
