package com.qst.grade.util;

import com.sun.image.codec.jpeg.JPEGCodec;
import com.sun.image.codec.jpeg.JPEGImageEncoder;

import java.awt.*;
import java.awt.image.BufferedImage;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;
import java.util.HashMap;
import java.util.Map;
import java.util.Random;

public class Validate {
    //干扰线数
    private static final int INTERFERINGLINENM = 4;
    //字体大小
    private static final int FONTSIZE = 25;

    //图片宽
    private static final int WIDTH = 90;
    //图片高
    private static final int HEIGHT = 30;

    /**
     * 获取随机验证码
     *
     * @return
     */
    public static Map<String, Object> createImage() {

        BufferedImage image = new BufferedImage(WIDTH, HEIGHT, BufferedImage.TYPE_INT_RGB);
        Graphics g = image.getGraphics();
        Random r = new Random();
        //设置背景颜色
        g.setColor(new Color(r.nextInt(255), r.nextInt(255), r.nextInt(255)));
        //画矩形
        g.fillRect(0, 0, WIDTH, HEIGHT);
        //获取随机验证码
        String number = null;

        int one = r.nextInt(20);
        int two = r.nextInt(20);
        int sum = 0;
        switch (r.nextInt(2)) {
            case 0:
                number = one + "+" + two;
                sum = one + two;
                break;
            case 1:
                number = one + "-" + two;
                sum = one - two;
                break;
            case 2:
                number = one + "*" + two;
                sum = one * two;
                break;
            case 3:
                number = one + "/" + two;
                sum = one / two;
                break;

        }


        //设置随机背景色
        g.setColor(new Color(r.nextInt(255), r.nextInt(255), r.nextInt(255)));
        //设置字体
        g.setFont(new Font("", Font.BOLD + Font.ITALIC, FONTSIZE));
        //将验证码转换为图片显示在(x,y)坐标上
        g.drawString(number, 5, 25);
        //画干扰线
        for (int i = 0; i < INTERFERINGLINENM; i++) {
            g.setColor(new Color(r.nextInt(255), r.nextInt(255), r.nextInt(255)));
            g.drawLine(r.nextInt(100), r.nextInt(40), r.nextInt(100),
                    r.nextInt(40));
        }

        Map<String, Object> map = new HashMap<String, Object>();
        map.put("code", number);
        map.put("result", "" + sum);
        map.put("image", image);
        return map;
    }

    /**
     * 获取图片输入流
     *
     * @param image
     * @return
     * @throws Exception
     */
    public static InputStream getInputStream(BufferedImage image)
            throws Exception {
        ByteArrayOutputStream bos = new ByteArrayOutputStream();
        JPEGImageEncoder en = JPEGCodec.createJPEGEncoder(bos);
        en.encode(image);
        byte[] bts = bos.toByteArray();
        ByteArrayInputStream bis = new ByteArrayInputStream(bts);
        return bis;
    }

    /**
     * 获取指定长度的字符
     *
     * @param n
     * @return
     */
    private static String getString(int n) {
        String str = "1234567890qwertyuioplkjhgfdsazxcvbnmQWERTYUIOPASDFGHJKLZXCVBNM";
        Random r = new Random();
        String ss = "";
        for (int i = 0; i < n; i++) {
            char c = str.charAt(r.nextInt(str.length()));
            ss = ss + c;
        }
        return ss;
    }
}