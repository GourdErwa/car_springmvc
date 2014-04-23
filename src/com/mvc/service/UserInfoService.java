package com.mvc.service;

import com.bean.UserInfo;
import com.mvc.dao.UserInfoDao;
import com.tool.PageTool;
import org.springframework.stereotype.Service;

import javax.annotation.Resource;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

/**
 * Created by lw on 14-3-22.
 */
@Service
public class UserInfoService {

    @Resource
    UserInfoDao userInfoDao;

    /**
     * 判断用户名密码时候正确
     */
    public boolean isLogin(String username, String password) {


        List list = userInfoDao.isHavaThisUserName(username, password);


        Map map = (Map) list.get(0);

        return !(map.get("COUNT") + "").equals("0");

    }

    /**
     * 获取该用户权限，置入session
     *
     * @param session
     * @param userName
     * @return
     */
    public HttpSession getFunctionForUser(HttpSession session, String userName) {
        List<Map> list = userInfoDao.getFunction(userName);
        String functionid;
        for (Map map : list) {
            functionid = map.get("FUNCTIONID") + "";
            session.setAttribute(functionid, functionid);
        }
        return session;
    }

    /**
     * 分页查询用户信息
     *
     * @return
     */
    public PageTool getUserInfos(String search, String thisPage, String pageMethodName, String pageShowSize) {


        PageTool pageTool = PageTool.getPageTool(userInfoDao.getUsersSize(search), Integer.parseInt(pageShowSize),pageMethodName, Integer.parseInt(thisPage));

        userInfoDao.getUsers(pageTool, search);

        return pageTool;
    }

    /**
     * addUserInfo
     *
     * @param userInfo
     * @return
     */
    public String addUserInfo(UserInfo userInfo) {

        int i = userInfoDao.addUser(userInfo);

        return i + "";
    }

    /**
     * 是否重复用户名添加
     *
     * @param userName
     * @return
     */
    public String isHavaThisUserName(String userName) {

        Map map = (Map) userInfoDao.isHavaThisUserName(userName).get(0);

        return map.get("COUNT") + "";
    }

    /**
     * 修改用户信息
     *
     * @param userInfo
     * @return
     */
    public String updateUser(UserInfo userInfo) {

        return userInfoDao.updateUser(userInfo) + "";
    }


    /**
     * 删除用户信息
     *
     * @param username
     * @return
     */
    public String deleteUser(String username) {

        return userInfoDao.deleteUsers(username) + "";
    }


    /**
     * 获取用户权限
     *
     * @param username
     * @return
     */
    public String getFunctionForUserInfo(String username) {

        List list = userInfoDao.getFunction(username);
        if (list.size() == 0) {
            return "";
        }
        Map map;
        String str = "";
        for (Object aList : list) {
            map = (Map) aList;
            str += map.get("FUNCTIONNAME") + ",";
        }
        return str;
    }

    /**
     * 修改用户权限
     *
     * @param username
     * @return
     */
    public void saveFunctionUserInfo(String username, String data) {

        String[] str = data.split(",");
        List<String> strings = new ArrayList<String>();

        for (String aStr : str) {
            if (!aStr.equals("")) {
                strings.add(aStr);
            }
        }
        userInfoDao.saveFunctionUserInfo(username, strings);
    }


}
