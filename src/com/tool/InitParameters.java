package com.tool;

/**
 * Created by lw on 14-3-22.
 * 系统初始化参数
 */
public class InitParameters {

    // 增加在用户没有登录下放行的url请求
    public static String[] NOT_FILTER = {"login.admin.do", "welcome.admin.do", "loginout.admin.do"};

    public final static String PROPERTIES_PATH = "/car.properties";

    public final static String projectName = "太原慕达汽车租赁公司";//项目名称配置

    public final static String COMPANYNAME = "太原慕达网络公司";//项目名称配置

    public final static String PROJECTBYNAME = "王子慧，太原理工大学";//项目管理员及联系方式

    public final static String SELECT_SIZE_FOR_FUNCTION = "10";//权限列表下拉框默认显示大小配置

    public final static String UPLOAD_PATH = "/upload/";//配置车辆类别图片的2级父目录，1级父目录为类别name文件夹，每个车辆类别的图片名称为自己类别的name

    public final static String FILE_SEPARATOR = System.getProperties().getProperty("file.separator");//文件分隔符

    public final static String[] IMGAGEFILENAME = {"png", "jpg", "gjf"};//系统支持 的图片格式

    public final static String[] COLORS = {"#FFF68F", "#FFC1C1", "#FFC125", "#FF7F24", "#FF0000", "#FF00FF", "#EEEE00", "#EEC900", "#EEB422", "#E066FF", "#DAA520", "#D2691E", "#CDCD00", "#CD8500", "#CD5B45", "#C0FF3E", "#BC8F8F", "#ADFF2F", "#A52A2A", "#A020F0", "#8E388E", "#76EE00", "#1874CD", "#00CD00", "#00868B", "#0000FF"};


    public String a() {
        return getClass().getResource("#").getFile().toString();
    }

}
