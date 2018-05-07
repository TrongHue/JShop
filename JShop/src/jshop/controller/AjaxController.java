package jshop.controller;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;

import jshop.entity.Category;
import jshop.utils.Json;

@Controller
@Transactional
@RequestMapping("ajax")
public class AjaxController extends JShopController{
	
	@RequestMapping("index")
	public String index(HttpServletResponse response) {
		return "ajax-index";
	}
	
	@RequestMapping("server-time")
	public void getTime(HttpServletResponse response) {
		Date now = new Date();
		SimpleDateFormat f = new SimpleDateFormat();
		f.applyPattern("HH:mm:ss");
		String time = f.format(now);
		
		Json.writeObject(response, time);
	}
	
	@RequestMapping("array")
	public void getArray(HttpServletResponse response) {
		String[] a = {"A", "Nghiệm", "X"};
		
		Json.writeObject(response, a);
	}
	
	@RequestMapping("object")
	public void getObject(HttpServletResponse response) {
		Category c = new Category();
		c.setId(1000);
		c.setName("Fashion");
		c.setNameVN("Th�?i trang");
		
		Json.writeObject(response, c);
	}
	
	@RequestMapping("list")
	public void getList(HttpServletResponse response) {
		List<Integer> list = new ArrayList<Integer>();
		list.add(1000);
		list.add(5000);
		list.add(2000);
		
		Json.writeObject(response, list);
	}
	
	
	
	@RequestMapping("map")
	public void getMap(HttpServletResponse response) {
//		Map<String, Object> map = new HashMap<String, Object>();
//		map.put("name", "Nguyễn Văn Tèo");
//		map.put("marks", 50.0);
//		map.put("age", 22);
//		
//		Json.writeObject(response, map);
		
		Json.writePairs(response, 
				"name", "Nguyễn Văn Tèo", 
				"marks", 50.0, 
				"age", 22);
	}
	
	@RequestMapping("list-object")
	public void getListObject(HttpServletResponse response) {
		List<Category> list = getCategories();
		for(Category c: list){
			c.setProducts(null);
		}
		
		Json.writeObject(response, list);
	}
}
