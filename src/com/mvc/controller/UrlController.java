package com.mvc.controller;

import com.tool.FunctionName;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;

/**
 * Created by lw on 14-3-22.
 * 链接跳转
 */
@Controller
public class UrlController {

    /**
     * 进入后台登录页面
     *
     * @param request
     * @param response
     * @param modelMap
     * @return
     */
    @RequestMapping(value = "/login.admin.do", method = RequestMethod.GET)
    public ModelAndView doURL(HttpServletRequest request,
                              HttpServletResponse response, ModelMap modelMap) {

        return new ModelAndView("admin_login");

    }

    /**
     * URL 跳转。错误的链接，跳转到error页面。
     *
     * @param request
     * @param modelMap
     * @return
     */
    @RequestMapping(value = "/url.admin.do", method = RequestMethod.GET)
    public ModelAndView url(HttpServletRequest request,
                            ModelMap modelMap) {
        String function = request.getParameter("function");

        String url = "";
        if (function.equals(FunctionName.function.toString())) {
            url = "admin_function";
        } else if (function.equals(FunctionName.car_category.toString())) {
            url = "admin_car_category";
        } else if (function.equals(FunctionName.userinfo.toString())) {
            url = "admin_userinfo";
        } else if (function.equals(FunctionName.car_message.toString())) {
            url = "admin_car_message";
        } else if (function.equals(FunctionName.car_rental_registration.toString())) {
            url = "admin_car_rental_registration";
        } else if (function.equals(FunctionName.car_chart.toString())) {
            url = "admin_car_chart";
        } else if (function.equals(FunctionName.message.toString())) {
            url = "admin_message";
        } else if (url.equals("")) {
            modelMap.put("error", "页面跳转失败，请联系管理员！");
            url = "admin_error";
        }
        return new ModelAndView(url);

    }

    /**
     * 添加车辆信息页面跳转
     *
     * @return
     */
    @RequestMapping(value = "/addCar_Message_Go.admin.do", method = RequestMethod.GET)
    public ModelAndView addCar_Message() {

        return new ModelAndView("admin_car_message_add");
    }

    /**
     * 管理某类别车辆——车辆信息页面跳转
     *
     * @return
     */
    @RequestMapping(value = "/setCar_Message.admin.do", method = RequestMethod.GET)
    public ModelAndView setCar_Message(HttpServletRequest request) throws UnsupportedEncodingException {
        String categoryname = request.getParameter("categoryname");
        categoryname = URLDecoder.decode(categoryname, "utf-8");
        request.setAttribute("categoryname", categoryname);
        return new ModelAndView("admin_car_message_set_category");
    }

    /**
     * 录入新登记页面跳转
     *
     * @return
     */
    @RequestMapping(value = "/admin_car_rental_registration.admin.do", method = RequestMethod.GET)
    public ModelAndView admin_car_rental_registration() throws UnsupportedEncodingException {
        return new ModelAndView("admin_car_rental_registration_add");
    }


    /**
     * 租车指南
     *
     * @return
     */
    @RequestMapping(value = "/help.do", method = RequestMethod.GET)
    public ModelAndView help() {
        return new ModelAndView("reception/help");
    }
    /**
     * 人才招聘
     *
     * @return
     */
    @RequestMapping(value = "/advertise.do", method = RequestMethod.GET)
    public ModelAndView advertise() {
        return new ModelAndView("reception/advertise");
    }

    /**
     * 公司简介
     *
     * @return
     */
    @RequestMapping(value = "/my.do", method = RequestMethod.GET)
    public ModelAndView my() {
        return new ModelAndView("reception/my");
    }

    /**
     * 在线留言
     *
     * @return
     */
    @RequestMapping(value = "/message.do", method = RequestMethod.GET)
    public ModelAndView message() {
        return new ModelAndView("reception/message");
    }



    /**
     * 联系我们页面跳转
     *
     * @return
     */
    @RequestMapping(value = "/contact_us.do", method = RequestMethod.GET)
    public ModelAndView Contact_Us() {
        return new ModelAndView("reception/contact_us");
    }


}
