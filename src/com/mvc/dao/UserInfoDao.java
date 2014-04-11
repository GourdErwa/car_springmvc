package com.mvc.dao;

import com.bean.UserInfo;
import com.tool.PageTool;
import com.tool.StringTool;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;


/**
 * Created by lw on 14-3-21.
 */
@Repository
public class UserInfoDao extends PublicDao {

    /**
     * 获取所有用户总数
     * 可以模糊查询
     *
     * @return 总数大小
     */
    public int getUsersSize(String search) {

        List list;

        String sql = "SELECT COUNT(USERNAME) AS COUNT FROM USERINFO ";
        if (StringTool.isNotNullString(search)) {
            //Object[] objects = {"%"+search+"%"};
            sql += "  WHERE USERNAME LIKE '%" + search + "%' OR USERSEX LIKE '%" + search + "%' OR USERAGE LIKE  '%" + search + "%' OR USERADDRESS LIKE '%" + search + "%' ";
            // list = getListForObjects(sql, objects);
        }
        list = getList(sql);
        Map map = (Map) list.get(0);
        return Integer.parseInt(map.get("COUNT") + "");
    }

    /**
     * 分页查询用户
     * 可以模糊查询
     *
     * @param pageTool
     * @return
     */
    public PageTool getUsers(PageTool pageTool, String search) {
        String sql_search = "";
        if (StringTool.isNotNullString(search)) {
            sql_search += "  WHERE USERNAME LIKE '%" + search + "%' OR USERSEX LIKE '%" + search + "%' OR USERAGE LIKE  '%" + search + "%' OR USERADDRESS LIKE '%" + search + "%' ";
        }

        String sql = "SELECT * FROM (SELECT U.*,ROWNUM AS RM FROM (" +
                "SELECT UserName, UserAddress , UserAge,UserSex, UserPhone,UserEmail FROM USERINFO " + sql_search +
                ")U WHERE ROWNUM <=" + pageTool.endSize + ") WHERE  RM >" + pageTool.startSize;


        pageTool.pageBody = getList(sql);

        return pageTool;
    }

    /**
     * 是否存在此用户
     *
     * @param userName
     * @return
     */
    public List isHavaThisUserName(String userName) {

        String sql = "SELECT COUNT(*) AS COUNT FROM USERINFO WHERE USERNAME=?";

        Object[] objects = {userName};

        return getListForObjects(sql, objects);
    }

    /**
     * 是否可以登录
     *
     * @param userName
     * @return
     */
    public List isHavaThisUserName(String userName, String password) {

        String sql = "SELECT COUNT(*) AS COUNT FROM USERINFO WHERE USERNAME=? AND USERPASSWORD=?";

        Object[] objects = {userName, password};

        return getListForObjects(sql, objects);
    }

    /**
     * 新建用户
     *
     * @param userInfo
     * @return
     */
    public int addUser(UserInfo userInfo) {

        String sql = "INSERT INTO USERINFO (UserName,UserPassword,UserAddress,UserAge,UserSex,UserPhone,UserEmail) VALUES(?,?,?,?,?,?,?)";
        Object[] objects = new Object[7];
        objects[0] = userInfo.getUserName();
        objects[1] = userInfo.getUserPassword();
        objects[2] = userInfo.getUserAddress();
        objects[3] = userInfo.getUserAge();
        objects[4] = userInfo.getUserSex();
        objects[5] = userInfo.getUserPhone();
        objects[6] = userInfo.getUserEmail();

        return getUpdateForObjects(sql, objects);
    }

    /**
     * 修改用户
     *
     * @param userInfo
     * @return
     */
    public int updateUser(UserInfo userInfo) {

        String sql = "UPDATE USERINFO SET UserPassword=?,UserAddress=?,UserAge=?,UserSex=?,UserPhone=?,UserEmail=? WHERE USERNAME=?";

        Object[] objects = new Object[7];
        objects[0] = userInfo.getUserPassword();
        objects[1] = userInfo.getUserAddress();
        objects[2] = userInfo.getUserAge();
        objects[3] = userInfo.getUserSex();
        objects[4] = userInfo.getUserPhone();
        objects[5] = userInfo.getUserEmail();
        objects[6] = userInfo.getUserName();

        return getUpdateForObjects(sql, objects);
    }

    /**
     * 删除用户
     *
     * @param userName
     * @return
     */
    public int deleteUsers(String userName) {

        String sql = "DELETE FROM USERINFO WHERE USERNAME ='" + userName + "'";

        String sql_del_Power = "DELETE FROM POWER WHERE USERNAME ='" + userName + "'";

        getUpdate(sql);

        return getUpdate(sql_del_Power);
    }

    /**
     * 查询用户权限
     *
     * @param userName
     * @return
     */
    public List getFunction(String userName) {

        String sql = "SELECT F.FUNCTIONID,F.FUNCTIONNAME  FROM FUNCTION F INNER JOIN  POWER P ON  F.FUNCTIONID=P.FUNCTIONID WHERE P.USERNAME=?";

        Object[] objects = {userName};
        return getListForObjects(sql, objects);
    }

    /**
     * 查询用户权限
     * 如果用户选择了清空所有权限，则清空。清空后，不进行插入操作
     *
     * @param userName
     * @return
     */
    public void saveFunctionUserInfo(String userName, List<String> data) {


        int size = data.size();
        getUpdate("DELETE FROM POWER WHERE USERNAME ='" + userName + "'");
        if (!data.contains("0")) {
            String[] sqls = new String[size];
            for (int i = 0; i < size; i++) {
                sqls[i] = "INSERT INTO POWER VALUES('" + userName + "','" + data.get(i) + "')";
            }
            getUpdateBatch(sqls);
        }

    }

}
