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
import jshop.security.entity.Role;
import jshop.security.entity.User;
import jshop.security.entity.UserRole;

@Controller
@RequestMapping("admin/user")
@Transactional
public class UserController extends JShopController{
	@Autowired
	ServletContext application;
	
	public void addToUserRoles(User user) {
		Session session = sessionFactory.getCurrentSession();
		String hql = "FROM Role";
		Query query = session.createQuery(hql);
		List<Role> roles = query.list();
		for(Role r: roles){
			UserRole ur = new UserRole();
			ur.setUser(user);
			ur.setRole(r);
			ur.setAllow(false);
			session.save(ur);
		}
	}
	
	@ModelAttribute("users")
	public List<User> getUsers() {
		String hql = "FROM User";
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery(hql);
		return query.list();
	}
		
	@RequestMapping("index")
	public String index(ModelMap model) {
		model.addAttribute("user", new User());
		return "admin/user";
	}
	
	@RequestMapping("insert")
	public String insert(ModelMap model, @ModelAttribute User user) {
		Session session = sessionFactory.getCurrentSession();
		try {
			session.save(user);
			addToUserRoles(user);
			
			model.addAttribute("users", getUsers());
						
			model.addAttribute("message", "Thêm mới thành công !");
			model.addAttribute("user", new User()); // xóa form
		} 
		catch (Exception e) {
			model.addAttribute("message", "Thêm mới thất bại !");
		}
		return "admin/user";
	}

	@RequestMapping("update")
	public String update(ModelMap model, @ModelAttribute User user) {
		Session session = sessionFactory.getCurrentSession();
		try {
			session.update(user);
			model.addAttribute("users", getUsers());
			
			model.addAttribute("message", "Cập nhật thành công !");
		} 
		catch (Exception e) {
			model.addAttribute("message", "Cập nhật thất bại !");
		}
		return "admin/user";
	}
	
	@RequestMapping("edit/{id}")
	public String edit(ModelMap model,
			@ModelAttribute User user,
			@PathVariable String id) {
		Session session = sessionFactory.getCurrentSession();
		user.setId(id);
		session.refresh(user);
		
		return "admin/user"; 
	}
	
	@RequestMapping("delete/{id}")
	public String delete(ModelMap model,
			@ModelAttribute User user,
			@PathVariable String id) {
		
		Session session = sessionFactory.getCurrentSession();
		user.setId(id);
		session.delete(user);
		model.addAttribute("users", getUsers());
		
		return "admin/user"; 
	}
}
