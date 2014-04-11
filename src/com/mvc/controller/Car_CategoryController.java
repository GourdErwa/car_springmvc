package com.mvc.controller;

import com.bean.Car_Category;
import com.mvc.service.Car_CategoryService;
import com.tool.ApacheCommonsTool;
import com.tool.InitParameters;
import com.tool.PageTool;
import com.tool.StringTool;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.util.UUID;

/**
 * Created by lw on 14-3-21.
 */
@Controller
public class Car_CategoryController {

    @Resource
    Car_CategoryService car_categoryService;

    /**
     * 获取车辆类别信息
     *
     * @param request
     * @return
     */
    @RequestMapping(value = "/getCar_categorys.admin.do", method = RequestMethod.POST)
    public
    @ResponseBody
    PageTool getMessages(HttpServletRequest request) {
        String thisPage = request.getParameter("thisPage");
        String pageShowSize = request.getParameter("pageShowSize");
        String search = request.getParameter("search");
        String pageMethodName = request.getParameter("pageMethodName");
        return car_categoryService.getCar_Categors(thisPage, pageMethodName, search, pageShowSize);

    }

    /**
     * 添加一条车辆类别
     *
     * @param request
     * @return
     */
    @RequestMapping(value = "/addCar_Category.admin.do", method = RequestMethod.POST)
    public String addCar_Category(MultipartHttpServletRequest request, HttpServletResponse response) {

        String categoryname = request.getParameter("categoryname");
        String categorymessage = request.getParameter("categorymessage");
        String isshow = request.getParameter("isshow");
        MultipartFile multipartFile = request.getFile("categorypicture");

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

        Car_Category car_category = new Car_Category();
        car_category.setCategoryName(categoryname);
        car_category.setCategoryMessage(categorymessage);
        car_category.setIsShow(isshow);
        car_category.setFileName(uuId);
        car_category.setCategoryPicture(fileNamePath + fileName);
        car_categoryService.addCar_Category(car_category);
        return "redirect:/url.admin.do?function=car_category";
    }


    /**
     * 修改一条车辆类别
     *
     * @param request
     * @return
     */
    @RequestMapping(value = "/updateCar_category.admin.do", method = RequestMethod.POST)
    public String updateCar_category(MultipartHttpServletRequest request, HttpServletResponse response) {

        String categoryname = request.getParameter("categoryname_");
        String categorymessage = request.getParameter("updatecategorymessage");
        String isshow = request.getParameter("updateisshow");
        MultipartFile multipartFile = request.getFile("updatecategorypicture");

        String originalFilename = multipartFile.getOriginalFilename();
        String last = originalFilename.split("\\.")[1];

        if (!StringTool.isValidFileName(last)) {
            StringTool.writeByAction("<script language=\"javascript\">alert('修改失败，文件格式不支持！');window.history.go(-1);</script>", response);
            return null;
        }
        String uuId = UUID.randomUUID().toString();
        String fileName = uuId + "." + last;

        String fileNamePath = InitParameters.UPLOAD_PATH + uuId + InitParameters.FILE_SEPARATOR + "home_page" + InitParameters.FILE_SEPARATOR;

        String path = request.getSession().getServletContext().getRealPath(fileNamePath); // 获取存储路径
        if (!ApacheCommonsTool.uploadFile(multipartFile, path, fileName)) {
            StringTool.writeByAction("<script language=\"javascript\">alert('修改失败，请稍后重试！');window.history.go(-1);</script>", response);
            return null;
        }

        Car_Category car_category = new Car_Category();
        car_category.setCategoryName(categoryname);
        car_category.setCategoryMessage(categorymessage);
        car_category.setIsShow(isshow);
        car_category.setFileName(uuId);
        car_category.setCategoryPicture(fileNamePath + fileName);
        car_categoryService.updateCar_category(car_category);
        return "redirect:/url.admin.do?function=car_category";
    }


    /**
     * 删除一条车辆类别
     *
     * @param request
     * @return
     */
    @RequestMapping(value = "/delCar_categoryForId.admin.do", method = RequestMethod.POST)
    public
    @ResponseBody
    String delMessageForId(HttpServletRequest request) {
        String ID = request.getParameter("ID");

        return car_categoryService.delCar_CategorForId(ID);
    }

    /**
     * 验证名称是否重复
     *
     * @param request
     * @return
     */
    @RequestMapping(value = "/isHavaThisCar_Category.admin.do", method = RequestMethod.POST)
    @ResponseBody
    public String isHavaThisCar_Category(HttpServletRequest request) {
        String categoryname = request.getParameter("categoryname");

        return car_categoryService.isHavaThisCategoryName(categoryname);
    }

    /**
     * 修改显示状态
     *
     * @param request
     * @return
     */
    @RequestMapping(value = "/setState.admin.do", method = RequestMethod.POST)
    @ResponseBody
    public String setState(HttpServletRequest request) {
        String categoryname = request.getParameter("categoryname");
        return car_categoryService.setState(categoryname);
    }


    /**
     * 页面初始化，填充车辆类别到下拉框
     *
     * @return
     */
    @RequestMapping(value = "/getCar_categorysInSelect.admin.do", method = RequestMethod.GET)
    @ResponseBody
    public void getCar_categorysInSelect(HttpServletResponse response) {

        StringTool.writeByAction(car_categoryService.getCar_categorysInSelect(), response);

    }

    /**
     * 页面初始化，填充车辆类别到a标签
     *
     * @return
     */
    @RequestMapping(value = "/getCar_categorysIna.do", method = RequestMethod.GET)
    @ResponseBody
    public void getCar_categorysIna(HttpServletResponse response, HttpServletRequest request) throws UnsupportedEncodingException {
        String categoryname = new String(request.getParameter("categoryname").toString().getBytes("iso-8859-1"), "utf-8");
        StringTool.writeByAction(car_categoryService.getCar_categorysIna(categoryname), response);

    }


    /**
     * 页面初始化，填充车辆某类别下车辆到下拉框
     *
     * @return
     */
    @RequestMapping(value = "/getCar_NameInSelect.admin.do", method = RequestMethod.POST)
    @ResponseBody
    public void getCar_NameInSelect(HttpServletResponse response, HttpServletRequest request) throws UnsupportedEncodingException {
        String carcategory = request.getParameter("carcategory");
        StringTool.writeByAction(car_categoryService.getCar_NameInSelect(carcategory), response);

    }

}
