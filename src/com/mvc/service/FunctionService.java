package com.mvc.service;

import com.mvc.dao.FunctionDao;
import com.tool.InitParameters;
import org.springframework.stereotype.Service;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.annotation.Resource;
import java.util.List;
import java.util.Map;

/**
 * Created by lw on 14-3-21.
 */
@Service
public class FunctionService {


    @Resource
    FunctionDao functionDao;

    /**
     * 获取所有权限
     *
     * @return
     */
    @RequestMapping(value = "/getFunctions.admin.do", method = RequestMethod.POST)
    @ResponseBody
    public String getFunctions(String idName, String onchangeName) {
        List list = functionDao.getFunctions();

        if (list.size() == 0) {
            return "";
        }
        StringBuilder stringBuilder;
        stringBuilder = new StringBuilder("<select id=\"" + idName + "\" onchange=\"" + onchangeName + "\" multiple class=\"form-control\" SIZE=\"" + InitParameters.SELECT_SIZE_FOR_FUNCTION + "\">");
        stringBuilder.append("<option id=\"0\">---清空所有权限---</option>");
        Map map;
        for (Object aList : list) {
            map = (Map) aList;
            stringBuilder.append("<option id=\"").append(map.get("FUNCTIONID")).append("\">").append(map.get("FUNCTIONNAME")).append("</option>");
        }
        stringBuilder.append("</select>");
        return stringBuilder.toString();
    }
}
