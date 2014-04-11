package com.mvc.controller;

import com.bean.Car_Take;
import com.mvc.service.Car_TakeService;
import com.tool.PageTool;
import com.tool.StringTool;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Created by lw on 14-3-21.
 */
@Controller
public class Car_TakeController {

    @Resource
    Car_TakeService car_takeService;


    /**
     * 获取出租登记信息
     *
     * @param request
     * @return
     */
    @RequestMapping(value = "/getCar_Takes.admin.do", method = RequestMethod.POST)
    public
    @ResponseBody
    PageTool getCar_Takes(HttpServletRequest request) {

        String search = request.getParameter("search");
        String pageShowSize = request.getParameter("pageShowSize");
        String thisPage = request.getParameter("thisPage");
        String pageMethodName = request.getParameter("pageMethodName");
        String searchBody = request.getParameter("searchBody");
        String isHaveEndTime = request.getParameter("isHaveEndTime");
        PageTool pageTool = car_takeService.getCar_Takes(search, searchBody, isHaveEndTime, thisPage, pageMethodName, pageShowSize);
        return pageTool;
    }

    /**
     * 添加一条车辆出租登记
     *
     * @param request
     * @return
     */
    @RequestMapping(value = "/addCar_Take.admin.do", method = RequestMethod.POST)
    public String addCar_Take(HttpServletRequest request) {

        String carname = request.getParameter("carname");
        String category = request.getParameter("carcategory");
        String money = request.getParameter("money");
        String moremessage = request.getParameter("moremessage");
        String takename = request.getParameter("takename");
        String takelicence = request.getParameter("takelicence");

        Car_Take car_take = new Car_Take();
        car_take.setCarName(carname);
        car_take.setCategory(category);
        car_take.setMoney(money);
        car_take.setTakeName(takename);
        car_take.setTakeLicence(takelicence);
        car_take.setMoreMessage(moremessage);

        car_takeService.addCar_Take(car_take);
        return "redirect:/url.admin.do?function=car_rental_registration";
    }

    /**
     * 设置归还
     *
     * @param request
     * @return
     */
    @RequestMapping(value = "/setEndTime.admin.do", method = RequestMethod.POST)
    public
    @ResponseBody
    String setEndTime(HttpServletRequest request) {
        String carname = request.getParameter("carname");
        String category = request.getParameter("category");
        String starttime = request.getParameter("starttime");

        return car_takeService.setEndTime(carname, category, starttime);
    }


    /**
     * 初始化所有类别下所有车辆到统计图
     *
     * @param request
     * @param response
     * @return
     */
    @RequestMapping(value = "/initForIchart.admin.do", method = RequestMethod.POST)
    public String initForIchart(HttpServletRequest request, HttpServletResponse response) {
        String year = request.getParameter("year");
        String mouth = request.getParameter("mouth");
        StringTool.writeByAction(car_takeService.initForIchart(year, mouth), response);
        return null;
    }

    /**
     * 初始化某类别下某车辆到统计图
     *
     * @param request
     * @param response
     * @return
     */
    @RequestMapping(value = "/initForIchartCar_Name.admin.do", method = RequestMethod.POST)
    public String initForIchartCar_Name(HttpServletRequest request, HttpServletResponse response) {

        String category = request.getParameter("carcategory");
        String year = request.getParameter("year");
        String mouth = request.getParameter("mouth");
        StringTool.writeByAction(car_takeService.initForIchartCar_Name(year, mouth, category), response);
        return null;
    }

}