package com.qst.grade.util;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;

public class UtilDate {
    public static Date StringToDate(String sdate) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Date date = null;
        try {
            date = sdf.parse(sdate);
        } catch (ParseException e) {
            e.printStackTrace();
        }
        return date;
    }

    public static Long getDate(){
        return System.currentTimeMillis();
    }

    public static Date getNowDate() {
        Date date = new Date(System.currentTimeMillis());
        return date;
    }
}
