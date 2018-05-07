package jshop.admin.controller;

import java.util.Date;
import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jshop.controller.JShopController;

@Controller
@RequestMapping("admin/revenue")
@Transactional
public class RevenueController extends JShopController{
	
	@RequestMapping("by-product")
	public String byProduct(ModelMap model,
			@RequestParam(defaultValue="01/01/1900") Date min,
			@RequestParam(defaultValue="12/31/2900") Date max) {

		String hql = "SELECT "
				+ " d.product.name, "
				+ " SUM(d.quantity), "
				+ " SUM(d.quantity*d.unitPrice*(1-d.discount)), "
				+ " MIN(d.unitPrice), "
				+ " MAX(d.unitPrice), "
				+ " AVG(d.unitPrice) "
				+ " FROM OrderDetail d "
				+ " WHERE d.order.orderDate BETWEEN :min AND :max"
				+ " GROUP BY d.product.name";
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery(hql);
		query.setParameter("min", min);
		query.setParameter("max", max);
		List<Object[]> list = query.list();
		
		model.addAttribute("arrays", list);
		
		return "admin/revenue";
	}
	
	@RequestMapping("by-category")
	public String byCategory(ModelMap model,
			@RequestParam(defaultValue="01/01/1900") Date min,
			@RequestParam(defaultValue="12/31/2900") Date max) {

		String hql = "SELECT "
				+ " d.product.category.name, "
				+ " SUM(d.quantity), "
				+ " SUM(d.quantity*d.unitPrice*(1-d.discount)), "
				+ " MIN(d.unitPrice), "
				+ " MAX(d.unitPrice), "
				+ " AVG(d.unitPrice) "
				+ " FROM OrderDetail d "
				+ " WHERE d.order.orderDate BETWEEN :min AND :max"
				+ " GROUP BY d.product.category.name";
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery(hql);
		query.setParameter("min", min);
		query.setParameter("max", max);
		List<Object[]> list = query.list();
		
		model.addAttribute("arrays", list);
		
		return "admin/revenue";
	}
	
	@RequestMapping("by-supplier")
	public String bySupplier(ModelMap model,
			@RequestParam(defaultValue="01/01/1900") Date min,
			@RequestParam(defaultValue="12/31/2900") Date max) {

		String hql = "SELECT "
				+ " d.product.supplier.name, "
				+ " SUM(d.quantity), "
				+ " SUM(d.quantity*d.unitPrice*(1-d.discount)), "
				+ " MIN(d.unitPrice), "
				+ " MAX(d.unitPrice), "
				+ " AVG(d.unitPrice) "
				+ " FROM OrderDetail d "
				+ " WHERE d.order.orderDate BETWEEN :min AND :max"
				+ " GROUP BY d.product.supplier.name";
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery(hql);
		query.setParameter("min", min);
		query.setParameter("max", max);
		List<Object[]> list = query.list();
		
		model.addAttribute("arrays", list);
		
		return "admin/revenue";
	}
	
	@RequestMapping("by-customer")
	public String byCustomer(ModelMap model,
			@RequestParam(defaultValue="01/01/1900") Date min,
			@RequestParam(defaultValue="12/31/2900") Date max) {

		String hql = "SELECT "
				+ " d.order.customer.fullname, "
				+ " SUM(d.quantity), "
				+ " SUM(d.quantity*d.unitPrice*(1-d.discount)), "
				+ " MIN(d.unitPrice), "
				+ " MAX(d.unitPrice), "
				+ " AVG(d.unitPrice) "
				+ " FROM OrderDetail d "
				+ " WHERE d.order.orderDate BETWEEN :min AND :max"
				+ " GROUP BY d.order.customer.fullname";
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery(hql);
		query.setParameter("min", min);
		query.setParameter("max", max);
		List<Object[]> list = query.list();
		
		model.addAttribute("arrays", list);
		
		return "admin/revenue";
	}
	
	@RequestMapping("by-year")
	public String byYear(ModelMap model,
			@RequestParam(defaultValue="01/01/1900") Date min,
			@RequestParam(defaultValue="12/31/2900") Date max) {

		String hql = "SELECT "
				+ " YEAR(d.order.orderDate), "
				+ " SUM(d.quantity), "
				+ " SUM(d.quantity*d.unitPrice*(1-d.discount)), "
				+ " MIN(d.unitPrice), "
				+ " MAX(d.unitPrice), "
				+ " AVG(d.unitPrice) "
				+ " FROM OrderDetail d "
				+ " WHERE d.order.orderDate BETWEEN :min AND :max"
				+ " GROUP BY YEAR(d.order.orderDate)";
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery(hql);
		query.setParameter("min", min);
		query.setParameter("max", max);
		List<Object[]> list = query.list();
		
		model.addAttribute("arrays", list);
		
		return "admin/revenue";
	}
	
	@RequestMapping("by-quarter")
	public String byQuarter(ModelMap model,
			@RequestParam(defaultValue="01/01/1900") Date min,
			@RequestParam(defaultValue="12/31/2900") Date max) {

		String hql = "SELECT "
				+ " CAST(CEILING(MONTH(d.order.orderDate)/3.0) as int), "
				+ " SUM(d.quantity), "
				+ " SUM(d.quantity*d.unitPrice*(1-d.discount)), "
				+ " MIN(d.unitPrice), "
				+ " MAX(d.unitPrice), "
				+ " AVG(d.unitPrice) "
				+ " FROM OrderDetail d "
				+ " WHERE d.order.orderDate BETWEEN :min AND :max"
				+ " GROUP BY CAST(CEILING(MONTH(d.order.orderDate)/3.0) as int)";
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery(hql);
		query.setParameter("min", min);
		query.setParameter("max", max);
		List<Object[]> list = query.list();
		
		model.addAttribute("arrays", list);
		
		return "admin/revenue";
	}
	
	@RequestMapping("by-month")
	public String byMonth(ModelMap model,
			@RequestParam(defaultValue="01/01/1900") Date min,
			@RequestParam(defaultValue="12/31/2900") Date max) {

		String hql = "SELECT "
				+ " MONTH(d.order.orderDate), "
				+ " SUM(d.quantity), "
				+ " SUM(d.quantity*d.unitPrice*(1-d.discount)), "
				+ " MIN(d.unitPrice), "
				+ " MAX(d.unitPrice), "
				+ " AVG(d.unitPrice) "
				+ " FROM OrderDetail d "
				+ " WHERE d.order.orderDate BETWEEN :min AND :max"
				+ " GROUP BY MONTH(d.order.orderDate)";
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery(hql);
		query.setParameter("min", min);
		query.setParameter("max", max);
		List<Object[]> list = query.list();
		
		model.addAttribute("arrays", list);
		
		return "admin/revenue";
	}
}
