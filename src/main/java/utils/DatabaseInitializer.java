package utils;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.sql.*;
import java.util.Properties;

public class DatabaseInitializer {

    public static void initializeDatabase() {
        try {
            Properties props = new Properties();
            try (InputStream input = DatabaseInitializer.class.getClassLoader()
                    .getResourceAsStream("config-init.properties")) {
                props.load(input);
            }

            String url = props.getProperty("db.url");
            String user = props.getProperty("db.user");
            String password = props.getProperty("db.password");

            Class.forName("com.mysql.cj.jdbc.Driver");

            try (Connection conn = DriverManager.getConnection(url, user, password);
                 Statement stmt = conn.createStatement()) {

                stmt.executeUpdate("CREATE DATABASE IF NOT EXISTS bookdatabase CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci");
                System.out.println(">>> Database 'bookdatabase' da duoc tao hoac da ton tai.");
            }

            // Sau khi tạo DB, kết nối lại để tạo bảng
            try (Connection conn = JDBCUtils.getConnection()) {
                String sqlScript = readSqlScript("schema.sql");
                Statement stmt = conn.createStatement();
                for (String sql : sqlScript.split(";")) {
                    if (!sql.trim().isEmpty()) {
                        stmt.execute(sql);
                    }
                }
                System.out.println(">>> Cac bang da duoc tao thanh cong!!!.");
            }

        } catch (Exception e) {
            System.out.println("Loi khi khoi tao database:" + e.getMessage());
            e.printStackTrace();
        }
    }

    private static String readSqlScript(String fileName) throws Exception {
        InputStream inputStream = DatabaseInitializer.class.getClassLoader().getResourceAsStream(fileName);
        if (inputStream == null) throw new Exception("Không tìm thấy file schema.sql");
        BufferedReader reader = new BufferedReader(new InputStreamReader(inputStream));
        StringBuilder sqlBuilder = new StringBuilder();
        String line;
        while ((line = reader.readLine()) != null) {
            sqlBuilder.append(line).append("\n");
        }
        return sqlBuilder.toString();
    }
}
