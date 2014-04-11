package com.mvc.controller;

import com.bean.Car_Message;
import com.mvc.service.Car_MessageService;
import com.tool.ApacheCommonsTool;
import com.tool.InitParameters;
import com.tool.PageTool;
import com.tool.StringTool;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.HashMap;
import java.util.UUID;

/**
 * Created by lw on 14-3-21.
 */
@Controller
public class Car_MessageController {

    @Resource
    Car_MessageService car_messageService;


    /**
     * 添加一条车辆明细
     *
     * @param request
     * @return
     */
    @RequestMapping(value = "/addCar_Message.admin.do", method = RequestMethod.POST)
    public String addCar_Message(MultipartHttpServletRequest request, HttpServletResponse response) {

        String carname = request.getParameter("carname");
        String carcategory = request.getParameter("carcategory");
        String oneday = request.getParameter("oneday");
        String baigongli = request.getParameter("baigongli");
        String favorableday = request.getParameter("favorableday");
        String favorableratio = request.getParameter("favorableratio");
        String carmessage = request.getParameter("carmessage");
        String carlevel = request.getParameter("carlevel");
        String carfuel = request.getParameter("carfuel");
        String carfree = request.getParameter("carfree");
        String carrentdays = request.getParameter("carrentdays");
        String isshow = request.getParameter("isshow");

        MultipartFile multipartFile = request.getFile("carpicture");

        String originalFilename = multipartFile.getOriginalFilename();
        String last = originalFilename.split("\\.")[1];

        if (!StringTool.isValidFileName(last)) {
            StringTool.writeByAction("<script language=\"javascript\">alert('保存失败，文件格式不支持！');window.history.go(-1);</script>", response);
            return null;
        }
        String uuId = UUID.randomUUID().toString();
        String fileName = uuId + "." + last;

        String fileNamePath = InitParameters.UPLOAD_PATH + uuId + InitParameters.FILE_SEPARATOR + "home_page" + InitParameters.FILE_SEPARATOR;

        String path = request.getSession().getServletContext().getRealPath(fileNamePath); // 获取存储路径
        if (!ApacheCommonsTool.uploadFile(multipartFile, path, fileName)) {
            StringTool.writeByAction("<script language=\"javascript\">alert('保存失败，请稍后重试！');window.history.go(-1);</script>", response);
            return null;
        }

        Car_Message car_message = new Car_Message();
        car_message.setIsShow(isshow);
        car_message.setBaiGongLi(baigongli);
        car_message.setCarCategory(carcategory);
        car_message.setCarFree(carfree);
        car_message.setOneDay(oneday);
        car_message.setCarFuel(carfuel);
        car_message.setCarLevel(carlevel);
        car_message.setCarMessage(carmessage);
        car_message.setCarName(carname);
        car_message.setFavorableDay(favorableday);
        car_message.setFavorableRatio(favorableratio);
        car_message.setCarRentdays(carrentdays);
        car_message.setCarPicture(fileNamePath + fileName);
        car_messageService.addCar_Message(car_message);
        return "redirect:/url.admin.do?function=car_message";
    }


    /**
     * 修改车辆明细
     *
     * @param request
     * @return
     */
    @RequestMapping(value = "/updateCar_Message.admin.do", method = RequestMethod.POST)
    public String updateCar_Message(MultipartHttpServletRequest request, HttpServletResponse response) throws UnsupportedEncodingException {

        String carname = request.getParameter("carname");
        String carcategory = request.getParameter("carcategory");
        String oneday = request.getParameter("oneday");
        String baigongli = request.getParameter("baigongli");
        String favorableday = request.getParameter("favorableday");
        String favorableratio = request.getParameter("favorableratio");
        String carmessage = request.getParameter("carmessage");
        String carlevel = request.getParameter("carlevel");
        String carfuel = request.getParameter("carfuel");
        String carfree = request.getParameter("carfree");
        String carrentdays = request.getParameter("carrentdays");
        String isshow = request.getParameter("isshow");

        MultipartFile multipartFile = request.getFile("carpicture");
        //图片置于隐藏域，如果没有修改则等于原图片路径
        String picture = request.getParameter("picture");
        if (!multipartFile.isEmpty()) {
            String originalFilename = multipartFile.getOriginalFilename();
            String last = originalFilename.split("\\.")[1];

            if (!StringTool.isValidFileName(last)) {
                StringTool.writeByAction("<script language=\"javascript\">alert('保存失败，文件格式不支持！');window.history.go(-1);</script>", response);
                return null;
            }
            String uuId = UUID.randomUUID().toString();
            String fileName = uuId + "." + last;

            String fileNamePath = InitParameters.UPLOAD_PATH + uuId + InitParameters.FILE_SEPARATOR + "home_page" + InitParameters.FILE_SEPARATOR;

            String path = request.getSession().getServletContext().getRealPath(fileNamePath); // 获取存储路径
            if (!ApacheCommonsTool.uploadFile(multipartFile, path, fileName)) {
                StringTool.writeByAction("<script language=\"javascript\">alert('保存失败，请稍后重试！');window.history.go(-1);</script>", response);
                return null;
            }
            picture = fileNamePath + fileName;
        }
        Car_Message car_message = new Car_Message();
        car_message.setIsShow(isshow);
        car_message.setBaiGongLi(baigongli);
        car_message.setCarCategory(carcategory);
        car_message.setCarFree(carfree);
        car_message.setOneDay(oneday);
        car_message.setCarFuel(carfuel);
        car_message.setCarLevel(carlevel);
        car_message.setCarMessage(carmessage);
        car_message.setCarName(carname);
        car_message.setFavorableDay(favorableday);
        car_message.setFavorableRatio(favorableratio);
        car_message.setCarRentdays(carrentdays);
        car_message.setCarPicture(picture);
        car_messageService.updateCar_Message(car_message);
        String carcategory_ = request.getParameter("carcategory_");
        String url = (StringTool.isNullString(carcategory_)) ? "redirect:/url.admin.do?function=car_message" : "redirect:/setCar_Message.admin.do?categoryname=" + carcategory_;
        return url;
    }


    /**
     * 修改某类别车辆——车辆信息页面跳转
     *
     * @return
     */
    @RequestMapping(value = "/updateCar_Message_Go.admin.do", method = RequestMethod.GET)
    public ModelAndView updateCar_Message_Go(HttpServletRequest request, ModelMap modelMap) throws UnsupportedEncodingException {
        String carname = request.getParameter("carname");
        String carcategory = request.getParameter("carcategory");

        carname = URLDecoder.decode(carname, "utf-8");
        carcategory = URLDecoder.decode(carcategory, "utf-8");

        modelMap.addAllAttributes(car_messageService.updateCar_Message_Go(carname, carcategory));

        return new ModelAndView("admin_car_message_update");
    }

    /**
     * 验证 所属类别下该车是否重复是否重复
     *
     * @param request
     * @return
     */
    @RequestMapping(value = "/isHavaThisCar.admin.do", method = RequestMethod.POST)
    @ResponseBody
    public String isHavaThisCar(HttpServletRequest request) {
        String carName = request.getParameter("carName");
        String carCategory = request.getParameter("carCategory");

        return car_messageService.isHavaThisCar(carName, carCategory);
    }

    /**
     * 获取车辆类别信息
     *
     * @param request
     * @return
     */
    @RequestMapping(value = "/getCar_Messages.admin.do", method = RequestMethod.POST)
    public
    @ResponseBody
    PageTool getCar_Messages(HttpServletRequest request) {
        String thisPage = request.getParameter("thisPage");
        String pageShowSize = request.getParameter("pageShowSize");
        String search = request.getParameter("search");
        String pageMethodName = request.getParameter("pageMethodName");
        String categoryname = request.getParameter("categoryname");

        return car_messageService.getCar_Messages(thisPage, pageMethodName, search, pageShowSize, categoryname);

    }

    /**
     * 获取车辆类别信息,前台展示
     *
     * @param request
     * @return
     */
    @RequestMapping(value = "/getCar_Messages.do", method = RequestMethod.POST)
    public
    @ResponseBody
    PageTool getCar_MessagesNotAdmin(HttpServletRequest request) {
        String thisPage = request.getParameter("thisPage");
        String pageShowSize = request.getParameter("pageShowSize");
        String search = request.getParameter("search");
        String pageMethodName = request.getParameter("pageMethodName");
        String categoryname = request.getParameter("categoryname");

        return car_messageService.getCar_MessagesNotAdmin(thisPage, pageMethodName, search, pageShowSize, categoryname);

    }


    /**
     * 修改显示状态
     *
     * @param request
     * @return
     */
    @RequestMapping(value = "/setStateForCar_Message.admin.do", method = RequestMethod.POST)
    @ResponseBody
    public String setStateForCar_Message(HttpServletRequest request) {
        String carname = request.getParameter("carname");
        String carcategory = request.getParameter("carcategory");
        return car_messageService.setStateForCar_Message(carname, carcategory);
    }

    /**
     * 删除某类别下的某车辆信息
     *
     * @param request
     * @return
     */
    @RequestMapping(value = "/deleteCar_MessageForId.admin.do", method = RequestMethod.POST)
    @ResponseBody
    public String deleteCar_MessageForId(HttpServletRequest request) {
        String carname = request.getParameter("carname");
        String carcategory = request.getParameter("carcategory");
        return car_messageService.deleteCar_Message(carname, carcategory);
    }

}