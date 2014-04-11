package com.mvc.dao;

import com.bean.Car_Category;
import com.tool.PageTool;
import com.tool.StringTool;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

/**
 * Created by lw on 14-3-21.
 */
@Repository
public class Car_CategoryDao extends PublicDao {


    /**
     * 获取所有车辆类别条数，按条件筛选
     *
     * @return 总数大小
     */
    public int getCar_CategorySize(String search) {

        List list;

        String sql = "SELECT COUNT(CATEGORYNAME) AS COUNT FROM CAR_CATEGORY ";
        if (StringTool.isNotNullString(search)) {
            sql += " WHERE CATEGORYNAME LIKE '%" + search + "%'";
        }
        list = getList(sql);
        Map map = (Map) list.get(0);
        return Integer.parseInt(map.get("COUNT") + "");
    }

    /**
     * 获取所有车辆类别条数，按条件筛选
     *
     * @param pageTool
     * @param search
     * @return
     */
    public PageTool getCar_Categorys(PageTool pageTool, String search) {

        String sql_search = " WHERE 1=1 ";
        if (StringTool.isNotNullString(search)) {
            sql_search += " AND CATEGORYNAME LIKE '%" + search + "%'";
        }

        String sql = "SELECT * FROM (SELECT U.*,ROWNUM AS RM FROM (" +
                "SELECT CATEGORYNAME, ISSHOW , CATEGORYPICTURE,CATEGORYMESSAGE  FROM CAR_CATEGORY " + sql_search +
                " )U WHERE ROWNUM <=" + pageTool.endSize + ") WHERE  RM >" + pageTool.startSize;

        pageTool.pageBody = getList(sql);

        return pageTool;
    }


    /**
     * 新建一车辆类别
     *
     * @param car_category
     * @return
     */
    public int addCar_Category(Car_Category car_category) {

        String sql = "INSERT INTO CAR_CATEGORY (CATEGORYNAME,ISSHOW,CATEGORYPICTURE,CATEGORYMESSAGE,FILENAME) VALUES(?,?,?,?,?)";
        Object[] objects = {car_category.getCategoryName(), car_category.getIsShow(), car_category.getCategoryPicture(), car_category.getCategoryMessage(), car_category.getFileName()};

        return getUpdateForObjects(sql, objects);
    }

    /**
     * 修改一车辆类别
     *
     * @param car_category
     * @return
     */
    public int updateCar_category(Car_Category car_category) {

        String sql = "UPDATE  CAR_CATEGORY SET ISSHOW=?,CATEGORYPICTURE=?,CATEGORYMESSAGE=?, FILENAME=? WHERE CATEGORYNAME=?";
        Object[] objects = {car_category.getIsShow(), car_category.getCategoryPicture(), car_category.getCategoryMessage(), car_category.getFileName(), car_category.getCategoryName(),};

        return getUpdateForObjects(sql, objects);
    }

    /**
     * 是否存在此车辆类别
     *
     * @param categoryname
     * @return
     */
    public List isHavaThisCategoryName(String categoryname) {

        String sql = "SELECT COUNT(*) AS COUNT FROM CAR_CATEGORY WHERE CATEGORYNAME=?";

        Object[] objects = {categoryname};

        return getListForObjects(sql, objects);
    }


    /**
     * 删除yi条车辆类别,然后将所属此类别的车设为默认类别
     *
     * @param categoryName
     * @return
     */
    public int deleteCar_Category(String categoryName) {

        String sql_1 = "DELETE FROM CAR_CATEGORY WHERE CATEGORYNAME ='" + categoryName + "'";

        getUpdate(sql_1);

        String  sql_2 = "DELETE FROM CAR_MESSAGE WHERE CARCATEGORY=" + categoryName;

        return getUpdate(sql_2);
    }


    /**
     * 设置车辆类别显示状态
     *
     * @param categoryName
     * @return
     */
    public int setState(String categoryName) {


        String sql_state = "SELECT ISSHOW FROM CAR_CATEGORY WHERE CATEGORYNAME =?";

        List<Map> list = getListForObjects(sql_state, new Object[]{categoryName});

        Object[] objects = {(list.get(0).get("ISSHOW").equals("是")) ? "否" : "是"};

        String sql = "UPDATE CAR_CATEGORY SET ISSHOW =?  WHERE CATEGORYNAME ='" + categoryName + "'";

        return getUpdateForObjects(sql, objects);
    }

    /**
     * 页面初始化，填充车辆类别到下拉框
     *
     * @return
     */
    public List getCar_categorysInSelect() {

        String sql = "SELECT CATEGORYNAME FROM CAR_CATEGORY";

        return getList(sql);
    }

    /**
     * 页面初始化，填充车辆类别到下拉框getCar_categorysIna
     *
     * @return
     */
    public List getCar_categorysIna() {

        String sql = "SELECT CATEGORYNAME FROM CAR_CATEGORY WHERE ISSHOW='是'";

        return getList(sql);
    }


    /**
     * 页面初始化，填充车辆类别到下拉框
     *
     * @return
     */
    public List getCar_NameInSelect(String carcategory) {

        String sql = "SELECT CARNAME FROM CAR_MESSAGE WHERE CARCATEGORY =?";
        Object[] objects = {carcategory};
        return getListForObjects(sql, objects);
    }

}
