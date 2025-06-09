package controllers.admin;

import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import services.order.IOrderService;
import services.order.OrderService;
import repositories.cart.CartRepository;
import repositories.cart_details.CartDetailsRepository;
import utils.JDBCUtils;

import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Connection;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

@WebServlet(name = "AdminExportOrderExcelServlet", urlPatterns = {"/admin/export-orders"})
public class AdminExportOrderExcelServlet extends HttpServlet {

    private final IOrderService orderService;

    public AdminExportOrderExcelServlet() {
        try (Connection connection = JDBCUtils.getConnection()) {
            this.orderService = new OrderService(new CartRepository(connection), new CartDetailsRepository(connection));
        } catch (Exception e) {
            throw new RuntimeException("Failed to initialize OrderService", e);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment; filename=orders.xlsx");

        List<Object[]> orders = orderService.getAllOrders();
        Workbook workbook = new XSSFWorkbook();
        Sheet sheet = workbook.createSheet("Orders");

        // Style with border
        CellStyle borderStyle = workbook.createCellStyle();
        borderStyle.setBorderTop(BorderStyle.THIN);
        borderStyle.setBorderBottom(BorderStyle.THIN);
        borderStyle.setBorderLeft(BorderStyle.THIN);
        borderStyle.setBorderRight(BorderStyle.THIN);

        // Style for header: border + bold
        Font headerFont = workbook.createFont();
        headerFont.setBold(true);
        CellStyle headerStyle = workbook.createCellStyle();
        headerStyle.cloneStyleFrom(borderStyle);
        headerStyle.setFont(headerFont);

        // Create header row
        Row headerRow = sheet.createRow(0);
        String[] columns = {"Mã đơn hàng", "Ngày đặt", "Trạng thái", "Người đặt", "Email", "Sản phẩm và số lượng", "Tổng tiền"};
        for (int i = 0; i < columns.length; i++) {
            Cell cell = headerRow.createCell(i);
            cell.setCellValue(columns[i]);
            cell.setCellStyle(headerStyle);
        }

        // Date format
        SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");

        // Add data for each order
        for (int i = 0; i < orders.size(); i++) {
            Object[] order = orders.get(i);
            Row row = sheet.createRow(i + 1);

            Cell cell0 = row.createCell(0);
            cell0.setCellValue(order[0].toString());
            cell0.setCellStyle(borderStyle);

            Cell cell1 = row.createCell(1);
            if (order[1] instanceof Date) {
                cell1.setCellValue(sdf.format((Date) order[1]));
            } else {
                cell1.setCellValue(order[1].toString());
            }
            cell1.setCellStyle(borderStyle);

            Cell cell2 = row.createCell(2);
            cell2.setCellValue(order[2].toString());
            cell2.setCellStyle(borderStyle);

            Cell cell3 = row.createCell(3);
            cell3.setCellValue(order[3].toString());
            cell3.setCellStyle(borderStyle);

            Cell cell4 = row.createCell(4);
            cell4.setCellValue(order[4].toString());
            cell4.setCellStyle(borderStyle);

            Cell cell5 = row.createCell(5);
            cell5.setCellValue(order[5].toString());
            cell5.setCellStyle(borderStyle);

            Cell cell6 = row.createCell(6);
            if (order[6] instanceof Number) {
                cell6.setCellValue(Double.parseDouble(order[6].toString()));
            } else {
                cell6.setCellValue(order[6].toString());
            }
            cell6.setCellStyle(borderStyle);
        }

        // Auto-adjust column widths
        for (int i = 0; i < columns.length; i++) {
            sheet.autoSizeColumn(i);
        }

        // Write workbook to response output stream
        try (ServletOutputStream outputStream = response.getOutputStream()) {
            workbook.write(outputStream);
        }

        workbook.close();
    }
}