package com.bean;

/**
 * Created by lw on 14-3-21.
 * 车明细bean
 */
public class Car_Message {

    private String carName;//车名字
    private String carCategory;//车类别
    private String oneDay;//日租价钱
    private String baiGongLi;//百公里出租价钱
    private String favorableDay;//优惠天数
    private String favorableRatio;//优惠比例
    private String carMessage;//车介绍
    private String carPicture;//车首页展示图片
    private String carLevel;//车级别信息
    private String carFuel;//车耗油量
    private String carFree;//空闲車数
    private String carRentdays;//被租用天数
    private String startDate;//上架时间
    private String isShow;//是否显示，0默认显示，1为不显示，即停用此业务车型

    public String getCarName() {
        return carName;
    }

    public void setCarName(String carName) {
        this.carName = carName;
    }

    public String getCarCategory() {
        return carCategory;
    }

    public void setCarCategory(String carCategory) {
        this.carCategory = carCategory;
    }

    public String getOneDay() {
        return oneDay;
    }

    public void setOneDay(String oneDay) {
        this.oneDay = oneDay;
    }

    public String getBaiGongLi() {
        return baiGongLi;
    }

    public void setBaiGongLi(String baiGongLi) {
        this.baiGongLi = baiGongLi;
    }

    public String getFavorableDay() {
        return favorableDay;
    }

    public void setFavorableDay(String favorableDay) {
        this.favorableDay = favorableDay;
    }

    public String getFavorableRatio() {
        return favorableRatio;
    }

    public void setFavorableRatio(String favorableRatio) {
        this.favorableRatio = favorableRatio;
    }

    public String getCarMessage() {
        return carMessage;
    }

    public void setCarMessage(String carMessage) {
        this.carMessage = carMessage;
    }

    public String getCarPicture() {
        return carPicture;
    }

    public void setCarPicture(String carPicture) {
        this.carPicture = carPicture;
    }

    public String getCarLevel() {
        return carLevel;
    }

    public void setCarLevel(String carLevel) {
        this.carLevel = carLevel;
    }

    public String getCarFuel() {
        return carFuel;
    }

    public void setCarFuel(String carFuel) {
        this.carFuel = carFuel;
    }

    public String getCarFree() {
        return carFree;
    }

    public void setCarFree(String carFree) {
        this.carFree = carFree;
    }

    public String getCarRentdays() {
        return carRentdays;
    }

    public void setCarRentdays(String carRentdays) {
        this.carRentdays = carRentdays;
    }

    public String getStartDate() {
        return startDate;
    }

    public void setStartDate(String startDate) {
        this.startDate = startDate;
    }

    public String getIsShow() {
        return isShow;
    }

    public void setIsShow(String isShow) {
        this.isShow = isShow;
    }
}
