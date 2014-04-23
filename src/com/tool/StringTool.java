package com.tool;

import org.joda.time.DateTime;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.io.PrintWriter;

/**
 * Created by lw on 14-3-21.
 */
public class StringTool {

    /**
     * 判断字符串是否为空null，""，"null"都认为是空
     *
     * @param str
     * @return
     */
    public static boolean isNullString(String str) {

        if (str == null || str.equals("") || str.equals("null")) {
            return true;
        }
        return false;
    }

    /**
     * 判断字符串是否不为空null，""，"null"都认为是空
     *
     * @param str
     * @return
     */
    public static boolean isNotNullString(String str) {

        return !(str == null || str.equals("") || str.equals("null"));
    }

    /**
     * 判断是否含有非法字符
     *
     * @param str
     * @return
     */
    public static boolean isHavaIllegalityString(String str) {
        str = str.toLowerCase();
        return str.indexOf(",") != -1 || str.indexOf("drop") != -1 || str.indexOf("update") != -1 || str.indexOf("delete") != -1 || str.indexOf("or") != -1 || str.indexOf("'") != -1;
    }

    /**
     * 判断是否含有非法字符,如果含有则全部为空
     *
     * @param strs
     * @return
     */
    public static boolean replaceIllegalityString(String... strs) {
        String str;
        for (String str1 : strs) {
            str = str1.toLowerCase();
            if (isHavaIllegalityString(str)) {
                return false;
            }
        }
        return true;
    }

    /**
     * JSON格式输出到页面
     *
     * @param text
     * @param response
     */
    public static void writeByAction(String text, HttpServletResponse response) {
        response.setContentType("text/plain;charset=UTF-8");
        response.setHeader("Cache-Control", "no-cache");
        PrintWriter pw;
        try {
            pw = response.getWriter();
            pw.write(text);
            pw.close();
        } catch (IOException e) {
            e.printStackTrace();
        }
    }


    /**
     * 查询一星期内、一月内、半年内的日期。
     *
     * @param search
     * @param dateFormat 数据格式 例如 yyyy-MM-dd hh:mi:ss
     * @return 返回格式为 查询开始日期-结束日期。逗号拼接
     */
    public static String getTimeDate(String search, String dateFormat) {

        //空串为显示全部
        if (StringTool.isNullString(search)) {
            return "";
        }
        DateTime dateTime = new DateTime();

        String endDate = dateTime.toString(dateFormat);
        //查看一星期内留言
        if (search.equals(FunctionName.oneweek.toString())) {
            dateTime = dateTime.plusDays(-7);
            // 查看一个月内留言
        } else if (search.equals(FunctionName.onemonth.toString())) {
            dateTime = dateTime.plusMonths(-1);
            //查看三个月内
        } else if (search.equals(FunctionName.threemonth.toString())) {
            dateTime = dateTime.plusMonths(-3);
            //查看近半年内留言
        } else if (search.equals(FunctionName.halfyear.toString())) {
            dateTime = dateTime.plusDays(-183);
            //全部
        } else {
            return "";
        }

        StringBuffer stringBuffer = new StringBuffer(dateTime.toString(dateFormat));
        stringBuffer.append(",").append(endDate);

        return stringBuffer.toString();
    }

    /**
     * 验证是否是系统接受的 图片格式类型
     *
     * @param fileName
     * @return
     */
    public static boolean isValidFileName(String fileName) {
        fileName = fileName.toLowerCase();
        String[] validFileNames = InitParameters.IMGAGEFILENAME;
        for (String str : validFileNames) {
            if (fileName.equals(str)) {
                return true;
            }
        }

        return false;
    }

    /**
     * 将字符串不足 size 位数下以空格补齐
     *
     * @param str  原始串
     * @param size 最大值
     * @return
     */
    public static String getStringForImage(String str, int size) {

        if (isNullString(str)) {
            return "";
        }
        if (str.length() > size) {
            return str.substring(0, size);
        }
        for (int i = 0, n = size - str.length(); i < n; i++) {
            str += "  ";
        }
        return str;
    }

    /**
     * 获取一个随机的颜色
     *
     * @return
     */
    public static String getRandomColor() {
        int i = InitParameters.COLORS.length;
        int temp = (int) (Math.random() * i);
        return InitParameters.COLORS[temp];
    }

    /**
     * 获取 IP
     *
     * @param request
     * @return
     */
    public static String getIpAddr(HttpServletRequest request) {
        String ip = request.getHeader("x-forwarded-for");
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("Proxy-Client-IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getHeader("WL-Proxy-Client-IP");
        }
        if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
            ip = request.getRemoteAddr();
        }
        return ip;
    }

}
