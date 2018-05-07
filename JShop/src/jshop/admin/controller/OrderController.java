package jshop.admin.controller;
import java.util.List;

import javax.servlet.ServletContext;

import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import jshop.controller.JShopController;
import jshop.entity.Order;
import jshop.entity.Product;

@Controller("adminOrderController")
@RequestMapping("admin/order")
@Transactional
public class OrderController extends JShopController{
	@Autowired
	ServletContext application;
	
	@ModelAttribute("orders")
	public List<Product> getOrders() {
		String hql = "FROM Order";
		
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery(hql);
		return query.list();
	}
		
	@RequestMapping("index")
	public String index(ModelMap model) {
		model.addAttribute("order", new Order());
		return "admin/order";
	}
	
	@RequestMapping("update")
	public String update(ModelMap model,
			@ModelAttribute Order order) {
		Session session = sessionFactory.getCurrentSession();
			session.update(order);
			model.addAttribute("orders", getOrders());
			model.addAttribute("message", "Cập nhật thành công !");
		return "admin/order";
	}
	
	@RequestMapping("edit/{id}")
	public String edit(ModelMap model,
			@ModelAttribute Order order,
			@PathVariable Integer id) {
		
		order.setId(id);
		Session session = sessionFactory.getCurrentSession();
		session.refresh(order);
		
		return "admin/order"; 
	}
	
	@RequestMapping("delete/{id}")
	public String delete(ModelMap model,
			@ModelAttribute Order order,
			@PathVariable Integer id) {
		
		Session session = sessionFactory.getCurrentSession();
		order.setId(id);
		session.delete(order);
		
		model.addAttribute("message", "Xóa hóa đơn thành công !");
		
		//add vào model để update danh sách
		model.addAttribute("orders", getOrders());
		
		return "admin/order"; 
	}
}
