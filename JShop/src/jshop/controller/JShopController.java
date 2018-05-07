package jshop.controller;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.persistence.criteria.CriteriaBuilder.In;
import javax.servlet.ServletContext;

import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.ModelAttribute;

import jshop.entity.Category;
import jshop.entity.Supplier;
import jshop.utils.LikeProduct;
import jshop.utils.ShoppingCart;

@Controller
@Transactional
public class JShopController {
	@Autowired
	protected SessionFactory sessionFactory;
	
	
	
	@ModelAttribute("categories")
	public List<Category> getCategories() {
		String hql = "FROM Category";
		
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery(hql);
		return query.list();
	}
	
	@ModelAttribute("suppliers")
	public List<Supplier> getSuppliers() {
		String hql = "FROM Supplier";
		
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery(hql);
		return query.list();
	}
	
	@Autowired
	protected ShoppingCart cart;
	
	@ModelAttribute("cart")
	public ShoppingCart getShoppingCart() {
		return cart;
	}
	
	@Autowired
	protected LikeProduct like;
	
	@ModelAttribute("like")
	public LikeProduct likeProduct() {
		return like;
	}
}
