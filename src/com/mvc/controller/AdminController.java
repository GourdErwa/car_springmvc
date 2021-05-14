package com.mvc.controller;

import com.mvc.service.UserInfoService;
import com.tool.StringTool;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

/**
 * Created by lw on 14-3-22.
 */
@Controller
public class AdminController {

    @Resource
    UserInfoService userInfoService;

    /**
     * 登录判断
     *
     * @param request
     * @param modelMap
     * @return
     */
    @RequestMapping(value = "/welcome.admin.do", method = RequestMethod.POST)
    public ModelAndView welcome(HttpServletRequest request,
                                ModelMap modelMap) {

        String username = request.getParameter("username");
        String password = request.getParameter("password");
        System.out.println("zailaiyici");
        System.out.println("niubi");

        if (StringTool.isNullString(username) || StringTool.isNullString(password)) {
            modelMap.addAttribute("error", "提交信息不完整！");
            return new ModelAndView("admin_login");
        }


        if (StringTool.isHavaIllegalityString(username) || StringTool.isHavaIllegalityString(password)) {
            modelMap.addAttribute("error", "含有非法字符！");
            return new ModelAndView("admin_login");
        }

        boolean b = userInfoService.isLogin(username, password);

        if (b) {
            HttpSession session = request.getSession();
            session.setAttribute("userName", username);
            userInfoService.getFunctionForUser(session, username);
            return new ModelAndView("admin");

        } else {
            modelMap.addAttribute("error", "用户名密码不正确！");
            return new ModelAndView("admin_login");
        }
    }


    /**
     * 注销
     *
     * @param request
     * @return
     */
    @RequestMapping(value = "/loginout.admin.do", method = RequestMethod.GET)
    public ModelAndView loginout(HttpServletRequest request) {
        HttpSession session=request.getSession();
        session.removeAttribute("userName");
        String [] strs=session.getValueNames();
        for(int i=0;i<strs.length;i++){
        	session.removeAttribute(strs[i]);
        }
        return new ModelAndView("admin_login");
    }
}
