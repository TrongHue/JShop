package jshop.controller;

import java.io.File;
import java.io.FileWriter;
import java.io.UnsupportedEncodingException;
import java.net.URL;
import java.net.URLEncoder;
import java.util.Collection;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Scanner;
import java.util.Set;

import javax.mail.internet.MimeMessage;
import javax.persistence.criteria.CriteriaBuilder.In;
import javax.servlet.ServletContext;
import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.validator.constraints.Length;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.CookieValue;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;







import org.springframework.web.bind.annotation.ResponseBody;

import jshop.entity.Category;
import jshop.entity.Product;
import jshop.utils.PagerModel;

@Controller
@Transactional
@RequestMapping("product")
public class ProductController extends JShopController{
	@Autowired
	ServletContext application;
	
	@Autowired
	JavaMailSender mailSender;
	
	@RequestMapping("like")
	public void likeProduct(ModelMap model,
			@RequestParam Integer id){
		like.add(id);
		Map<Integer, Integer> map = new HashMap<Integer, Integer>();
		map = like.getAll();
		try {
			String path = application.getRealPath("like.txt");
			FileWriter writer = new FileWriter(path);
			writer.write(map.toString());
			writer.close();	
			System.out.println(path);
		} catch (Exception e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		
	}
	
	@RequestMapping("search-product")
	public String searchProduct(ModelMap model,
			HttpServletRequest request,
			@RequestParam("") String search) {
		Session session = sessionFactory.getCurrentSession();
		
		String hqlCount = "SELECT COUNT(p) FROM Product p WHERE name LIKE '%"+search+"%'";
		Long rowCount = (Long) session.createQuery(hqlCount).uniqueResult();
		System.out.println(rowCount);
		PagerModel pager = new PagerModel();
		pager = PagerModel.getPager("acpager", 12, rowCount.intValue(),request);
		pager.setRowCount(rowCount.intValue());
		pager.setPageSize(9);
		pager.navigate(request);
		model.addAttribute("search", search);
		model.addAttribute("flat", "search-product");
		
		String hql = "FROM Product WHERE name LIKE '%"+search+"%'";
		Query query = session.createQuery(hql);
		query.setFirstResult(pager.getStartRow());
		query.setMaxResults(pager.getPageSize());
		List<Product> list = query.list();
		model.addAttribute("list", list);
		
		return "product-list";
	}
	
	@RequestMapping("list")
	public String list(ModelMap model, HttpServletRequest request) {
		Session session = sessionFactory.getCurrentSession();
		
		String hqlCount = "SELECT COUNT(p) FROM Product p";
		Long rowCount = (Long) session.createQuery(hqlCount).uniqueResult();
		PagerModel pager = new PagerModel();
		pager = PagerModel.getPager("acpager", 12, rowCount.intValue(),request);
		pager.setRowCount(rowCount.intValue());
		pager.navigate(request);

		String hql = "FROM Product p ORDER BY p.views DESC";
		
		Query query = session.createQuery(hql);
		query.setFirstResult(pager.getStartRow());
		query.setMaxResults(pager.getPageSize());
		
		List<Product> list = query.list();
		model.addAttribute("list", list);
		model.addAttribute("flat", "list");
		return "product-list";
	}
	
	@RequestMapping("list-by-category/{id}")
	public String list(ModelMap model, @PathVariable("id") Integer id, HttpServletRequest request) {
		Session session = sessionFactory.getCurrentSession();
		String hqlCount = "SELECT COUNT(p) FROM Product p WHERE p.category.id=:cid1";
		Long rowCount = (Long) session.createQuery(hqlCount).setParameter("cid1", id).uniqueResult();
		PagerModel pager = new PagerModel();
		pager = PagerModel.getPager("acpager", 12, rowCount.intValue(),request);
		pager.setRowCount(rowCount.intValue());
		pager.navigate(request);
		
		String hql = "FROM Product p WHERE p.category.id=:cid";
		
		Query query = session.createQuery(hql);
		query.setFirstResult(pager.getStartRow());
		query.setMaxResults(pager.getPageSize());
		query.setParameter("cid", id);
		
		List<Product> list = query.list();
		model.addAttribute("list", list);
		model.addAttribute("flat", "list-by-category/"+id);
		return "product-list";
	}
	
	@RequestMapping("list-by-supplier/{id}")
	public String list(ModelMap model, @PathVariable("id") String id, HttpServletRequest request) {
		Session session = sessionFactory.getCurrentSession();
		
		String hqlCount = "SELECT COUNT(p) FROM Product p WHERE p.supplier.id=:sid1";
		Long rowCount = (Long) session.createQuery(hqlCount).setParameter("sid1", id).uniqueResult();
		PagerModel pager = new PagerModel();
		pager = PagerModel.getPager("acpager", 12, rowCount.intValue(),request);
		pager.setRowCount(rowCount.intValue());
		pager.navigate(request);
		
		String hql = "FROM Product p WHERE p.supplier.id=:sid";
		
		Query query = session.createQuery(hql);
		query.setParameter("sid", id);
		query.setFirstResult(pager.getStartRow());
		query.setMaxResults(pager.getPageSize());
		
		List<Product> list = query.list();
		model.addAttribute("list", list);
		model.addAttribute("flat", "list-by-supplier/"+id);
		return "product-list";
	}
	
	@RequestMapping("sendToFriend")
	public String sendToFriend(ModelMap model,
			HttpServletRequest request,
			@RequestParam String id,
			@RequestParam String from,
			@RequestParam String to,
			@RequestParam String subject,
			@RequestParam String body) throws UnsupportedEncodingException, Exception {
		String url = request.getRequestURL().toString().replace("sendToFriend", "detail/"+id);
		System.out.println(url);
		try {
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper helper = new MimeMessageHelper(message, true);
			helper.setFrom(from);
			helper.setTo(to);
			helper.setSubject(subject);
			String text = body+"<br/>Click to show <a href='"+url+"'>product detail!</a>";
			helper.setText(text,true);
			
			mailSender.send(message);
			model.addAttribute("message", "sucees");
		} catch (Exception e) {
			model.addAttribute("message", "error");
		}
		return "redirect:/product/detail/"+id+".htm#Tab2";
	}
	
	@RequestMapping("special/{value}")
	public String listSpecial(ModelMap model, 
			@PathVariable("value") String value,
			HttpServletRequest request) {
		Session session = sessionFactory.getCurrentSession();
		Long rowCount = (long) 0;
		Query query = null;
		if(value.equalsIgnoreCase("best")){
			String hqlCount = "SELECT COUNT(p) FROM Product p WHERE SIZE(p.orderDetails) > 40";
			rowCount = (Long) session.createQuery(hqlCount).uniqueResult();
			System.out.println(rowCount);
			PagerModel pager = new PagerModel();
			pager = PagerModel.getPager("acpager", 12, rowCount.intValue(),request);
			pager.setRowCount(rowCount.intValue());
			pager.navigate(request);
			
			String hql = "FROM Product p "
					+ " WHERE SIZE(p.orderDetails) > 40 "
					+ " ORDER BY SIZE(p.orderDetails) DESC";
			
			query = session.createQuery(hql);
			query.setFirstResult(pager.getStartRow());
			query.setMaxResults(pager.getPageSize());
			model.addAttribute("flat", "special/best");
		}
		else if(value.equalsIgnoreCase("favorite")){
			Map<Integer, Integer> map = new HashMap<Integer, Integer>();
			String path = application.getRealPath("like.txt");
			try {
				Scanner scanner = new Scanner(new File(path));
				String values = scanner.nextLine();
				values = values.substring(1,values.length()-1);
				System.out.println("values:"+values);
				String[] keyValuePairs = values.split(",");
				for(String pair:keyValuePairs){
					String[] entry = pair.split("=");
					map.put(Integer.parseInt(entry[0].trim()), Integer.parseInt(entry[1].trim()));
					rowCount++;
				}
			} catch (Exception e) {
				e.printStackTrace();
			}
			
			Set<Integer> key = map.keySet();
			String listId = key.toString();
			listId = listId.substring(1, listId.length()-1);
			
			PagerModel pager = new PagerModel();
			pager = PagerModel.getPager("acpager", 12, rowCount.intValue(),request);
			pager.setRowCount(rowCount.intValue());
			pager.navigate(request);
			
			String hql = "FROM Product p WHERE p.id IN("+listId+")";
			query = session.createQuery(hql);
			query.setFirstResult(pager.getStartRow());
			query.setMaxResults(pager.getPageSize());
			model.addAttribute("flat", "special/favorite");
		}
		else if(value.equalsIgnoreCase("latest")){
			String hqlCount = "SELECT COUNT(p) FROM Product p WHERE p.latest=true";
			rowCount = (Long) session.createQuery(hqlCount).uniqueResult();
			if(rowCount>24){
				rowCount = (long) 24;
			}
			PagerModel pager = new PagerModel();
			pager = PagerModel.getPager("acpager", 12, rowCount.intValue(),request);
			pager.setRowCount(rowCount.intValue());
			pager.navigate(request);
			
			String hql = "FROM Product p WHERE p.latest=true";
			query = session.createQuery(hql);
			query.setFirstResult(pager.getStartRow());
			query.setMaxResults(pager.getPageSize());
			model.addAttribute("flat", "special/latest");
		}
		else if(value.equalsIgnoreCase("views")){
			String hqlCount = "SELECT COUNT(p) FROM Product p WHERE p.views > 0";
			rowCount = (Long) session.createQuery(hqlCount).uniqueResult();
			if(rowCount>24){
				rowCount = (long) 24;
			}
			PagerModel pager = new PagerModel();
			pager = PagerModel.getPager("acpager", 12, rowCount.intValue(),request);
			pager.setRowCount(rowCount.intValue());
			pager.navigate(request);
			String hql = "FROM Product p WHERE p.views > 0 ORDER BY p.views DESC";
			query = session.createQuery(hql);
			query.setFirstResult(pager.getStartRow());
			query.setMaxResults(pager.getPageSize());
			model.addAttribute("flat", "special/views");
		}
		else if(value.equalsIgnoreCase("salesoff")){
			String hqlCount = "SELECT COUNT(p) FROM Product p WHERE p.discount > 0";
			rowCount = (Long) session.createQuery(hqlCount).uniqueResult();
			if(rowCount>24){
				rowCount = (long) 24;
			}
			PagerModel pager = new PagerModel();
			pager = PagerModel.getPager("acpager", 12, rowCount.intValue(),request);
			pager.setRowCount(rowCount.intValue());
			pager.navigate(request);
			
			String hql = "FROM Product p WHERE p.discount > 0 ORDER BY p.discount DESC";
			query = session.createQuery(hql);
			query.setFirstResult(pager.getStartRow());
			query.setMaxResults(pager.getPageSize());
			model.addAttribute("flat", "special/salesoff");
		}
		else if(value.equalsIgnoreCase("special")){
			String hqlCount = "SELECT COUNT(p) FROM Product p WHERE p.special=true";
			rowCount = (Long) session.createQuery(hqlCount).uniqueResult();
			if(rowCount>24){
				rowCount = (long) 24;
			}
			PagerModel pager = new PagerModel();
			pager = PagerModel.getPager("acpager", 12, rowCount.intValue(),request);
			pager.setRowCount(rowCount.intValue());
			pager.navigate(request);
			
			String hql = "FROM Product p WHERE p.special=true";
			query = session.createQuery(hql);
			query.setFirstResult(pager.getStartRow());
			query.setMaxResults(pager.getPageSize());
			model.addAttribute("flat", "special/special");
		}
		List<Product> list = query.list();
		model.addAttribute("list", list);
		
		return "product-list";
	}
	
	@RequestMapping("detail/{id}")
	public String detail(ModelMap model, HttpServletResponse response,
			@PathVariable("id") Integer id,
			@ModelAttribute("product") Product product,
			@CookieValue(value="views", defaultValue="") String views) {
		product.setId(id);
		Session session = sessionFactory.getCurrentSession();
		session.refresh(product);
		
		// Tăng số lần xem
		product.setViews(product.getViews()+1);
		session.update(product);
		
		// Ghi nhan mat hang da xem vao cookie
		if(!views.contains(id.toString())){
			views += "," + id;
		}
		String hql = "FROM Product " +
				" WHERE id IN(2015" + views + ")";
		Query query = session.createQuery(hql);
		model.addAttribute("views", query.list());
		
		Cookie cookie = new Cookie("views", views);
		cookie.setMaxAge(60*60*24*30);
		response.addCookie(cookie);
		
		return "product-detail";
	}
	
}
