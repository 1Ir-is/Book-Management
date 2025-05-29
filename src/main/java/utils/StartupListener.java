package utils;

import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
import java.sql.Connection;
import java.sql.ResultSet;
import java.sql.Statement;

@WebListener
public class StartupListener implements ServletContextListener {

    @Override
    public void contextInitialized(ServletContextEvent sce) {
        System.out.println(">>> Ung dung dang duoc khoi dong...");

        // tao bang database va admin neu chua co
        DatabaseInitializer.initializeDatabase();

        // them du lieu mau (vai tro admin va user)
        try (Connection conn = JDBCUtils.getConnection();
             Statement stmt = conn.createStatement()) {

            String checkAdminRoleSql = "SELECT * FROM vai_tro WHERE ma_vai_tro = 0";
            ResultSet rsAdminRole = stmt.executeQuery(checkAdminRoleSql);
            if (!rsAdminRole.next()) {
                stmt.executeUpdate("INSERT INTO vai_tro (ma_vai_tro, ten_vai_tro) VALUES (0, 'Admin')");
                System.out.println(">>> Them vai tro 'Admin'");
            }

            String checkUserRoleSql = "SELECT * FROM vai_tro WHERE ma_vai_tro = 1";
            ResultSet rsUserRole = stmt.executeQuery(checkUserRoleSql);
            if (!rsUserRole.next()) {
                stmt.executeUpdate("INSERT INTO vai_tro (ma_vai_tro, ten_vai_tro) VALUES (1, 'User')");
                System.out.println(">>> Them vai tro 'User'");
            }

            String checkAdminUserSql = "SELECT * FROM nguoi_dung WHERE email = 'admin@gmail.com'";
            ResultSet rsAdminUser = stmt.executeQuery(checkAdminUserSql);
            if (!rsAdminUser.next()) {
                stmt.executeUpdate("INSERT INTO nguoi_dung (ten, email, mat_khau, so_dien_thoai, dia_chi, ma_vai_tro) " +
                        "VALUES ('Admin', 'admin@gmail.com', '123', '0900000000', 'Hệ thống', 0)");
                System.out.println(">>> Them tai khoan admin.");
            }

        } catch (Exception e) {
            System.out.println("Loi khi them du lieu mau:");
            e.printStackTrace();
        }
    }

    @Override
    public void contextDestroyed(ServletContextEvent sce) {
    }
}
