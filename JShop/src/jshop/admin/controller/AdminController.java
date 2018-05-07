package jshop.admin.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import jshop.controller.JShopController;
import jshop.entity.Category;
import jshop.entity.Customer;
import jshop.security.entity.User;

@Controller
@Transactional
@RequestMapping("admin")
public class AdminController extends JShopController{
	@Autowired
	HttpSession session;
	
	@RequestMapping("home")
	public String index(ModelMap model
			){
		return "admin/home";
	}
	
	@RequestMapping(value="login", method=RequestMethod.GET)
	public String login(ModelMap model,
			@ModelAttribute User user,
			@RequestParam(required=false) String logoff, 
			@RequestParam(required=false) String authenticate,
			@RequestParam(required=false) String authorize) {
		if(authenticate != null){
			model.addAttribute("message", "Báº¡n chÆ°a Ä‘Äƒng nháº­p !");
		}
		if(authorize != null){
			model.addAttribute("message", "Báº¡n khÃ´ng cÃ³ quyá»�n sá»­ dá»¥ng chá»©c nÄƒng nÃ y !");
		}
		if(logoff != null){
			model.addAttribute("message", "Báº¡n Ä‘Ã£ Ä‘Äƒng xuáº¥t thÃ nh cÃ´ng !");
			session.removeAttribute("master");
		}
		
		model.addAttribute("master", user);
		return "admin/login";
	}
		
	@RequestMapping(value="login", method=RequestMethod.POST)
	public String login(ModelMap model, 
			@ModelAttribute("master") User user) {
		User user1 = new User();
		user1.setId(user.getId());	
		try {
			sessionFactory.getCurrentSession().refresh(user1);
			System.out.println(user1.getPassword());
			System.out.println(user.getPassword());
			if((user.getPassword()).equalsIgnoreCase(user1.getPassword())){
				model.addAttribute("master", user);
				session.setAttribute("master", user);
				model.addAttribute("message", "Ä�Äƒng nháº­p thÃ nh cÃ´ng !");
				return "admin/home";
			}
			else{
				model.addAttribute("message", "Sai máº­t kháº©u !");
				return "admin/login";
			}
		} 
		catch (Exception e) {
			model.addAttribute("message", "Sai tÃªn Ä‘Äƒng nháº­p !");
			return "admin/login";
		}
	}
	@ModelAttribute("proRevenue")
	public List<Object[]> getProRevenue() {
		String hql = "SELECT "
				+ " d.product.name, "
				+ " SUM(d.quantity*d.unitPrice*(1-d.discount)) "
				+ " FROM OrderDetail d "
				+ " GROUP BY d.product.name";
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery(hql);
		List<Object[]> list = query.list();
		return list;
	}
	@ModelAttribute("cateRevenue")
	public List<Object[]> getCateRevenue() {
		String hql = "SELECT "
				+ " d.product.category.name, "
				+ " SUM(d.quantity*d.unitPrice*(1-d.discount)) "
				+ " FROM OrderDetail d "
				+ " GROUP BY d.product.category.name";
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery(hql);
		List<Object[]> list = query.list();
		return list;
	}
	@ModelAttribute("supRevenue")
	public List<Object[]> getSupRevenue() {
		String hql = "SELECT "
				+ " d.product.supplier.name, "
				+ " SUM(d.quantity*d.unitPrice*(1-d.discount)) "
				+ " FROM OrderDetail d "
				+ " GROUP BY d.product.supplier.name";
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery(hql);
		List<Object[]> list = query.list();
		return list;
	}
	@ModelAttribute("yearRevenue")
	public List<Object[]> getYearRevenue() {
		String hql = "SELECT "
				+ " YEAR(d.order.orderDate), "
				+ " SUM(d.quantity*d.unitPrice*(1-d.discount)) "
				+ " FROM OrderDetail d "
				+ " GROUP BY YEAR(d.order.orderDate)";
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery(hql);
		List<Object[]> list = query.list();
		return list;
	}
	
	
}

