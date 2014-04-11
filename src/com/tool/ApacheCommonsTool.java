package com.tool;

import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.List;
import java.util.Properties;
import java.util.UUID;

/**
 * Created by lw on 14-3-22.
 */
public class ApacheCommonsTool {


    /**
     * 读取配置文件
     *
     * @param key
     * @return
     */
    public static String getProperties(String key) {


        String returnValue = null;
        InputStream fin = null;
        Properties p;
        try {
            fin = ApacheCommonsTool.class.getResourceAsStream(InitParameters.PROPERTIES_PATH);
            p = new Properties();
            p.load(fin);
            // 解决中文乱码
            returnValue = new String(p.getProperty(key));
            returnValue = new String(returnValue.getBytes("utf-8"), "gbk");

        } catch (Exception ee) {
            ee.printStackTrace();
        } finally {
            if (fin != null) {
                try {
                    fin.close();
                } catch (IOException ioe) {
                    ioe.printStackTrace();
                }
            }
        }
        return returnValue;
    }

    /**
     * 批量上传
     *
     * @param multipartFileList 文件集
     * @param uploadPath        上传路径
     * @return
     */
    public static boolean uploadFiles(List<MultipartFile> multipartFileList, String uploadPath) {

        File filePath = new File(uploadPath);
        if (!filePath.exists()) {
            filePath.mkdirs();
        }
        FileOutputStream fileOutputStream;
        MultipartFile multipartFile;
        for (int i = 0; i < multipartFileList.size(); i++) {
            multipartFile = multipartFileList.get(i);

            if (!multipartFile.isEmpty()) {
                String originalFilename = multipartFile.getOriginalFilename();
                String a = originalFilename.split("\\.")[1];

                File files = new File(uploadPath + UUID.randomUUID().toString() + "." + a); // 新建一个文件

                try {
                    fileOutputStream = new FileOutputStream(files);
                    fileOutputStream.write(multipartFile.getBytes());
                    fileOutputStream.flush();
                } catch (Exception e) {
                    e.printStackTrace();
                    return false;
                }
                if (fileOutputStream != null) { // 关闭流
                    try {
                        fileOutputStream.close();
                    } catch (Exception ie) {

                        ie.printStackTrace();
                        return false;
                    }
                }
            }
        }
        return true;
    }

    /**
     * 单个文件上传
     *
     * @param multipartFile 单个文件
     * @param uploadPath    上传目录
     * @param fileName      文件名
     * @return
     */
    public static boolean uploadFile(MultipartFile multipartFile, String uploadPath, String fileName) {

        File filePath = new File(uploadPath);
        if (!filePath.exists()) {
            filePath.mkdirs();
        }
        FileOutputStream fileOutputStream = null;

        if (!multipartFile.isEmpty()) {

            File files = new File(uploadPath + InitParameters.FILE_SEPARATOR + fileName); // 新建一个文件

            try {
                fileOutputStream = new FileOutputStream(files);
                fileOutputStream.write(multipartFile.getBytes());
                fileOutputStream.flush();
            } catch (Exception e) {
                e.printStackTrace();
                return false;
            }
            if (fileOutputStream != null) { // 关闭流
                try {
                    fileOutputStream.close();
                } catch (Exception ie) {

                    ie.printStackTrace();
                    return false;
                }
            }
        }
        return true;
    }

}
