package jshop.admin.controller;

import java.util.List;

import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import jshop.controller.JShopController;
import jshop.security.entity.Action;
import jshop.security.entity.Permission;
import jshop.security.entity.Role;
import jshop.security.entity.User;
import jshop.security.entity.UserRole;

@Controller
@RequestMapping("admin/role")
@Transactional
public class RoleController extends JShopController{
	
	public void addToUserRoles(Role role) {
		Session session = sessionFactory.getCurrentSession();
		String hql = "FROM User";
		Query query = session.createQuery(hql);
		List<User> users = query.list();
		for(User u: users){
			UserRole ur = new UserRole();
			ur.setUser(u);
			ur.setRole(role);
			ur.setAllow(false);
			session.save(ur);
		}
	}
	
	public void addToPermissions(Role role) {
		Session session = sessionFactory.getCurrentSession();
		String hql = "FROM Action";
		Query query = session.createQuery(hql);
		List<Action> actions = query.list();
		for(Action a: actions){
			Permission p = new Permission();
			p.setAction(a);
			p.setRole(role);
			p.setAllow(false);
			session.save(p);
		}
	}
	
	@ModelAttribute("roles")
	public List<Role> getRoles() {
		String hql = "FROM Role";
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery(hql);
		return query.list();
	}
		
	@RequestMapping("index")
	public String index(ModelMap model) {
		model.addAttribute("role", new Role());
		return "admin/role";
	}
	
	@RequestMapping("insert")
	public String insert(ModelMap model, @ModelAttribute Role role) {
		Session session = sessionFactory.getCurrentSession();
		try {
			session.save(role);
			addToUserRoles(role);
			addToPermissions(role);
			
			model.addAttribute("roles", getRoles());
						
			model.addAttribute("message", "Thêm mới thành công !");
			model.addAttribute("role", new Role()); // xóa form
		} 
		catch (Exception e) {
			model.addAttribute("message", "Thêm mới thất bại !");
		}
		return "admin/role";
	}

	@RequestMapping("update")
	public String update(ModelMap model, @ModelAttribute Role role) {
		Session session = sessionFactory.getCurrentSession();
		try {
			session.update(role);
			model.addAttribute("roles", getRoles());
			
			model.addAttribute("message", "Cập nhật thành công !");
		} 
		catch (Exception e) {
			model.addAttribute("message", "Cập nhật thất bại !");
		}
		return "admin/role";
	}
	
	@RequestMapping("edit/{id}")
	public String edit(ModelMap model,
			@ModelAttribute Role role,
			@PathVariable String id) {
		Session session = sessionFactory.getCurrentSession();
		role.setId(id);
		session.refresh(role);
		
		return "admin/role"; 
	}
	
	@RequestMapping("delete/{id}")
	public String delete(ModelMap model,
			@ModelAttribute Role role,
			@PathVariable String id) {
		
		Session session = sessionFactory.getCurrentSession();
		role.setId(id);
		session.delete(role);
		model.addAttribute("roles", getRoles());
		
		return "admin/role"; 
	}
}
