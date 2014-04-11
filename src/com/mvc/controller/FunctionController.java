package com.mvc.controller;

import com.mvc.service.FunctionService;
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
public class FunctionController {

    @Resource
    FunctionService functionService;

    /**
     * 获取所有权限
     *
     * @return
     */
    @RequestMapping(value = "/getFunctions.admin.do", method = RequestMethod.GET)
    @ResponseBody
    public String getFunctions(HttpServletRequest request, HttpServletResponse response) {
        String onchangeName = request.getParameter("onchangeName");
        String idName = request.getParameter("idName");
        StringTool.writeByAction(functionService.getFunctions(idName, onchangeName), response);
        return null;
    }
}
