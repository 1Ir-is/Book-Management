package controllers.admin;

import org.apache.poi.ss.usermodel.*;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import services.order.IOrderService;
import services.order.OrderService;

import javax.servlet.ServletOutputStream;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.List;

@WebServlet(name = "ExportOrderExcelServlet", urlPatterns = {"/admin/export-orders"})
public class ExportOrderExcelServlet extends HttpServlet {

    private final IOrderService orderService = new OrderService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
        response.setHeader("Content-Disposition", "attachment; filename=orders.xlsx");

        List<Object[]> orders = orderService.getAllOrders();
        Workbook workbook = new XSSFWorkbook();
        Sheet sheet = workbook.createSheet("Orders");

        // Style có border
        CellStyle borderStyle = workbook.createCellStyle();
        borderStyle.setBorderTop(BorderStyle.THIN);
        borderStyle.setBorderBottom(BorderStyle.THIN);
        borderStyle.setBorderLeft(BorderStyle.THIN);
        borderStyle.setBorderRight(BorderStyle.THIN);

        // Style cho tiêu đề: border + in đậm
        Font headerFont = workbook.createFont();
        headerFont.setBold(true);
        CellStyle headerStyle = workbook.createCellStyle();
        headerStyle.cloneStyleFrom(borderStyle);
        headerStyle.setFont(headerFont);

        // Tạo dòng tiêu đề
        Row headerRow = sheet.createRow(0);
        String[] columns = {"Mã đơn hàng", "Ngày đặt", "Trạng thái", "Người đặt", "Email", "Sản phẩm và số lượng", "Tổng tiền"};
        for (int i = 0; i < columns.length; i++) {
            Cell cell = headerRow.createCell(i);
            cell.setCellValue(columns[i]);
            cell.setCellStyle(headerStyle);
        }

        // Định dạng ngày
        SimpleDateFormat sdf = new SimpleDateFormat("dd-MM-yyyy");

        // Thêm dữ liệu từng đơn hàng
        for (int i = 0; i < orders.size(); i++) {
            Object[] order = orders.get(i);
            Row row = sheet.createRow(i + 1);

            Cell cell0 = row.createCell(0);
            cell0.setCellValue(order[0].toString());
            cell0.setCellStyle(borderStyle);

            Cell cell1 = row.createCell(1);
            cell1.setCellValue(sdf.format(order[1]));
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
            cell6.setCellValue((Double) order[6]);
            cell6.setCellStyle(borderStyle);
        }

        // Tự động điều chỉnh độ rộng cột
        for (int i = 0; i < columns.length; i++) {
            sheet.autoSizeColumn(i);
        }

        // Ghi file vào response output stream
        try (ServletOutputStream outputStream = response.getOutputStream()) {
            workbook.write(outputStream);
        }

        workbook.close();
    }
}
