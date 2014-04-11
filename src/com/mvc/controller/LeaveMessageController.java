package com.mvc.controller;

import com.mvc.service.LeaveMessageService;
import com.tool.PageTool;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

/**
 * Created by lw on 14-3-21.
 */
@Controller
public class LeaveMessageController {

    @Resource
    LeaveMessageService leaveMessageService;



    /**
     * 客户留言信息
     *
     * @param request
     * @return
     */
    @RequestMapping(value = "/add_message.do", method = RequestMethod.POST)
    public
    @ResponseBody
    String add_message(HttpServletRequest request) {
        String message = request.getParameter("message");

        return leaveMessageService.add_message(message, request);

    }


    /**
     * 获取留言信息
     *
     * @param request
     * @return
     */
    @RequestMapping(value = "/getMessages.admin.do", method = RequestMethod.POST)
    public
    @ResponseBody
    PageTool getMessages(HttpServletRequest request) {
        String search = request.getParameter("search");
        String pageShowSize = request.getParameter("pageShowSize");
        String thisPage = request.getParameter("thisPage");
        String pageMethodName = request.getParameter("pageMethodName");
        return leaveMessageService.getMessages(search, thisPage, pageMethodName, pageShowSize);

    }

    /**
     * 删除一条留言信息
     *
     * @param request
     * @return
     */
    @RequestMapping(value = "/delMessageForId.admin.do", method = RequestMethod.POST)
    public
    @ResponseBody
    String delMessageForId(HttpServletRequest request) {
        String ID = request.getParameter("ID");

        return leaveMessageService.delMessageForId(ID);
    }


}
