package com.qst.grade.action.admin;


import com.qst.grade.po.User;
import com.qst.grade.service.UserService;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import java.io.*;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
public class ExcelAction {
    private UserService userService;

    private InputStream inputStream;

    @Autowired
    public ExcelAction(UserService userService) {
        this.userService = userService;
    }

    public String exportUser() {
        setInputStream(exportNetworkDeviceList("", "", "", "", ""));

        return "success";
    }

    public InputStream exportNetworkDeviceList(String netStatus,
                                               String netModelNumber, String netBuilding, String netFloor,
                                               String netLocation) {
        HSSFWorkbook wb = new HSSFWorkbook();
        // 第二步，在webbook中添加一个sheet,对应Excel文件中的sheet
        HSSFSheet sheet = wb.createSheet("用户信息表");
        // 第三步，在sheet中添加表头第0行,注意老版本poi对Excel的行数列数有限制short
        HSSFRow row = sheet.createRow((int) 0);
        // 第四步，创建单元格，并设置值表头 设置表头居中
        HSSFCellStyle style = wb.createCellStyle();


        //String[] headers = new String[]{"uid", "nickname", "mail", "telphone", "sex", "birthday", "gold", "status", "auth", "create_time", "latest_login_time"};

        HSSFCell cell = row.createCell(0);
        cell.setCellValue("uid");
        cell.setCellStyle(style);
        cell = row.createCell(1);
        cell.setCellValue("昵称");
        cell.setCellStyle(style);
        cell = row.createCell(2);
        cell.setCellValue("邮箱");
        cell.setCellStyle(style);
        cell = row.createCell(3);
        cell.setCellValue("手机号码");
        cell.setCellStyle(style);
        cell = row.createCell(4);
        cell.setCellValue("性别");
        cell.setCellStyle(style);
        cell = row.createCell(5);
        cell.setCellValue("生日");
        cell.setCellStyle(style);
        cell = row.createCell(6);
        cell.setCellValue("积分");
        cell.setCellStyle(style);
        cell = row.createCell(7);
        cell.setCellValue("权限");
        cell.setCellStyle(style);
        cell = row.createCell(8);
        cell.setCellValue("状态");
        cell.setCellStyle(style);
        cell = row.createCell(9);
        cell.setCellValue("注册时间");
        cell.setCellStyle(style);
        cell = row.createCell(10);
        cell.setCellValue("最后上线时间");
        cell.setCellStyle(style);


        // 第五步，写入实体数据 实际应用中这些数据从数据库得到，
        List<User> exportList = userService.findAll();
        for (int i = 0; i < exportList.size(); i++) {
            row = sheet.createRow((int) i + 1);
            User netDevice = exportList.get(i);
            // 第四步，创建单元格，并设置值
            row.createCell(0).setCellValue(netDevice.getUid());
            row.createCell(1).setCellValue(netDevice.getNickname()!= null ?  netDevice.getNickname() : "");
            row.createCell(2).setCellValue(netDevice.getMail()!= null ?  netDevice.getMail() : "");
            row.createCell(3).setCellValue(netDevice.getTelphone()!= null ?  netDevice.getTelphone() : "");
            int sex = netDevice.getSex();
            String sexStr = "";
            if (sex == 0) {
                sexStr = "女";
            } else if (sex == 1) {
                sexStr = "男";
            } else {
                sexStr = "未知";
            }

            row.createCell(4).setCellValue(sexStr);
            row.createCell(5).setCellValue(netDevice.getBirthday() != null ?  netDevice.getBirthday().toString() : "");
            row.createCell(6).setCellValue(netDevice.getGold());
            sex = netDevice.getAuth();
            if (sex == 0) {
                sexStr = "普通用户";
            } else if (sex == 1) {
                sexStr = "管理员";
            } else {
                sexStr = "超级管理员";
            }
            row.createCell(7).setCellValue(sexStr);
            sex = netDevice.getStatus();
            if (sex == 0) {
                sexStr = "正常";
            } else if (sex == 1) {
                sexStr = "删除";
            } else {
                sexStr = "冻结";
            }
            row.createCell(8).setCellValue(sexStr);
            row.createCell(9).setCellValue(netDevice.getCreateTime()!= null ?  netDevice.getCreateTime().toString() : "");
            row.createCell(10).setCellValue(netDevice.getLatestLoginTime()!= null ?  netDevice.getLatestLoginTime().toString() : "");

        }
        //自动设置EXCEL的列宽，视自己的需求而定，也可以用sheet.setDefaultColumnWidth(13);为全部列的列宽设置默认值
        sheet.autoSizeColumn((short) 0);
        sheet.autoSizeColumn((short) 2);
        sheet.autoSizeColumn((short) 6);
        sheet.autoSizeColumn((short) 7);
        sheet.autoSizeColumn((short) 8);
        sheet.autoSizeColumn((short) 9);
        sheet.autoSizeColumn((short) 10);


        String filePath = "";
        Date dt = new Date();
        DateFormat df = new SimpleDateFormat("yyyyMMddHHmmss");
        String date = df.format(dt).toString();
        filePath = "用户信息表.xls";
        File file = new File(filePath);
        try {
            OutputStream out = new FileOutputStream(file);
            wb.write(out);
            out.close();
        } catch (Exception e) {
            e.printStackTrace();
        }
        InputStream in = null;
        try {
            in = new FileInputStream(file);
        } catch (Exception e) {
            e.printStackTrace();
        }
        return in;
    }

    public InputStream getInputStream() {
        return inputStream;
    }

    public void setInputStream(InputStream inputStream) {
        this.inputStream = inputStream;
    }
}
