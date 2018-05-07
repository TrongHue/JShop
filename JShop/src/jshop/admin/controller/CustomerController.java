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
import jshop.entity.Customer;


@Controller
@RequestMapping("admin/customer")
@Transactional
public class CustomerController extends JShopController{
	@Autowired
	ServletContext application;
	
	@ModelAttribute("customers")
	public List<Customer> getCustomers() {
		String hql = "FROM Customer";
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery(hql);
		return query.list();
	}
		
	@RequestMapping("index")
	public String index(ModelMap model) {
		model.addAttribute("customer", new Customer());
		return "admin/customer";
	}
	
	@RequestMapping("insert")
	public String insert(ModelMap model, @ModelAttribute Customer customer, @RequestParam("file_image") MultipartFile photo) {
		Session session = sessionFactory.getCurrentSession();
		
		//Check if User id exists in DB (ko dùng load() )
		String hql = "FROM Customer WHERE id = :id";
		Query query = session.createQuery(hql);
		query.setString("id", customer.getId());
		Customer checkCustomer = (Customer) query.uniqueResult();
		if(checkCustomer != null){
			model.addAttribute("message", "Id bị trùng!");
		}else{
			try {
				if(!photo.isEmpty()){
					String fileName = photo.getOriginalFilename();
					String path = application.getRealPath("images/customers/"+ fileName);
					photo.transferTo(new File(path));
					customer.setPhoto(fileName);
				}
				session.save(customer);
				model.addAttribute("customers", getCustomers());
				model.addAttribute("message", "Thêm mới thành công !");
				model.addAttribute("customer", new Customer()); // xóa form
			} 
			catch (Exception e) {
					model.addAttribute("message", "Thêm mới thất bại !");
			}
		}
		return "admin/customer";
	}

	@RequestMapping("update")
	public String update(ModelMap model, @ModelAttribute Customer customer, @RequestParam("file_image") MultipartFile photo) {
		Session session = sessionFactory.getCurrentSession();			
		try {
			if(!photo.isEmpty()){
				String fileName = photo.getOriginalFilename();
				String path = application.getRealPath("images/customers/"+ fileName);
				photo.transferTo(new File(path));
				customer.setPhoto(fileName);
			}
			session.update(customer);
			model.addAttribute("customers", getCustomers());
			model.addAttribute("message", "Cập nhật thành công !");
		} 
		catch (Exception e) {
			model.addAttribute("message", "Cập nhật thất bại !");
		}
		return "admin/customer";
	}
	
	@RequestMapping("edit/{id}")
	public String edit(ModelMap model,
			@ModelAttribute Customer customer,
			@PathVariable String id) {
		Session session = sessionFactory.getCurrentSession();
		customer.setId(id);
		session.refresh(customer);

		return "admin/customer"; 
	}
	
	@RequestMapping("delete/{id}")
	public String delete(ModelMap model,
			@ModelAttribute Customer customer,
			@PathVariable String id) {
		
		Session session = sessionFactory.getCurrentSession();
		customer.setId(id);
		try {
			session.delete(customer);
			model.addAttribute("message", "Xóa thành công !");
			model.addAttribute("customers", getCustomers());
		} catch (Exception e) {
			model.addAttribute("message", "User không tồn tại!");
			e.printStackTrace();
		}		
		return "admin/customer"; 
	}
}
