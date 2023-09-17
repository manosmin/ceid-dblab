import java.sql.*;

public class dbConnect {
    private static Connection mycon=null;

    public Connection getConnection() throws ClassNotFoundException, SQLException {
        String db="test"; // replace with your database name
        String user = "your_username", pass = "your_password";
        String url = "jdbc:mysql://localhost:3306/"+db;
        Class.forName("com.mysql.cj.jdbc.Driver");
        Connection conn = DriverManager.getConnection(url,user,pass);
        return conn;
    }
}