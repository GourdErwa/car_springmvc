package com.mvc.dao;

import com.bean.Car_Category;
import com.bean.Car_Message;
import com.tool.PageTool;
import com.tool.StringTool;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * Created by lw on 14-3-21.
 */
@Repository
public class Car_MessageDao extends PublicDao {

    /**
     * 获取所有车辆条数，按条件筛选
     *
     * @param search
     * @param categoryname
     * @return 总数大小
     */
    public int getCar_MessagesSize(String search, String categoryname) {

        List list;

        String sql = "SELECT COUNT(*) AS COUNT FROM CAR_MESSAGE WHERE 1=1 ";
        if (StringTool.isNotNullString(search)) {
            sql += " AND CARNAME LIKE '%" + search + "%'";
        }
        if (StringTool.isNotNullString(categoryname)) {
            sql += " AND CARCATEGORY = '" + categoryname + "'";
        }

        list = getList(sql);
        Map map = (Map) list.get(0);
        return Integer.parseInt(map.get("COUNT") + "");
    }

    /**
     * 获取所有车辆条数，按条件筛选
     *
     * @param pageTool
     * @param search
     * @param categoryname
     * @return
     */
    public PageTool getCar_Messages(PageTool pageTool, String search, String categoryname) {

        String sql_search = " WHERE 1=1 ";
        if (StringTool.isNotNullString(search)) {
            sql_search += " AND CARNAME LIKE '%" + search + "%'";
        }
        if (StringTool.isNotNullString(categoryname)) {
            sql_search += " AND CARCATEGORY = '" + categoryname + "'";
        }

        String sql = "SELECT * FROM (SELECT U.*,ROWNUM AS RM FROM (" +
                //"SELECT ISSHOW,BAIGONGLI,CARCATEGORY,CARFREE,CARFUEL,CARLEVEL,CARMESSAGE,CARNAME,FAVORABLEDAY,FAVORABLERATIO,CARRENTDAYS,ONEDAY,CARPICTURE,STARTDATE,CARRENTDAYS  FROM CAR_MESSAGE " + sql_search +
                "SELECT *  FROM CAR_MESSAGE " + sql_search +
                " )U WHERE ROWNUM <=" + pageTool.endSize + ") WHERE  RM >" + pageTool.startSize;

        pageTool.pageBody = getList(sql);

        return pageTool;
    }

    /**
     * 获取所有车辆条数，按条件筛选NotAdmin
     *
     * @param search
     * @param categoryname
     * @return 总数大小
     */
    public int getCar_MessagesSizeNotAdmin(String search, String categoryname) {

        List list;

        String sql = "SELECT COUNT(*) AS COUNT FROM CAR_MESSAGE WHERE ISSHOW='是' ";

        if (search.equals("500以下")) {
            sql += " AND  ONEDAY <=500";
        } else if (search.equals("1000-2000")) {
            sql += " AND ONEDAY  >=1000 AND ONEDAY <=2000";
        } else if (search.equals("2000-5000")) {
            sql += " AND ONEDAY  >=2000 AND ONEDAY <=5000";
        } else if (search.equals("5000-10000")) {
            sql += " AND ONEDAY  >=5000 AND ONEDAY <=10000";
        } else if (search.equals("10000以上")) {
            sql += " AND ONEDAY  >=10000";
        }

        if (StringTool.isNotNullString(categoryname)) {
            sql += " AND CARCATEGORY = '" + categoryname + "'";
        }

        list = getList(sql);
        Map map = (Map) list.get(0);
        return Integer.parseInt(map.get("COUNT") + "");
    }

    /**
     * 获取所有车辆条数，按条件筛选NotAdmin
     *
     * @param pageTool
     * @param search
     * @param categoryname
     * @return
     */
    public PageTool getCar_MessagesNotAdmin(PageTool pageTool, String search, String categoryname) {

        String sql_search = " WHERE ISSHOW='是' ";
        if (search.equals("500以下")) {
            sql_search += " AND  ONEDAY <=500";
        } else if (search.equals("1000-2000")) {
            sql_search += " AND ONEDAY  >=1000 AND ONEDAY <=2000";
        } else if (search.equals("2000-5000")) {
            sql_search += " AND ONEDAY  >=2000 AND ONEDAY <=5000";
        } else if (search.equals("5000-10000")) {
            sql_search += " AND ONEDAY  >=5000 AND ONEDAY <=10000";
        } else if (search.equals("10000以上")) {
            sql_search += " AND ONEDAY  >=10000";
        }
        if (StringTool.isNotNullString(categoryname)) {
            sql_search += " AND CARCATEGORY = '" + categoryname + "'";
        }

        String sql = "SELECT * FROM (SELECT U.*,ROWNUM AS RM FROM (" +
                //"SELECT ISSHOW,BAIGONGLI,CARCATEGORY,CARFREE,CARFUEL,CARLEVEL,CARMESSAGE,CARNAME,FAVORABLEDAY,FAVORABLERATIO,CARRENTDAYS,ONEDAY,CARPICTURE,STARTDATE,CARRENTDAYS  FROM CAR_MESSAGE " + sql_search +
                "SELECT *  FROM CAR_MESSAGE " + sql_search +
                " )U WHERE ROWNUM <=" + pageTool.endSize + ") WHERE  RM >" + pageTool.startSize;

        pageTool.pageBody = getList(sql);

        return pageTool;
    }


    /**
     * 新建一车辆
     *
     * @param car_message
     * @return
     */
    public int addCar_Message(Car_Message car_message) {

        String sql = "INSERT INTO CAR_MESSAGE (ISSHOW,BAIGONGLI,CARCATEGORY,CARFREE,CARFUEL,CARLEVEL,CARMESSAGE,CARNAME,FAVORABLEDAY,FAVORABLERATIO,CARRENTDAYS,ONEDAY,CARPICTURE,STARTDATE) VALUES(?,?,?,?,?,?,?,?,?,?,?,?,?,SYSDATE)";
        Object[] objects = {car_message.getIsShow(),
                car_message.getBaiGongLi(),
                car_message.getCarCategory(),
                car_message.getCarFree(),
                car_message.getCarFuel(),
                car_message.getCarLevel(),
                car_message.getCarMessage(),
                car_message.getCarName(),
                car_message.getFavorableDay(),
                car_message.getFavorableRatio(),
                car_message.getCarRentdays(),
                car_message.getOneDay(),
                car_message.getCarPicture()};

        return getUpdateForObjects(sql, objects);
    }


    /**
     * 修改一车辆-页面跳转
     *
     * @param carName
     * @param carCategory
     * @return
     */
    public List<Map> updateCar_Message_Go(String carName, String carCategory) {

        String sql = "SELECT * FROM CAR_MESSAGE WHERE carName=? AND carCategory=?";
        Object[] objects = {carName, carCategory};

        return getListForObjects(sql, objects);
    }

    /**
     * 修改一车辆
     *
     * @param car_message
     * @return
     */
    public int updateCar_Message(Car_Message car_message) {

        String sql = "UPDATE  CAR_MESSAGE SET ISSHOW=?,BAIGONGLI=?,CARFREE=?,CARFUEL=?,CARLEVEL=?,CARMESSAGE=?,FAVORABLEDAY=?,FAVORABLERATIO=?,CARRENTDAYS=?,ONEDAY=?,CARPICTURE=? WHERE CARNAME=? AND CARCATEGORY=?";
        Object[] objects = {car_message.getIsShow(),
                car_message.getBaiGongLi(),
                car_message.getCarFree(),
                car_message.getCarFuel(),
                car_message.getCarLevel(),
                car_message.getCarMessage(),
                car_message.getFavorableDay(),
                car_message.getFavorableRatio(),
                car_message.getCarRentdays(),
                car_message.getOneDay(),
                car_message.getCarPicture(),
                car_message.getCarName(),
                car_message.getCarCategory()};
        return getUpdateForObjects(sql, objects);
    }

    /**
     * 验证 所属类别下该车是否重复是否重复
     *
     * @param carName
     * @param carCategory
     * @return
     */
    public List isHavaThisCar(String carName, String carCategory) {

        String sql = "SELECT COUNT(*) AS COUNT FROM CAR_MESSAGE WHERE CARNAME=? AND CARCATEGORY=?";
        Object[] objects = {carName, carCategory};
        return getListForObjects(sql, objects);

    }


    /**
     * 删除某类别下的某车辆信息
     *
     * @param carname
     * @param carcategory
     * @return
     */
    public int deleteCar_Message(String carname, String carcategory) {

        String sql = "DELETE FROM CAR_MESSAGE WHERE  CARNAME =? AND CARCATEGORY=?";
        Object[] objects = {carname, carcategory};
        return getUpdateForObjects(sql.toString(), objects);
    }


    /**
     * 设置车辆显示状态
     *
     * @param carname
     * @param carcategory
     * @return
     */
    public int setStateForCar_Message(String carname, String carcategory) {


        String sql_state = "SELECT ISSHOW FROM CAR_MESSAGE WHERE CARNAME =? AND CARCATEGORY=?";

        List<Map> list = getListForObjects(sql_state, new Object[]{carname, carcategory});

        Object[] objects = {(list.get(0).get("ISSHOW").equals("是")) ? "否" : "是", carname, carcategory};

        String sql = "UPDATE CAR_MESSAGE SET ISSHOW =?  WHERE CARNAME =? AND CARCATEGORY=?";

        return getUpdateForObjects(sql, objects);
    }

}
