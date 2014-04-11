package com.bean;

/**
 * Created by lw on 14-3-21.
 * 车类别bean
 */
public class Car_Category {

    private String categoryName;//类别名称
    private String isShow;//是否显示,0默认显示，1为不显示（则停用所有改类别的车）
    private String categoryPicture;//类别首页图片
    private String categoryMessage;//类别介绍
    private String fileName;//类别图片存储的父目录，采用UUID

    public String getCategoryMessage() {
        return categoryMessage;
    }

    public void setCategoryMessage(String categoryMessage) {
        this.categoryMessage = categoryMessage;
    }

    public String getCategoryName() {
        return categoryName;
    }

    public void setCategoryName(String categoryName) {
        this.categoryName = categoryName;
    }

    public String getIsShow() {
        return isShow;
    }

    public void setIsShow(String isShow) {
        this.isShow = isShow;
    }

    public String getCategoryPicture() {
        return categoryPicture;
    }

    public void setCategoryPicture(String categoryPicture) {
        this.categoryPicture = categoryPicture;
    }

    public String getFileName() {
        return fileName;
    }

    public void setFileName(String fileName) {
        this.fileName = fileName;
    }
}
