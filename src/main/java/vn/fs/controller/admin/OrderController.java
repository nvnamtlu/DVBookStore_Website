package vn.fs.controller.admin;

import java.io.IOException;
import java.security.Principal;
import java.util.Collections;
import java.util.List;
import java.util.Optional;
import java.util.stream.Collectors;
import java.util.stream.IntStream;

import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageImpl;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

import vn.fs.dto.OrderExcelExporter;
import vn.fs.entities.Order;
import vn.fs.entities.OrderDetail;
import vn.fs.entities.Product;
import vn.fs.entities.User;
import vn.fs.repository.OrderDetailRepository;
import vn.fs.repository.OrderRepository;
import vn.fs.repository.ProductRepository;
import vn.fs.repository.UserRepository;
import vn.fs.service.SendMailService;
import vn.fs.service.impl.OrderDetailService;

@Controller
@RequestMapping("/admin")
public class OrderController {

	@Autowired
	OrderDetailService orderDetailService;

	@Autowired
	OrderRepository orderRepository;

	@Autowired
	OrderDetailRepository orderDetailRepository;

	@Autowired
	ProductRepository productRepository;

	@Autowired
	SendMailService sendMailService;

	@Autowired
	UserRepository userRepository;

	@ModelAttribute(value = "user")
	public User user(Model model, Principal principal, User user) {

		if (principal != null) {
			model.addAttribute("user", new User());
			user = userRepository.findByEmail(principal.getName());
			model.addAttribute("user", user);
		}

		return user;
	}

	// list order
	@GetMapping(value = "/orders")
	public String orders(Model model, Principal principal,  @RequestParam(required = false, value = "page") Integer page, @RequestParam(required = false, value = "size") Integer size) {
		
		if(page == null && size == null) {
			page = 1;
			size = 6;
		}
		int currentPage = page;
		int pageSize = size;

		Page<Order> orderPage = findPaginated(PageRequest.of(currentPage - 1, pageSize));

		int totalPages = orderPage.getTotalPages();
		if (totalPages > 0) {
			List<Integer> pageNumbers = IntStream.rangeClosed(1, totalPages).boxed().collect(Collectors.toList());
			model.addAttribute("pageNumbers", pageNumbers);
		}

		model.addAttribute("orderDetails", orderPage);
		
		return "admin/orders";
	}
	
	public Page<Order> findPaginated(Pageable pageable) {

		List<Order> orderPage = orderRepository.findAll();

		int pageSize = pageable.getPageSize();
		int currentPage = pageable.getPageNumber();
		int startItem = currentPage * pageSize;
		List<Order> list;

		if (orderPage.size() < startItem) {
			list = Collections.emptyList();
		} else {
			int toIndex = Math.min(startItem + pageSize, orderPage.size());
			list = orderPage.subList(startItem, toIndex);
		}

		Page<Order> orderPages = new PageImpl<Order>(list, PageRequest.of(currentPage, pageSize), orderPage.size());

		return orderPages;
	}

	@GetMapping("/order/detail/{order_id}")
	public ModelAndView detail(ModelMap model, @PathVariable("order_id") Long id) {

		List<OrderDetail> listO = orderDetailRepository.findByOrderId(id);

		model.addAttribute("amount", orderRepository.findById(id).get().getAmount());
		model.addAttribute("orderDetail", listO);
		model.addAttribute("orderId", id);
		// set active front-end
		model.addAttribute("menuO", "menu");
		return new ModelAndView("admin/editOrder", model);
	}

	@RequestMapping("/order/cancel/{order_id}")
	public ModelAndView cancel(ModelMap model, @PathVariable("order_id") Long id, @RequestParam("page") Integer page, @RequestParam("size") Integer size) {
		Optional<Order> o = orderRepository.findById(id);
		if (!o.isPresent()) {
			return new ModelAndView("redirect:/admin/orders?page="+page+"&size="+size, model);
		}
		
		Order oReal = o.get();
		List<OrderDetail> orderDetails = oReal.getOrderDetails();
		for(OrderDetail od: orderDetails) {
			System.out.println(od.getProduct() + " " + od.getQuantity());
			Product p = od.getProduct();
			p.setQuantity(p.getQuantity() + od.getQuantity());
			productRepository.save(p);
		}
		oReal.setStatus((short) 3);
		orderRepository.save(oReal);

		return new ModelAndView("redirect:/admin/orders?page="+page+"&size="+size, model);
	}

	@RequestMapping("/order/confirm/{order_id}")
	public ModelAndView confirm(ModelMap model, @PathVariable("order_id") Long id, @RequestParam("page") Integer page, @RequestParam("size") Integer size) {
		Optional<Order> o = orderRepository.findById(id);
		if (!o.isPresent()) {
			return new ModelAndView("redirect:/admin/orders?page="+page+"&size="+size, model);
		}
		Order oReal = o.get();
		oReal.setStatus((short) 1);
		orderRepository.save(oReal);

		return new ModelAndView("redirect:/admin/orders?page="+page+"&size="+size, model);
	}

	@RequestMapping("/order/delivered/{order_id}")
	public ModelAndView delivered(ModelMap model, @PathVariable("order_id") Long id, @RequestParam("page") Integer page, @RequestParam("size") Integer size) {
		Optional<Order> o = orderRepository.findById(id);
		if (!o.isPresent()) {
			return new ModelAndView("forward:/admin/orders", model);
		}
		Order oReal = o.get();
		oReal.setStatus((short) 2);
		orderRepository.save(oReal);

		Product p = null;
		List<OrderDetail> listDe = orderDetailRepository.findByOrderId(id);
		for (OrderDetail od : listDe) {
			p = od.getProduct();
			p.setQuantity(p.getQuantity() - od.getQuantity());
			productRepository.save(p);
		}

		/* return new ModelAndView("forward:/admin/orders", model); */
		return new ModelAndView("redirect:/admin/orders?page="+page+"&size="+size, model);
	}

	// to excel
	@GetMapping(value = "/export")
	public void exportToExcel(HttpServletResponse response) throws IOException {

		response.setContentType("application/octet-stream");
		String headerKey = "Content-Disposition";
		String headerValue = "attachement; filename=orders.xlsx";

		response.setHeader(headerKey, headerValue);

		List<Order> lisOrders = orderDetailService.listAll();

		OrderExcelExporter excelExporter = new OrderExcelExporter(lisOrders);
		excelExporter.export(response);
		
	}

}
