package jshop.controller;

import java.util.List;

import javax.mail.internet.MimeMessage;
import javax.servlet.http.HttpSession;

import org.hibernate.Query;
import org.hibernate.Session;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.fasterxml.jackson.core.JsonProcessingException;

import jshop.entity.Category;
import jshop.entity.Product;

@Controller
@Transactional
@RequestMapping("home")
public class HomeController extends JShopController{
	
	@Autowired
	JavaMailSender mailSender;
	
	@RequestMapping("set-language")
	@ResponseBody
	public void setLanguage(HttpSession session, 
			@RequestParam String language) throws JsonProcessingException {
		session.setAttribute("language", language);
	}
	
	@RequestMapping("index")
	public String index() {
		return "home";
	}
	
	@RequestMapping("about")
	public String about() {
		return "about";
	}
	
	@RequestMapping("contact")
	public String contact() {
		return "contact";
	}
	
	@RequestMapping("feedback")
	public String showFeedback() {
		return "feedback";
	}
	
	@RequestMapping(value="feedback",method=RequestMethod.POST)
	public String feedback(ModelMap model,
			@RequestParam("name") String name,
			@RequestParam("email") String email,
			@RequestParam("comboCat") String comboCat,
			@RequestParam("info") String info) {
		
		String category = "";
		if(comboCat.equals("web")){
			category = "Website";
		} else if (comboCat.equals("service")) {
			category = "Chất lượng sản phẩm - dịch vụ";
		} else {
			category = "Thái độ phục vụ của nhân viên";
		}
		
		try{
			MimeMessage message = mailSender.createMimeMessage();
			MimeMessageHelper helper = new MimeMessageHelper(message, true);
			helper.setFrom(email);
			helper.setTo("projectjava26012015@gmail.com");
			// Email project: projectjava26012015@gmail.com Password: projectadmin
			helper.setReplyTo("Web Master <projectjava26012015@gmail.com>");
			helper.setSubject("[Feedback] Thư đóng góp ý kiến của khách hàng: "+ name);
			helper.setText("+ Email phản hồi: "+ email+" <br>+ Chủ đ�? góp ý: " + category + " <br>+ Nội dung: "+ info, true);
			
			mailSender.send(message);
			model.addAttribute("message", "Gửi phản hồi thành công. Cảm ơn bạn đã đóng góp ý kiến cho EShop.");
		}
		catch(Exception ex){
			model.addAttribute("message", "Có lỗi xảy ra trong quá trình gửi thư phản hồi");
		}
		return "feedback";
	}
	
	@RequestMapping("faqs")
	public String faqs() {
		return "faqs";
	}
	
	@ModelAttribute("saleoffProducts")
	public List<Product> get6saleoffProducts() {
		String hql = "FROM Product p WHERE p.discount > 0 ORDER BY p.discount DESC";
		
		Session session = sessionFactory.getCurrentSession();
		Query query = session.createQuery(hql);
		query.setMaxResults(6);
		return query.list();
	}
	
}
