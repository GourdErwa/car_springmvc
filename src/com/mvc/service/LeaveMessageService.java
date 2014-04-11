package com.mvc.service;

import com.bean.LeaveMessage;
import com.mvc.dao.LeaveMessageDao;
import com.tool.PageTool;
import com.tool.StringTool;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import java.util.List;
import java.util.Map;

/**
 * Created by lw on 14-3-22.
 */
@Service
public class LeaveMessageService {

    @Resource
    LeaveMessageDao leaveMessageDao;


    /**
     * 分页查询留言信息
     *
     * @return
     */
    public PageTool getMessages(String search, String thisPage, String pageMethodName, String pageShowSize) {

        search = StringTool.getTimeDate(search, "yyyy-MM-dd");

        PageTool pageTool = PageTool.getPageTool(leaveMessageDao.getLeaveMessageSize(search), Integer.parseInt(pageShowSize), pageMethodName, Integer.parseInt(thisPage));

        return leaveMessageDao.getLeaveMessages(pageTool, search);
    }


    /**
     * 查询未读的留言条数(暂不处理)
     *
     * @return
     */
    public String getMessageNotShow() {
        List<Map> list = leaveMessageDao.getMessageNotShow();
        Map map = list.get(0);
        return map.get("COUNT") + "";
    }

    /**
     * 删除留言信息
     *
     * @param id
     * @return
     */
    public String delMessageForId(String id) {

        return leaveMessageDao.deleteLeaveMessages(id) + "";
    }


    /**
     * 客户留言信息
     *
     * @return
     */
    public String add_message(String message, HttpServletRequest request) {

        if (StringTool.isNullString(message)) {
            return "";
        }
        if (message.length() >= 200) {
            message = message.substring(0, 200);
        }
        String ip = StringTool.getIpAddr(request);//返回发出请求的IP地址

        LeaveMessage leaveMessage = new LeaveMessage();
        leaveMessage.setIp(ip);
        leaveMessage.setMessages(message);
        leaveMessage.setAddress("");

        return leaveMessageDao.addLeaveMessage(leaveMessage);
    }


}
