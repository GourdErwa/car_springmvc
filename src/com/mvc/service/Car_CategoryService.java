package com.mvc.service;

import com.bean.Car_Category;
import com.mvc.dao.Car_CategoryDao;
import com.tool.PageTool;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;


/**
 * Created by lw on 14-3-22.
 */
@Service
public class Car_CategoryService {


    @Resource
    Car_CategoryDao car_categoryDao;

    /**
     * 分页查询车辆类别信息
     *
     * @param thisPage
     * @param pageMethodName
     * @param pageShowSize
     * @return
     */
    public PageTool getCar_Categors(String thisPage, String pageMethodName, String search, String pageShowSize) {

        PageTool pageTool = PageTool.getPageTool(car_categoryDao.getCar_CategorySize(search), Integer.parseInt(pageShowSize), pageMethodName, Integer.parseInt(thisPage));

        return car_categoryDao.getCar_Categorys(pageTool, search);
    }

    /**
     * 添加车辆类别信息
     *
     * @param car_category
     * @return
     */
    public String addCar_Category(Car_Category car_category) {

        return car_categoryDao.addCar_Category(car_category) + "";
    }

    /**
     * 修改车辆类别信息
     *
     * @param car_category
     * @return
     */
    public String updateCar_category(Car_Category car_category) {

        return car_categoryDao.updateCar_category(car_category) + "";
    }

    /**
     * 是否重复名添加
     *
     * @param categoryname
     * @return
     */
    public String isHavaThisCategoryName(String categoryname) {

        Map map = (Map) car_categoryDao.isHavaThisCategoryName(categoryname).get(0);

        return map.get("COUNT") + "";
    }

    /**
     * 删除车辆类别信息
     *
     * @param id
     * @return
     */
    public String delCar_CategorForId(String id) {

        return car_categoryDao.deleteCar_Category(id) + "";
    }

    /**
     * 设置车辆类别显示状态
     *
     * @param id
     * @return
     */
    public String setState(String id) {

        return car_categoryDao.setState(id) + "";
    }

    /**
     * 页面初始化，填充车辆类别到下拉框
     *
     * @return
     */
    public String getCar_categorysInSelect() {

        List<Map> mapList = car_categoryDao.getCar_categorysInSelect();

        StringBuffer buffer = new StringBuffer();

        String str;
        for (Map map : mapList) {
            str = map.get("CATEGORYNAME") + "";
            buffer.append("<option id=\"").append(str).append("\">").append(str).append("</option>");
        }

        return buffer.toString();
    }

    /**
     * 页面初始化，填充车辆类别到a标签展示
     *
     * @return
     */
    public String getCar_categorysIna(String categoryname) {

        List<Map> mapList = car_categoryDao.getCar_categorysIna();

        StringBuffer buffer = new StringBuffer();

        if (categoryname.equals("")) {
            buffer.append("<a href=\"#\" class=\"list-group-item active\" onclick=\"setcategoryname('')\">显示全部车辆</a>");
        } else {
            buffer.append("<a href=\"#\" class=\"list-group-item \" onclick=\"setcategoryname('')\">显示全部车辆</a>");
        }

        String str;
        for (Map map : mapList) {
            str = map.get("CATEGORYNAME") + "";
            if (str.equals(categoryname)) {
                buffer.append("<a href=\"#\" onclick=\"setcategoryname('" + str + "')\"class=\"list-group-item active\">" + str + "</a>");
            } else {
                buffer.append("<a href=\"#\" onclick=\"setcategoryname('" + str + "')\"class=\"list-group-item\">" + str + "</a>");
            }
        }


        return buffer.toString();
    }

    /**
     * 页面初始化，填充车辆某类别下车辆到下拉框
     *
     * @return
     */
    public String getCar_NameInSelect(String carcategory) {

        List<Map> mapList = car_categoryDao.getCar_NameInSelect(carcategory);

        StringBuffer buffer = new StringBuffer();

        String str;
        for (Map map : mapList) {
            str = map.get("CARNAME") + "";
            buffer.append("<option id=\"").append(str).append("\">").append(str).append("</option>");
        }

        return buffer.toString();
    }

}
