package com.mvc.service;

import com.bean.Car_Take;
import com.mvc.dao.Car_TakeDao;
import com.tool.PageTool;
import com.tool.StringTool;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;


/**
 * Created by lw on 14-3-22.
 */
@Service
public class Car_TakeService {


    @Resource
    Car_TakeDao car_takeDao;


    /**
     * 分页查询用户信息
     *
     * @return
     */
    public PageTool getCar_Takes(String search, String searchBody, String isHaveEndTime, String thisPage, String pageMethodName, String pageShowSize) {


        searchBody = StringTool.getTimeDate(searchBody, "yyyy-MM-dd HH:mm:ss");

        PageTool pageTool = PageTool.getPageTool(car_takeDao.getCar_TakesSize(search, searchBody, isHaveEndTime), Integer.parseInt(pageShowSize), pageMethodName, Integer.parseInt(thisPage));

        car_takeDao.getCar_Takes(pageTool, search, searchBody, isHaveEndTime);

        return pageTool;
    }


    /**
     * 添加一条车辆出租登记
     *
     * @param car_take
     * @return
     */
    public String addCar_Take(Car_Take car_take) {

        return car_takeDao.addCar_Take(car_take) + "";
    }

    /**
     * 设置归还车辆出租登记
     *
     * @return
     */
    public String setEndTime(String carname, String category, String starttime) {

        return car_takeDao.setEndTime(carname, category, starttime) + "";
    }

    /**
     * 初始化所有类别下所有车辆到统计图
     *
     * @return
     */
    public String initForIchart(String year, String mouth) {


        List<Map> list = car_takeDao.initForIchart(year, mouth);
        StringBuffer buffer = new StringBuffer("[");
        Map map;
        for (int i = 0, n = list.size(); i < n; i++) {
            map = list.get(i);
            buffer.append("{\"name\":\"" + map.get("CATEGORY") + "\",\"value\":\"" + map.get("COUNT") + "\",\"color\":\"" + StringTool.getRandomColor() + "\"");
            if (i != n - 1) {
                buffer.append("},");
            }else {
                buffer.append("}]");
            }
        }

        return buffer.toString();
    }

    /**
     * 初始化某类别下某车辆到统计图
     *
     * @return
     */
    public String initForIchartCar_Name(String year, String mouth, String category) {


        List<Map> list = car_takeDao.initForIchartCar_Name(year, mouth, category);
        StringBuffer buffer = new StringBuffer("[");
        Map map;
        for (int i = 0, n = list.size(); i < n; i++) {
            map = list.get(i);
            buffer.append("{\"name\":\"" + map.get("CARNAME") + "\",\"value\":\"" + map.get("COUNT") + "\",\"color\":\"" + StringTool.getRandomColor() + "\"");
            if (i != n-1) {
                buffer.append("},");
            }else {
                buffer.append("}]");
            }
        }

        return buffer.toString();
    }
}
