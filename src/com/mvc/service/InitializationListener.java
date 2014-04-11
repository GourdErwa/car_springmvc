package com.mvc.service;

import com.tool.InitParameters;
import org.springframework.web.context.WebApplicationContext;
import org.springframework.web.context.support.WebApplicationContextUtils;

import javax.servlet.ServletContext;
import javax.servlet.ServletContextEvent;
import javax.servlet.ServletContextListener;
import javax.servlet.http.HttpSession;
import javax.servlet.http.HttpSessionEvent;
import javax.servlet.http.HttpSessionListener;

/**
 * 系统启动后初始化参数
 * Created by lw on 14-3-20.
 */
public class InitializationListener implements ServletContextListener, HttpSessionListener {

    @Override
    public void contextInitialized(ServletContextEvent servletContextEvent) {
        WebApplicationContext applicationContext = WebApplicationContextUtils.getWebApplicationContext(servletContextEvent.getServletContext());
    }


    @Override
    public void contextDestroyed(ServletContextEvent servletContextEvent) {

    }

    @Override
    public void sessionCreated(HttpSessionEvent httpSessionEvent) {
        HttpSession session = httpSessionEvent.getSession();
        ServletContext application = session.getServletContext();
        application.setAttribute("projectName", InitParameters.PROJECTNAME);
        application.setAttribute("COMPANYNAME", InitParameters.COMPANYNAME);
        application.setAttribute("PROJECTBYNAME", InitParameters.PROJECTBYNAME);
    }

    @Override
    public void sessionDestroyed(HttpSessionEvent httpSessionEvent) {

    }


}

