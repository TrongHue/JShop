package jshop.admin.controller;

import java.util.List;

import javax.servlet.http.HttpServletResponse;

import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;

import jshop.controller.JShopController;
import jshop.security.entity.Permission;
import jshop.security.entity.Role;
import jshop.utils.Json;

@Controller
@RequestMapping("admin/permission")
@Transactional
public class PermissionController extends JShopController{

	@ModelAttribute("permissions")
	public List<Permission> getPermissions(@RequestParam(defaultValue="1") String roleId) {
		Session session = sessionFactory.getCurrentSession();
		
		String hql = "FROM Permission WHERE role.id=:roleId";
		Query query = session.createQuery(hql);
		query.setParameter("roleId", roleId);
		return query.list();
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
		return "admin/permission";
	}
	
	@RequestMapping("update")
	public void ajax_update(@RequestParam Integer id, 
			@RequestParam Boolean allow,
			HttpServletResponse response) {
		try {
			Session session = sessionFactory.getCurrentSession();
			Permission p = (Permission) session.get(Permission.class, id);
			p.setAllow(allow);
			session.update(p);
			Json.writeObject(response, "Succeeded");
		} 
		catch (Exception e) {
			Json.writeObject(response, "Fails");
		}
	}
}
