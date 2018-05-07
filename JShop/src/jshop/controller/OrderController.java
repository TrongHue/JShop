package jshop.controller;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import jshop.entity.Customer;
import jshop.entity.Order;
import jshop.entity.OrderDetail;
import jshop.entity.Product;
import jshop.utils.PagerModel;

@Controller
@RequestMapping("order")
@Transactional
public class OrderController extends JShopController{
	@Autowired
	HttpSession httpSession;
	
	@RequestMapping("products")
	public String products(ModelMap model,
			HttpServletRequest request) {
		Session session = sessionFactory.getCurrentSession();
		Customer user = (Customer) httpSession.getAttribute("user");
		String hqlCount = "SELECT COUNT(d.product) FROM OrderDetail d WHERE d.order.customer.id=:cid";
		Long rowCount = (Long) session.createQuery(hqlCount).setParameter("cid", user.getId()).uniqueResult();
		PagerModel pager = new PagerModel();
		pager = PagerModel.getPager("acpager", 12, rowCount.intValue(),request);
		pager.setRowCount(rowCount.intValue());
		pager.navigate(request);
		

		String hql = "SELECT DISTINCT d.product "
				+ " FROM OrderDetail d "
				+ " WHERE d.order.customer.id=:cid";
		Query query = session.createQuery(hql);
		query.setParameter("cid", user.getId());
		query.setFirstResult(pager.getStartRow());
		query.setMaxResults(pager.getPageSize());
		
		List<Product> list = query.list();
		model.addAttribute("list", list);
		model.addAttribute("flat", "../order/products");
		return "product-list";
	}
	
	@RequestMapping("list")
	public String list(ModelMap model) {
		Session session = sessionFactory.getCurrentSession();
		Customer user = (Customer) httpSession.getAttribute("user");

		String hql = "FROM Order WHERE customer.id=:cid";
		Query query = session.createQuery(hql);
		query.setParameter("cid", user.getId());
		
		model.addAttribute("orders", query.list());
		
		return "order-list";
	}
	
	@RequestMapping("detail/{id}")
	public String detail(ModelMap model, @PathVariable("id") int id) {
		Session session = sessionFactory.getCurrentSession();
		
		Order order = new Order();
		order.setId(id);
		session.refresh(order);
		
		String hql = "FROM OrderDetail WHERE order.id="+id;
		Query query = session.createQuery(hql);
		
		model.addAttribute("order", order);
		model.addAttribute("details", query.list());
		
		return "order-detail";
	}
	
	@RequestMapping("checkout")
	public String checkout(ModelMap model) {
		Customer user = (Customer) httpSession.getAttribute("user");
		
		Order order = new Order();
		order.setCustomer(user);
		order.setOrderDate(new Date());
		order.setReceiver(user.getFullname());
		order.setAmount(cart.getAmount());
		
		model.addAttribute("order", order);
		return "checkout";
	}
	
	@RequestMapping("purchase")
	public String purchase(ModelMap model, 
			@ModelAttribute Order order) {
		Session session = sessionFactory.getCurrentSession();
		try {
			session.save(order);
			for(Product p : cart.getItems()){
				OrderDetail detail = new OrderDetail();
				detail.setOrder(order);
				detail.setProduct(p);
				detail.setUnitPrice(p.getUnitPrice());
				detail.setQuantity(p.getQuantity());
				detail.setDiscount(p.getDiscount());
				
				session.save(detail);
			}
			cart.clear();
			return "redirect:/order/detail/"+order.getId()+".htm";
		} 
		catch (Exception e) {
			model.addAttribute("message", "�?ặt hàng thất bại !");
		}
		return "checkout";
	}
}
