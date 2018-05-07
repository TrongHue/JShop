package jshop.utils;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileWriter;
import java.io.IOException;
import java.util.Collection;
import java.util.HashMap;
import java.util.Map;
import java.util.Scanner;
import java.util.Set;

import javax.servlet.ServletContext;

import org.apache.velocity.runtime.directive.Parse;
import org.hibernate.SessionFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.Scope;
import org.springframework.context.annotation.ScopedProxyMode;
import org.springframework.stereotype.Component;

import jshop.entity.Product;

@Component("likeProduct")
@Scope(proxyMode=ScopedProxyMode.TARGET_CLASS, value="application")
public class LikeProduct{
	@Autowired
	SessionFactory sessionFactory;
	
	@Autowired
	ServletContext application;
	
	Map<Integer, Integer> map = new HashMap<Integer, Integer>();
	
	public void add(Integer id) {
		try {
			String path = application.getRealPath("like.txt");
			Scanner scanner = new Scanner(path);
			String values = scanner.nextLine();
			System.out.println(values);
			/*String[] tokens = values.split(" |=");
			for (int i=0; i<tokens.length-1; ) map.put(Integer.parseInt(tokens[i++]), Integer.parseInt(tokens[i++]));*/
			values = values.substring(1,values.length()-1);
			String[] keyValuePairs = values.split(",");
			for(String pair:keyValuePairs){
				String[] entry = pair.split("=");
				map.put(Integer.parseInt(entry[0].trim()), Integer.parseInt(entry[1].trim()));
			}
			
			scanner.close();
		} catch (Exception e1) {
			e1.printStackTrace();
		}
		
		Integer item = map.get(id);
		if(item == null){
			map.put(id, 1);
		}
		else{
			map.put(id, map.get(id)+1);
		}
		System.out.println(map);
	}
	
	public Map<Integer, Integer> getAll() {
		
		return map;
	}
	
	public Set<Integer> getKey() {
		System.out.println("aaaaaaaaaaa");
		System.out.println(map.keySet());
		return map.keySet();
	}
}
