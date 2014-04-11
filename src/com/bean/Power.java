package com.bean;

/**
 * Created by lw on 14-3-21.
 * 权限关联关系bean
 */
public class Power {

    private String userName;//用户名
    private String functionId;//功能类别

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getFunctionId() {
        return functionId;
    }

    public void setFunctionId(String functionId) {
        this.functionId = functionId;
    }

}
