package jshop.controller;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.transaction.Transactional;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;
import com.fasterxml.jackson.databind.ObjectMapper;

import jshop.entity.Product;
import jshop.utils.Json;

@Controller
@Transactional
@RequestMapping("shopping-cart")
public class ShoppingCartController extends JShopController{
	
	@RequestMapping("index")
	public String index() {
		return "shopping-cart";
	}
	
	@RequestMapping("add/{id}")
	public String addToCart(ModelMap model, @PathVariable Integer id) {
		cart.add(id);
		return "shopping-cart";
	}
	
	@RequestMapping("add-ajax/{id}")
	@ResponseBody
	public String addToCartByAjax(HttpServletResponse response, 
			@PathVariable Integer id) throws JsonProcessingException {
		cart.add(id);
		
		Map map = new HashMap();
		map.put("count", cart.getCount());
		map.put("amount", String.format("%.3f", cart.getAmount()));
		
		ObjectMapper om = new ObjectMapper();
		return om.writeValueAsString(map);
		
//		Json.writePairs(response, 
//				"count", cart.getCount(), 
//				"amount", String.format("%.3f", cart.getAmount()));
	}
	
	@RequestMapping("remove/{id}")
	public String removeFromCart(ModelMap model, @PathVariable Integer id) {
		cart.remove(id);
		return "shopping-cart";
	}
	
	@RequestMapping("remove-ajax/{id}")
	public void removeFromCartAjax(HttpServletResponse response, @PathVariable Integer id) {
		cart.remove(id);
		Json.writePairs(response, 
				"count", cart.getCount(), 
				"amount", String.format("%.3f", cart.getAmount()));
	}
	
	@RequestMapping("clear")
	public String clearCart(ModelMap model) {
		cart.clear();
		return "shopping-cart";
	}
	
	@RequestMapping("update")
	public String updateCart(ModelMap model, 
			HttpServletRequest request) {
		for(Product p : cart.getItems()){
			String id = p.getId().toString();
			int newQuantity = Integer.parseInt(request.getParameter(id));
			p.setQuantity(newQuantity);
		}
		return "shopping-cart";
	}
}
