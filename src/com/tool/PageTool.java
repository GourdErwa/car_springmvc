package com.tool;


import java.util.List;

/**
 * Created by lw on 14-3-21.
 * 分页工具类，仿【百度一下】后的分页效果。
 */
public class PageTool {

    public int pageShowSize = 10;//每页显示数量

    public int thisPage;//要显示的页
    private int pageSize;//页面总数
    public List pageBody;//返回的页面内容
    public int startSize;//分页sql使用的数据起始查询值
    public int endSize;//分页sql使用的数据结束查询值
    public String pageToolStr;//分页工具条串，返回后台后直接append到div即可
    public String pageMethodName;//调用分页的方法名字，解决一个页面中多个方法含有分页查询，拼接分页工具条时需要确定

    public PageTool() {
    }


    /**
     * 初始化 分页bean
     *
     * @param bodySize
     * @param pageShowSize
     * @param pageMethodName
     * @param thisPage
     * @return
     */
    public static PageTool getPageTool(int bodySize, int pageShowSize, String pageMethodName, int thisPage) {

        PageTool pageTool = new PageTool();

        pageTool.pageShowSize=pageShowSize;

        int temp = bodySize / pageShowSize;

        pageTool.pageSize = (bodySize % pageShowSize == 0) ? temp : temp+1;

        pageTool.pageMethodName = pageMethodName;

        pageTool.thisPage = thisPage;

        pageTool.startSize = (thisPage - 1) * pageShowSize;

        pageTool.endSize = thisPage * pageShowSize;

        pageTool.pageToolStr = setPageToolStr(thisPage, pageTool.pageSize, pageTool.pageMethodName);

        return pageTool;
    }


    /**
     * 拼接分页工具条
     *
     * @param thisPage       当前显示页
     * @param pageSize       页面大小
     * @param pageMethodName 调用分页的方法名称
     * @return 分页工具条html
     */
    private static String setPageToolStr(int thisPage, int pageSize, String pageMethodName) {

        if (pageSize <= 1) {
            return "";
        }

        StringBuilder str = new StringBuilder("<ul class=\"pagination\"><li >");

        //是否是首页
        if (thisPage == 1) {
            str.append("<li class=\"disabled\"><a> &laquo;</a></li>");
        } else {
            str.append("<li ><a  style=\"cursor:pointer\" onclick=\"").append(pageMethodName).append("(1);\"> &laquo;</a></li>");
        }

        //如果是前10页，则都显示，如果总页数《=12 ，则最大数为总页数，否则默认显示12页。为了用户点到第10页可以看到后面的页数
        if (thisPage <= 10) {
            int n = (pageSize <= 12) ? pageSize : 12;
            for (int i = 1; i <= n; i++) {
                if (i == thisPage) {
                    str.append("<li class=\"active\"><a>").append(i).append("</a></li>");
                } else {
                    str.append("<li ><a style=\"cursor:pointer\" onclick=\"").append(pageMethodName).append("(").append(i).append(");\">").append(i).append("</a></li>");
                }
            }
            //如果是最后7页，追加显示当前页的前5页
        } else if (pageSize - thisPage < 7) {
            for (int i = thisPage - 5; i <= pageSize; i++) {
                if (i == thisPage) {
                    str.append("<li class=\"active\"><a>").append(i).append("</a></li>");
                } else {
                    str.append("<li ><a style=\"cursor:pointer\" onclick=\"").append(pageMethodName).append("(").append(i).append(");\">").append(i).append("</a></li>");
                }
            }
        } else {
            //如果是中间页，则当前页居中，每页显示11个页数（右边追加的页数必须小于 判断显示最后页时的页数，如上述if中的最后7页）
            for (int i = thisPage - 5, n = thisPage + 6; i < n; i++) {
                if (i == thisPage) {
                    str.append("<li class=\"active\"><a>").append(i).append("</a></li>");
                } else {
                    str.append("<li ><a style=\"cursor:pointer\" onclick=\"").append(pageMethodName).append("(").append(i).append(");\">").append(i).append("</a></li>");
                }
            }
        }
        //是否是尾页
        if (thisPage == pageSize) {
            str.append("<li class=\"disabled\"><a> &raquo;</a></li></ul>");
        } else {
            str.append("<li ><a  style=\"cursor:pointer\" onclick=\"").append(pageMethodName).append("(").append(pageSize).append(");\"> &raquo;</a></li></ul>");
        }

        return str.toString();
    }

}
