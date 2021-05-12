package com.mvc.controller;

import com.bean.UserInfo;
import com.mvc.service.UserInfoService;
import com.tool.PageTool;
import com.tool.StringTool;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Created by lw on 14-3-21.
 */
@Controller
public class UserInfoController {

    @Resource
    UserInfoService userInfoService;

    /**
     * 获取列表用户信息
     *
     * @param request
     * @return
     */
    @RequestMapping(value = "/getUserInfos.admin.do", method = RequestMethod.POST)
    public
    @ResponseBody
    PageTool getUserInfos(HttpServletRequest request) {

        String search = request.getParameter("search");
        String pageShowSize = request.getParameter("pageShowSize");
        String thisPage = request.getParameter("thisPage");
        String pageMethodName = request.getParameter("pageMethodName");
        PageTool pageTool = userInfoService.getUserInfos(search, thisPage, pageMethodName,pageShowSize);
        System.out,println("123");
        return pageTool;
    }

    /**
     * 添加一个用户
     *
     * @param request
     * @return
     */
    @RequestMapping(value = "/addUserInfo.admin.do", method = RequestMethod.POST)
    @ResponseBody
    public String addUserInfo(HttpServletRequest request) {
        String username = request.getParameter("username").trim();
        String password = request.getParameter("password").trim();
        String email = request.getParameter("email").trim();
        String sex = request.getParameter("sex").trim();
        String age = request.getParameter("age").trim();
        String phone = request.getParameter("phone").trim();
        String address = request.getParameter("address").trim();
        UserInfo userInfo = new UserInfo();
        userInfo.setUserAddress(address);
        userInfo.setUserAge(age);
        userInfo.setUserEmail(email);
        userInfo.setUserName(username);
        userInfo.setUserSex(sex);
        userInfo.setUserPassword(password);
        userInfo.setUserPhone(phone);

        return userInfoService.addUserInfo(userInfo);
    }

    /**
     * 修改用户
     *
     * @param request
     * @return
     */
    @RequestMapping(value = "/updateUserInfo.admin.do", method = RequestMethod.POST)
    @ResponseBody
    public String updateUserInfo(HttpServletRequest request) {
        String username = request.getParameter("username").trim() + "";
        String password = request.getParameter("password").trim() + "";
        String email = request.getParameter("email").trim() + "";
        String sex = request.getParameter("sex").trim() + "";
        String age = request.getParameter("age").trim() + "";
        String phone = request.getParameter("phone").trim() + "";
        String address = request.getParameter("address").trim() + "";
        UserInfo userInfo = new UserInfo();
        userInfo.setUserAddress(address);
        userInfo.setUserAge(age);
        userInfo.setUserEmail(email);
        userInfo.setUserName(username);
        userInfo.setUserSex(sex);
        userInfo.setUserPassword(password);
        userInfo.setUserPhone(phone);

        return userInfoService.updateUser(userInfo);
    }

    /**
     * 验证用户是否重复
     *
     * @param request
     * @return
     */
    @RequestMapping(value = "/isHavaThisUserName.admin.do", method = RequestMethod.POST)
    @ResponseBody
    public String isHavaThisUserName(HttpServletRequest request) {
        String username = request.getParameter("username");

        return userInfoService.isHavaThisUserName(username);
    }


    /**
     * 删除用户
     *
     * @param request
     * @return
     */
    @RequestMapping(value = "/delUserInfo.admin.do", method = RequestMethod.POST)
    @ResponseBody
    public String delUserInfo(HttpServletRequest request) {
        String username = request.getParameter("username");

        String s = userInfoService.deleteUser(username);
        return s;
    }

    /**
     * 获取用户权限
     *
     * @param request
     * @return
     */
    @RequestMapping(value = "/getFunctionForUserInfo.admin.do", method = RequestMethod.POST)
    @ResponseBody
    public String getFunctionForUserInfo(HttpServletRequest request, HttpServletResponse response) {
        String username = request.getParameter("username");
        StringTool.writeByAction(userInfoService.getFunctionForUserInfo(username), response);
        return null;
    }


    /**
     * 修改用户权限
     *
     * @param request
     * @return
     */
    @RequestMapping(value = "/saveFunctionUserInfo.admin.do", method = RequestMethod.POST)
    @ResponseBody
    public String saveFunctionUserInfo(HttpServletRequest request, HttpServletResponse response) {
        String username = request.getParameter("username");
        String data = request.getParameter("data");
        int i = 1;
        try {
            userInfoService.saveFunctionUserInfo(username, data);
        } catch (Exception e) {
            i = 0;
        }
        return i + "";
    }

}
