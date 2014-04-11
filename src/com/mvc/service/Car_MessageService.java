package com.mvc.service;

import com.bean.Car_Category;
import com.bean.Car_Message;
import com.mvc.dao.Car_CategoryDao;
import com.mvc.dao.Car_MessageDao;
import com.tool.PageTool;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;


/**
 * Created by lw on 14-3-22.
 */
@Service
public class Car_MessageService {


    @Resource
    Car_MessageDao car_messageDao;

    /**
     * 分页查询车辆信息
     *
     * @param thisPage
     * @param pageMethodName
     * @param pageShowSize
     * @return
     */
    public PageTool getCar_Messages(String thisPage, String pageMethodName, String search, String pageShowSize, String categoryname) {

        PageTool pageTool = PageTool.getPageTool(car_messageDao.getCar_MessagesSize(search, categoryname), Integer.parseInt(pageShowSize), pageMethodName, Integer.parseInt(thisPage));

        return car_messageDao.getCar_Messages(pageTool, search, categoryname);
    }

    /**
     * 获取车辆类别信息,前台展示NotAdmin
     *
     * @param thisPage
     * @param pageMethodName
     * @param pageShowSize
     * @return
     */
    public PageTool getCar_MessagesNotAdmin(String thisPage, String pageMethodName, String search, String pageShowSize, String categoryname) {

        PageTool pageTool = PageTool.getPageTool(car_messageDao.getCar_MessagesSizeNotAdmin(search, categoryname), Integer.parseInt(pageShowSize), pageMethodName, Integer.parseInt(thisPage));

        return car_messageDao.getCar_MessagesNotAdmin(pageTool, search, categoryname);
    }



    /**
     * 添加车辆信息
     *
     * @param car_message
     * @return
     */
    public String addCar_Message(Car_Message car_message) {

        return car_messageDao.addCar_Message(car_message) + "";
    }


    /**
     * 修改车辆信息页面跳转-查询车辆信息
     *
     * @param carName
     * @param carCategory
     * @return
     */
    public Map updateCar_Message_Go(String carName, String carCategory) {

        List<Map> list = car_messageDao.updateCar_Message_Go(carName, carCategory);

        return list.get(0);
    }

    /**
     * 修改车辆信息
     *
     * @param car_message
     * @return
     */
    public String updateCar_Message(Car_Message car_message) {

        return car_messageDao.updateCar_Message(car_message) + "";
    }

    /**
     * 验证 所属类别下该车是否重复是否重复
     *
     * @param carName
     * @param carCategory
     * @return
     */
    public String isHavaThisCar(String carName, String carCategory) {

        Map map = (Map) car_messageDao.isHavaThisCar(carName, carCategory).get(0);

        return map.get("COUNT") + "";
    }

    /**
     * 删除某类别下的某车辆信息
     *
     * @param carname
     * @param carcategory
     * @return
     */
    public String deleteCar_Message(String carname, String carcategory) {
        return car_messageDao.deleteCar_Message(carname, carcategory) + "";
    }

    /**
     * 设置车辆显示状态
     *
     * @param carname
     * @param carcategory
     * @return
     */
    public String setStateForCar_Message(String carname, String carcategory) {

        return car_messageDao.setStateForCar_Message(carname, carcategory) + "";
    }

}
