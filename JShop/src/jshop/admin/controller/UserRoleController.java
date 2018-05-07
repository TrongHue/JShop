package jshop.admin.controller;

import java.util.List;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import jshop.controller.JShopController;
import jshop.security.entity.Role;
import jshop.security.entity.UserRole;
import jshop.utils.Json;

@Controller
@RequestMapping("admin/user-role")
@Transactional
public class UserRoleController extends JShopController{
	@Autowired
	ServletContext application;
		
	@ModelAttribute("userRoles")
	public List<UserRole> getUserRoles(@RequestParam(defaultValue="1") String roleId) {
		Session session = sessionFactory.getCurrentSession();
		String hql = "FROM UserRole WHERE role.id=:roleId";
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
		return "admin/user-role";
	}
	
	@RequestMapping("update")
	@ResponseBody
	public void ajax_update(
			@RequestParam Integer id, 
			HttpServletResponse response) {
		Session session = sessionFactory.getCurrentSession();
		UserRole ur = (UserRole) session.get(UserRole.class, id);
		ur.setAllow(!ur.getAllow());
		session.update(ur);
	}
}
