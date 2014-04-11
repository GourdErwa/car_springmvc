package com.bean;

/**
 * Created by lw on 14-3-21.
 * 留言信息bean
 */
public class LeaveMessage {

    private String id;//编号
    private String ip;//留言人ip
    private String address;//留言模糊地址
    private String messageDate;//留言日期
    private String messages;//留言内容
    private String isShow;//是否读取过


    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getIp() {
        return ip;
    }

    public void setIp(String ip) {
        this.ip = ip;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getMessageDate() {
        return messageDate;
    }

    public void setMessageDate(String messageDate) {
        this.messageDate = messageDate;
    }

    public String getMessages() {
        return messages;
    }

    public void setMessages(String messages) {
        this.messages = messages;
    }

    public String getIsShow() {
        return isShow;
    }

    public void setIsShow(String isShow) {
        this.isShow = isShow;
    }
}
