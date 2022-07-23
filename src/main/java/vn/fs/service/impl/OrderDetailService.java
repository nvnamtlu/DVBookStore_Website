package vn.fs.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import vn.fs.entities.Order;
import vn.fs.entities.OrderDetail;
import vn.fs.repository.OrderDetailRepository;
import vn.fs.repository.OrderRepository;
import vn.fs.service.OrderService;

@Service
public class OrderDetailService implements OrderService {

	@Autowired
	OrderRepository repo;

	@Override
	public List<Order> listAll() {
		return repo.findAll();
	}

}
