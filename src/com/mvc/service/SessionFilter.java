package com.mvc.service;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.tool.StringTool;

/**
 * @author lw
 *         session 过滤器,对于可以进入后台的请求，全部过滤。后台请求类型为 /*.admin.do
 */
public class SessionFilter implements Filter {

    // 增加在用户没有登录下放行的url请求
    private String[] NOT_FILTER = {"login.admin.do", "welcome.admin.do", "loginout.admin.do"};

    @Override
    public void destroy() {
        // TODO Auto-generated method stub

    }
    @Override
    public void doFilter(ServletRequest req, ServletResponse res,
                         FilterChain chain) throws IOException, ServletException {
        // TODO Auto-generated method stub
        HttpServletRequest request = (HttpServletRequest) req;
        HttpServletResponse response = (HttpServletResponse) res;
        String url = request.getRequestURI();
        boolean b = false;
        if (url.indexOf(".admin.do") != -1) {

            request.setCharacterEncoding("utf-8");
            String userID = request.getSession().getAttribute("userName") + "";

            if (StringTool.isNullString(userID)) {
                for (int i = 0; i < NOT_FILTER.length; i++) {
                    if (url.indexOf(NOT_FILTER[i]) != -1) {
                        b = true;
                        break;
                    }
                }
            } else {
                b = true;
            }
        } else {
            b = true;
        }

        if (b) {
            chain.doFilter(request, response);
        } else {
            response.sendRedirect(request.getContextPath() + "/login.admin.do");
        }
    }

    @Override
    public void init(FilterConfig arg0) throws ServletException {
        // TODO Auto-generated method stub

    }
}

