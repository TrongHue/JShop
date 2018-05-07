package jshop.admin.controller;

import java.io.File;

import javax.servlet.ServletContext;

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
import jshop.entity.Supplier;

@Controller
@RequestMapping("admin/supplier")
@Transactional
public class SupplierController extends JShopController{
	@Autowired
	ServletContext application;
		
	@RequestMapping("index")
	public String index(ModelMap model) {
		model.addAttribute("supplier", new Supplier());
		return "admin/supplier";
	}
	
	@RequestMapping("insert")
	public String insert(ModelMap model,
			@ModelAttribute Supplier supplier,
			@RequestParam("file_logo") MultipartFile logo) {
		Session session = sessionFactory.getCurrentSession();
		try {
			if(!logo.isEmpty()){
				String fileName = logo.getOriginalFilename();
				String path = application.getRealPath("images/suppliers/"+ fileName);
				logo.transferTo(new File(path));
				supplier.setLogo(fileName);
			}
			session.save(supplier);
			
			model.addAttribute("suppliers", getSuppliers());
			
			model.addAttribute("message", "Thêm mới thành công !");
			model.addAttribute("supplier", new Supplier()); // xóa form
		} 
		catch (Exception e) {
			model.addAttribute("message", "Thêm mới thất bại !");
		}
		return "admin/supplier";
	}
	
	@RequestMapping("update")
	public String update(ModelMap model,
			@ModelAttribute Supplier supplier,
			@RequestParam("file_logo") MultipartFile logo) {
		Session session = sessionFactory.getCurrentSession();
		try {
			if(!logo.isEmpty()){
				String fileName = logo.getOriginalFilename();
				String path = application.getRealPath("images/suppliers/"+ fileName);
				logo.transferTo(new File(path));
				supplier.setLogo(fileName);
			}
			session.update(supplier);
			
			model.addAttribute("suppliers", getSuppliers());
			
			model.addAttribute("message", "Cập nhật thành công !");
		} 
		catch (Exception e) {
			model.addAttribute("message", "Cập nhật thất bại !");
		}
		return "admin/supplier";
	}
	
	@RequestMapping("edit/{id}")
	public String edit(ModelMap model,
			@ModelAttribute Supplier supplier,
			@PathVariable String id) {
		
		supplier.setId(id);
		Session session = sessionFactory.getCurrentSession();
		session.refresh(supplier);
		
		return "admin/supplier"; 
	}
	
	@RequestMapping("delete/{id}")
	public String delete(ModelMap model,
			@ModelAttribute Supplier supplier,
			@PathVariable String id) {
		
		Session session = sessionFactory.getCurrentSession();
		supplier.setId(id);
		session.delete(supplier);
		
		model.addAttribute("suppliers", getSuppliers());
		
		return "admin/supplier"; 
	}
}
