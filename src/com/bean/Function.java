package com.bean;

/**
 * Created by lw on 14-3-21.
 * 系统功能bean
 */
public class Function {

    private String functionId;//功能类别
    private String functionName;//功能名称
    private String functionDescribe;//功能描述



    public String getFunctionId() {
        return functionId;
    }

    public void setFunctionId(String functionId) {
        this.functionId = functionId;
    }

    public String getFunctionName() {
        return functionName;
    }

    public void setFunctionName(String functionName) {
        this.functionName = functionName;
    }

    public String getFunctionDescribe() {
        return functionDescribe;
    }

    public void setFunctionDescribe(String functionDescribe) {
        this.functionDescribe = functionDescribe;
    }
}
