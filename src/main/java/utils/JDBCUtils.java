package utils;

import java.io.IOException;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.util.Properties;

public class JDBCUtils {
    private static final String URL;
    private static final String USER;
    private static final String PASSWORD;

    static {
        Properties props = new Properties();
        try (InputStream input = JDBCUtils.class.getClassLoader().getResourceAsStream("config.properties")) {
            if (input != null) {
                props.load(input);
                URL = props.getProperty("db.url");
                USER = props.getProperty("db.user");
                PASSWORD = props.getProperty("db.password");
            } else {
                throw new RuntimeException("Khong tim thay file cau hinh!");
            }
        } catch (IOException e) {
            throw new RuntimeException("Loi khi doc file config.properties", e);
        }

        try {
            Class.forName("com.mysql.cj.jdbc.Driver"); // nap driver
        } catch (ClassNotFoundException e) {
            throw new RuntimeException("Khong tim thay driver MySQL", e);
        }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(URL, USER, PASSWORD);
    }
}