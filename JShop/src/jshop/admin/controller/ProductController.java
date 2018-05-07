package jshop.admin.controller;

import java.io.File;
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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import jshop.controller.JShopController;
import jshop.entity.Product;
import jshop.entity.Supplier;

@Controller("adminProductController")
@RequestMapping("admin/product")
@Transactional
public class ProductController extends JShopController{
	@Autowired
	ServletContext application;
	
	@ModelAttribute("products")
	public List<Product> getProducts() {
		String hql = "FROM Product";
		
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery(hql);
		return query.list();
	}
		
	@RequestMapping("index")
	public String index(ModelMap model) {
		model.addAttribute("productAd", new Product());
		return "admin/product";
	}
	
	@RequestMapping("insert")
	public String insert(ModelMap model,
			@ModelAttribute("productAd") Product product,
			@RequestParam("file_image") MultipartFile image) {
		Session session = sessionFactory.getCurrentSession();
		try {
			if(!image.isEmpty()){
				String fileName = image.getOriginalFilename();
				String path = application.getRealPath("images/products/"+ fileName);
				image.transferTo(new File(path));
				product.setImage(fileName);
			}
			session.save(product);
			
			model.addAttribute("products", getProducts());
			
			model.addAttribute("message", "Thêm mới thành công !");
			model.addAttribute("productAd", new Product()); // xóa form
		} 
		catch (Exception e) {
			model.addAttribute("message", "Thêm mới thất bại !");
		}
		return "admin/product";
	}
	
	@RequestMapping("update")
	public String update(ModelMap model,
			@ModelAttribute("productAd") Product product,
			@RequestParam("file_image") MultipartFile image) {
		Session session = sessionFactory.getCurrentSession();
		try {
			if(!image.isEmpty()){
				String fileName = image.getOriginalFilename();
				String path = application.getRealPath("images/products/"+ fileName);
				image.transferTo(new File(path));
				product.setImage(fileName);
			}
			session.update(product);
			
			model.addAttribute("products", getProducts());
			
			model.addAttribute("message", "Cập nhật thành công !");
		} 
		catch (Exception e) {
			model.addAttribute("message", "Cập nhật thất bại !");
		}
		return "admin/product";
	}
	
	@RequestMapping("edit/{id}")
	public String edit(ModelMap model,
			@ModelAttribute("productAd") Product product,
			@PathVariable Integer id) {
		
		product.setId(id);
		Session session = sessionFactory.getCurrentSession();
		session.refresh(product);
		
		return "admin/product"; 
	}
	
	@RequestMapping("delete/{id}")
	public String delete(ModelMap model,
			@ModelAttribute("productAd") Product product,
			@PathVariable Integer id) {
		
		Session session = sessionFactory.getCurrentSession();
		product.setId(id);
		session.delete(product);
		
		model.addAttribute("products", getProducts());
		
		return "admin/product"; 
	}
}
