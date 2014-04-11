package com.mvc.dao;

import com.bean.LeaveMessage;
import com.tool.PageTool;
import com.tool.StringTool;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;


/**
 * Created by lw on 14-3-21.
 */
@Repository
public class LeaveMessageDao extends PublicDao {


    /**
     * 获取所有留言条数，按条件筛选
     * search 格式为开始时间-结束时间
     *
     * @return 总数大小
     */
    public int getLeaveMessageSize(String search) {

        List list;

        String sql = "SELECT COUNT(ID) AS COUNT FROM LEAVEMESSAGE ";
        if (StringTool.isNotNullString(search)) {
            String[] strs = search.split(",");
            sql += " WHERE MESSAGEDATE >= TO_DATE('" + strs[0] + "','yyyy-MM-dd') AND MESSAGEDATE<=TO_DATE('" + strs[1] + "','yyyy-MM-dd')";
        }
        list = getList(sql);
        Map map = (Map) list.get(0);
        return Integer.parseInt(map.get("COUNT") + "");
    }

    /**
     * 分页查询留言
     * search 格式为开始时间-结束时间
     *
     * @param pageTool
     * @return
     */
    public PageTool getLeaveMessages(PageTool pageTool, String search) {

        String sql_search = "";
        if (StringTool.isNotNullString(search)) {
            String[] strs = search.split(",");
            sql_search += " WHERE MESSAGEDATE >= TO_DATE('" + strs[0] + "','yyyy-MM-dd') AND MESSAGEDATE<=TO_DATE('" + strs[1] + "','yyyy-MM-dd')";
        }
        String sql = "SELECT * FROM (SELECT U.*,ROWNUM AS RM FROM (" +
                "SELECT ID, IP , ADDRESS,TO_CHAR(MESSAGEDATE,'yyyy-mm-dd hh24:mi:ss') MESSAGEDATE, MESSAGES,ISSHOW FROM LEAVEMESSAGE " + sql_search +
                " ORDER BY ID DESC)U WHERE ROWNUM <=" + pageTool.endSize + ") WHERE  RM >" + pageTool.startSize;

        pageTool.pageBody = getList(sql);

        return pageTool;
    }


    /**
     * 新建一条信息
     *
     * @param leaveMessage
     * @return
     */
    public String addLeaveMessage(LeaveMessage leaveMessage) {

        String max_id_sql = "(SELECT NVL(MAX(ID),0)+1 AS ID FROM LEAVEMESSAGE)";
        List<Map> list = getList(max_id_sql);
        String sql = "INSERT INTO LEAVEMESSAGE (ID,IP,ADDRESS,MESSAGEDATE,MESSAGES) VALUES(" + list.get(0).get("ID") + ",?,?,SYSDATE,?)";
        Object[] objects = new Object[3];
        objects[0] = leaveMessage.getIp();
        objects[1] = leaveMessage.getAddress();
        objects[2] = leaveMessage.getMessages();

        return getUpdateForObjects(sql, objects) + "";
    }

    /**
     * 查询未读的留言条数
     *
     * @return
     */
    public List getMessageNotShow() {
        String sql = "SELECT COUNT(ID) AS COUNT FROM LEAVEMESSAGE WHERE ISSHOW='0'";
        return getList(sql);
    }

    /**
     * 删除一条信息
     *
     * @param id
     * @return
     */
    public int deleteLeaveMessages(String id) {


        String sql = "DELETE FROM LEAVEMESSAGE WHERE ID ='" + id + "'";


        return getUpdate(sql.toString());
    }

}
