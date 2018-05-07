package jshop.admin.controller;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import jshop.controller.JShopController;

@Controller
@RequestMapping("admin/inventory")
@Transactional
public class InventoryController extends JShopController{
	
	@RequestMapping("by-category")
	public String byCategory(ModelMap model) {
		String hql = "SELECT "
				+ "	p.category.name,"
				+ "	SUM(p.quantity),"
				+ " SUM(p.quantity*p.unitPrice), "
				+ " MIN(p.unitPrice), "
				+ " MAX(p.unitPrice), "
				+ " AVG(p.unitPrice) "
				+ " FROM Product p "
				+ " GROUP BY p.category.name";
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery(hql);
		List<Object[]> list = query.list();
		model.addAttribute("arrays", list);
		return "admin/inventory";
	}
	
	@RequestMapping("by-supplier")
	public String bySupplier(ModelMap model) {
		String hql = "SELECT "
				+ "	p.supplier.name,"
				+ "	SUM(p.quantity),"
				+ " SUM(p.quantity*p.unitPrice), "
				+ " MIN(p.unitPrice), "
				+ " MAX(p.unitPrice), "
				+ " AVG(p.unitPrice) "
				+ " FROM Product p "
				+ " GROUP BY p.supplier.name";
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery(hql);
		List<Object[]> list = query.list();
		model.addAttribute("arrays", list);
		return "admin/inventory";
	}
}
