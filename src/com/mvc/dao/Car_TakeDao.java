package com.mvc.dao;

import com.bean.Car_Take;
import com.tool.PageTool;
import com.tool.StringTool;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * Created by lw on 14-3-21.
 */
@Repository
public class Car_TakeDao extends PublicDao {

    /**
     * 获取所有登记信息总数
     * 可以模糊查询
     *
     * @return 总数大小
     */
    public int getCar_TakesSize(String search, String searchBody, String isHaveEndTime) {

        List list;

        String sql_search = "";
        if (StringTool.isNotNullString(searchBody)) {
            String[] strs = searchBody.split(",");
            sql_search += " AND STARTTIME >= TO_DATE('" + strs[0] + "','yyyy-MM-dd HH24:mi:ss') AND STARTTIME<=TO_DATE('" + strs[1] + "','yyyy-MM-dd HH24:mi:ss')";
        }

        if (StringTool.isNotNullString(isHaveEndTime)) {
            sql_search += " AND ENDTIME IS NULL ";
        }

        String sql = "SELECT COUNT(*) AS COUNT FROM CAR_TAKE WHERE 1=1 " + sql_search;

        if (StringTool.isNotNullString(search)) {
            sql += "  AND CARNAME LIKE '%" + search + "%' OR CATEGORY LIKE '%" + search + "%' OR TAKENAME LIKE  '%" + search + "%' OR TAKELICENCE LIKE '%" + search + "%' ";
        }

        list = getList(sql);
        Map map = (Map) list.get(0);
        return Integer.parseInt(map.get("COUNT") + "");
    }

    /**
     * 分页查询登记信息
     * 可以模糊查询
     *
     * @param pageTool
     * @return
     */
    public PageTool getCar_Takes(PageTool pageTool, String search, String searchBody, String isHaveEndTime) {
        String sql_search = "";
        if (StringTool.isNotNullString(searchBody)) {
            String[] strs = searchBody.split(",");
            sql_search += " AND STARTTIME >= TO_DATE('" + strs[0] + "','yyyy-MM-dd HH24:mi:ss') AND STARTTIME<=TO_DATE('" + strs[1] + "','yyyy-MM-dd HH24:mi:ss')";
        }

        if (StringTool.isNotNullString(isHaveEndTime)) {
            sql_search += " AND ENDTIME IS NULL ";
        }

        if (StringTool.isNotNullString(search)) {
            sql_search += "  AND CARNAME LIKE '%" + search + "%' OR CATEGORY LIKE '%" + search + "%' OR TAKENAME LIKE  '%" + search + "%' OR TAKELICENCE LIKE '%" + search + "%' ";
        }

        String sql = "SELECT * FROM (SELECT U.*,ROWNUM AS RM FROM (" +
                "SELECT CARNAME,CATEGORY,MONEY,TO_CHAR(STARTTIME,'yyyy-MM-dd HH24:mi:ss') AS STARTTIME,TO_CHAR(ENDTIME,'yyyy-MM-dd HH24:mi:ss') AS ENDTIME,MOREMESSAGE,TAKENAME,TAKELICENCE FROM CAR_TAKE WHERE 1=1  " + sql_search +
                ")U WHERE ROWNUM <=" + pageTool.endSize + ") WHERE  RM >" + pageTool.startSize;


        pageTool.pageBody = getList(sql);

        return pageTool;
    }


    /**
     * 添加一条车辆出租登记
     *
     * @param car_take
     * @return
     */
    public int addCar_Take(Car_Take car_take) {
        String sql = "INSERT INTO CAR_TAKE (CARNAME,CATEGORY,MONEY,STARTTIME,MOREMESSAGE,TAKENAME,TAKELICENCE) VALUES(?,?,?,SYSDATE,?,?,?)";
        Object[] objects = {car_take.getCarName(), car_take.getCategory(), car_take.getMoney(), car_take.getMoreMessage(), car_take.getTakeName(), car_take.getTakeLicence()};
        return getUpdateForObjects(sql, objects);
    }

    /**
     * 设置归还
     *
     * @return
     */
    public int setEndTime(String carname, String category, String starttime) {
        String sql = "UPDATE CAR_TAKE SET ENDTIME = SYSDATE WHERE CARNAME=? AND CATEGORY=? AND STARTTIME=TO_DATE('" + starttime + "','yyyy-mm-dd hh24:mi:ss')";
        Object[] objects = {carname, category};

        return getUpdateForObjects(sql, objects);
    }

    /**
     * 初始化所有类别下所有车辆到统计图
     *
     * @return
     */
    public List initForIchart(String year, String mouth) {
        String sql_search = "";
        if (mouth.equals("全年")) {
            sql_search = " AND T.STARTTIME >= TO_DATE('" + year + "-01-01','yyyy-mm-dd') AND T.STARTTIME <= TO_DATE('" + year + "-12-31','yyyy-mm-dd')";
        }
        if (!mouth.equals("全年")) {
            sql_search = " AND T.STARTTIME >= TO_DATE('" + year + "-" + mouth + "-01','yyyy-mm-dd') AND T.STARTTIME <= ADD_MONTHS(TO_DATE('" + year + "-" + mouth + "-01','yyyy-mm-dd'),-1)";
        }

        String sql = "SELECT T.CATEGORY ,NVL(SUM(MONEY),0) AS COUNT FROM CAR_TAKE T  WHERE 1=1  " + sql_search + " GROUP BY T.CATEGORY";
        return getList(sql);
    }

    /**
     * 初始化某类别下某车辆到统计图
     *
     * @return
     */
    public List initForIchartCar_Name(String year, String mouth, String category) {

        String sql_search = "";
        if (mouth.equals("全年")) {
            sql_search = " AND T.STARTTIME >= TO_DATE('" + year + "-01-01','yyyy-mm-dd') AND T.STARTTIME <= TO_DATE('" + year+ "-12-31','yyyy-mm-dd')";
        }
        if (!mouth.equals("全年")) {
            sql_search = " AND T.STARTTIME >= TO_DATE('" + year + "-" + mouth + "-01','yyyy-mm-dd') AND T.STARTTIME <= ADD_MONTHS(TO_DATE('" + year + "-" + mouth + "-01','yyyy-mm-dd'),-1)";
        }

        String sql = " SELECT T.CARNAME ,NVL(SUM(MONEY), 0) AS COUNT FROM CAR_TAKE T  WHERE 1=1 AND T.CATEGORY= '" + category + "'" + sql_search + " GROUP BY CARNAME";

        return getList(sql);
    }
}
