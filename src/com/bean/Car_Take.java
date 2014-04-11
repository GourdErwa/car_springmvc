package com.bean;

/**
 * Created by LiWei on 14-3-29.
 * 出租登记bean
 */
public class Car_Take {
    private String carName;// 登记车名字
    private String category;// 登记车所属类别
    private String money;// 出租价格
    private String startTime;// 租用开始时间
    private String endTime;//  租用结束时间
    private String moreMessage;//  更多信息
    private String takeName;//  登记人姓名
    private String takeLicence;// 登记人身份证号码

    public String getCarName() {
        return carName;
    }

    public void setCarName(String carName) {
        this.carName = carName;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }

    public String getMoney() {
        return money;
    }

    public void setMoney(String money) {
        this.money = money;
    }

    public String getStartTime() {
        return startTime;
    }

    public void setStartTime(String startTime) {
        this.startTime = startTime;
    }

    public String getEndTime() {
        return endTime;
    }

    public void setEndTime(String endTime) {
        this.endTime = endTime;
    }

    public String getMoreMessage() {
        return moreMessage;
    }

    public void setMoreMessage(String moreMessage) {
        this.moreMessage = moreMessage;
    }

    public String getTakeName() {
        return takeName;
    }

    public void setTakeName(String takeName) {
        this.takeName = takeName;
    }

    public String getTakeLicence() {
        return takeLicence;
    }

    public void setTakeLicence(String takeLicence) {
        this.takeLicence = takeLicence;
    }
}
