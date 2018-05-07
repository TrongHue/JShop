package jshop.admin.controller;
import javax.servlet.ServletContext;
import org.hibernate.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import jshop.controller.JShopController;
import jshop.entity.Category;

@Controller
@RequestMapping("admin/category")
@Transactional
public class CategoryController extends JShopController{
	@Autowired
	ServletContext application;
		
	@RequestMapping("index")
	public String index(ModelMap model) {
		model.addAttribute("category", new Category());
		return "admin/category";
	}
	
	@RequestMapping("insert")
	public String insert(ModelMap model,
			@ModelAttribute Category category) {
		Session session = sessionFactory.getCurrentSession();
		session.save(category);
		
		//add vào model để update danh sách
		model.addAttribute("categories", getCategories());
		
		model.addAttribute("message", "Thêm mới thành công !");
		model.addAttribute("category", new Category()); // xóa form
		return "admin/category";
	}
	
	@RequestMapping("update")
	public String update(ModelMap model,
			@ModelAttribute Category category) {
		Session session = sessionFactory.getCurrentSession();
			session.update(category);
			model.addAttribute("categories", getCategories());
			model.addAttribute("message", "Cập nhật thành công !");
		return "admin/category";
	}
	
	@RequestMapping("edit/{id}")
	public String edit(ModelMap model,
			@ModelAttribute Category category,
			@PathVariable Integer id) {
		
		category.setId(id);
		Session session = sessionFactory.getCurrentSession();
		session.refresh(category);
		
		return "admin/category"; 
	}
	
	@RequestMapping("delete/{id}")
	public String delete(ModelMap model,
			@ModelAttribute Category category,
			@PathVariable Integer id) {
		
		Session session = sessionFactory.getCurrentSession();
		category.setId(id);
		session.delete(category);
		
		//add vào model để update danh sách
		model.addAttribute("categories", getCategories());
		
		return "admin/category"; 
	}
}
