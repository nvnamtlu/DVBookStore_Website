package vn.fs.dto;

import java.io.IOException;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.List;

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import lombok.Data;
import vn.fs.entities.Order;
import vn.fs.entities.OrderDetail;

@Data
public class OrderExcelExporter {
	
	private XSSFWorkbook workbook;
	private XSSFSheet sheet;

	private List<Order> listOrDetails;

	public OrderExcelExporter(List<Order> listOrDetails) {

		this.listOrDetails = listOrDetails;
		workbook = new XSSFWorkbook();
		sheet = workbook.createSheet("OrderDetails");
	}
	
	private void writeHeaderRow() {

		Row row = sheet.createRow(0);

		Cell cell = row.createCell(0);
		cell.setCellValue("Mã đơn hàng");
		
		cell = row.createCell(1);
		cell.setCellValue("Chi tiết đơn hàng");

		cell = row.createCell(2);
		cell.setCellValue("Tổng tiền");
		
		cell = row.createCell(3);
		cell.setCellValue("Trạng thái");
		
		cell = row.createCell(4);
		cell.setCellValue("Ngày đặt");
		
		cell = row.createCell(5);
		cell.setCellValue("Khách hàng");
		
		cell = row.createCell(6);
		cell.setCellValue("Số điện thoại");
		
		cell = row.createCell(7);
		cell.setCellValue("Địa chỉ");

	}
	
	private void writeDataRows() {
		int rowCount = 1;
		for (Order order : listOrDetails) {
			Row row = sheet.createRow(rowCount++);

			Cell cell = row.createCell(0);
			cell.setCellValue(order.getOrderId());
			
			cell = row.createCell(1);
			String strOrder = "";
			for(OrderDetail od : order.getOrderDetails()) {
				strOrder += od.getProduct().getProductName()+": "+od.getQuantity()+"; ";
			}
			cell.setCellValue(strOrder);
			
			cell = row.createCell(2);
			cell.setCellValue(order.getAmount());
			
			cell = row.createCell(3);
			String strStatus = "";
			if(order.getStatus()==0) {
				strStatus = "Chờ xác nhận";
			} else if (order.getStatus()==1) {
				strStatus = "Đang giao hàng";
			} else if (order.getStatus()==2) {
				strStatus = "Đã thanh toán";
			} else {
				strStatus = "Đã hủy";
			}
			cell.setCellValue(strStatus);
			
			DateFormat dateFormat = null;
			dateFormat = new SimpleDateFormat("dd/MM/yyyy");
			cell = row.createCell(4);
			cell.setCellValue(dateFormat.format(order.getOrderDate()));
			
			cell = row.createCell(5);
			cell.setCellValue(order.getUser().getName());
			
			cell = row.createCell(6);
			cell.setCellValue(order.getPhone());

			cell = row.createCell(7);
			cell.setCellValue(order.getAddress());

		}

	}
	
	public void export(HttpServletResponse response) throws IOException {

		writeHeaderRow();
		writeDataRows();

		ServletOutputStream outputStream = response.getOutputStream();
		workbook.write(outputStream);
		workbook.close();
		outputStream.close();

	}
}
