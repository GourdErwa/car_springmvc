package com.mvc.service;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

import com.tool.InitParameters;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

/**
 * 系统启动后初始化参数
 * Created by lw on 14-3-20.
 */
public class InitializationListener implements ServletContextListener, HttpSessionListener {

	@Override
    public void contextInitialized(ServletContextEvent servletContextEvent) {
        WebApplicationContext applicationContext = WebApplicationContextUtils.getWebApplicationContext(servletContextEvent.getServletContext());
        ServletContext application = servletContextEvent.getServletContext();
        application.setAttribute("projectName", InitParameters.projectName);
        application.setAttribute("COMPANYNAME", InitParameters.COMPANYNAME);
        application.setAttribute("PROJECTBYNAME", InitParameters.PROJECTBYNAME);
	}



	@Override
    public void sessionCreated(HttpSessionEvent httpSessionEvent) {
//        HttpSession session = httpSessionEvent.getSession();
//        ServletContext application = session.getServletContext();
//        application.setAttribute("projectName", InitParameters.projectName);
//        application.setAttribute("COMPANYNAME", InitParameters.COMPANYNAME);
//        application.setAttribute("PROJECTBYNAME", InitParameters.PROJECTBYNAME);
    }


	@Override
	public void contextDestroyed(ServletContextEvent sce) {
		// TODO Auto-generated method stub
		
	}


	@Override
	public void sessionDestroyed(HttpSessionEvent arg0) {
		// TODO Auto-generated method stub
		
	}
}

