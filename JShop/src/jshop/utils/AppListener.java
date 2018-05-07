package jshop.utils;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileWriter;
import java.io.IOException;
import java.util.Scanner;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.annotation.WebListener;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

@WebListener
public class AppListener implements HttpSessionListener, ServletContextListener {

	@Override
	public void sessionCreated(HttpSessionEvent e) {
			
	}

	@Override
	public void sessionDestroyed(HttpSessionEvent arg0) {
		// TODO Auto-generated method stub
	}

	@Override
	public void contextDestroyed(ServletContextEvent e) {
	}

	@Override
	public void contextInitialized(ServletContextEvent e) {
		ServletContext app = e.getServletContext();
		String path = app.getRealPath("like.txt");
		File file = new File(path);
		FileWriter writer;
		try {
			writer = new FileWriter(path);
			writer.write(new String("{1012=1}"));
			writer.close();	
		} catch (IOException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}

	}

}
