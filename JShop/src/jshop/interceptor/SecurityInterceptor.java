package jshop.interceptor;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.servlet.handler.HandlerInterceptorAdapter;

import jshop.security.entity.Permission;
import jshop.security.entity.User;

public class SecurityInterceptor extends HandlerInterceptorAdapter{
	@Autowired
	SessionFactory sessionFactory;
	
	@Override
	public boolean preHandle(HttpServletRequest request,
			HttpServletResponse response, Object handler) throws Exception {
		/*
		 * Authentication: kiểm tra đăng nhập
		 */
		User user = (User) request.getSession().getAttribute("master");
		if(user == null){
			response.sendRedirect("/EShopV20/admin/login.htm?authenticate");
			return false;
		}
		//System.out.println(" User Name: " + user.getId());
		
		/*
		 * Tách lấy actionName từ URL
		 */
		String uri = request.getRequestURI();
		int start = uri.indexOf("/admin/") + 7;
		int end = uri.lastIndexOf(".htm");
		String actionName = uri.substring(start, end);
		if(actionName.lastIndexOf("/") != actionName.indexOf("/")){
			actionName = actionName.substring(0, actionName.lastIndexOf("/"));
		}
		//System.out.println(" Action: " + actionName);
		
		/*
		 * Truy vấn Permission của actionName và các vai trò của ngư�?i đăng nhập
		 */
		Session session = sessionFactory.openSession();
		String roleIds = "SELECT ur.role.id "
				+ " FROM UserRole ur "
				+ " WHERE ur.allow=true AND ur.user.id=:userId";
		String hql = "FROM Permission p"
				+ " WHERE p.action.name=:actionName AND p.role.id IN ("+roleIds+")";
		Query query = session.createQuery(hql);
		query.setParameter("actionName", actionName);
		query.setParameter("userId", user.getId());
		List<Permission> list = query.list();
		
		if(list.isEmpty()){
			session.close();
			return true;
		}
		for(Permission p : list){
			if(p.getAllow() == Boolean.TRUE){
				session.close();
				return true;
			}
		}
		session.close();
		
		response.sendRedirect("/EShopV20/admin/login.htm?authorize");
		return false;
	}
}
