package com.qst.grade.action;

import com.alipay.api.AlipayApiException;
import com.alipay.api.internal.util.AlipaySignature;
import com.opensymphony.xwork2.ActionContext;
import com.qst.grade.alipay.config.AlipayConfig;
import com.qst.grade.po.User;
import com.qst.grade.service.OrderService;
import net.sf.json.JSONObject;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import javax.servlet.http.HttpServletRequest;
import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

@Controller
public class OrderAction {

    private JSONObject data;
    private String oid;
    private double totalPrice;
    private String aid;
    private String pid;
    private String subject;
    private String body;
    private String[] sid;
    private String[] gid;

    private final OrderService orderService;

    @Autowired
    public OrderAction(OrderService orderService) {
        this.orderService = orderService;
    }

    public String toOrder(){
        return "order";
    }

    public String createOrder(){
        System.out.println(aid);
        Map m = ActionContext.getContext().getSession();
        User user = (User) m.get("loginUser");
        oid = orderService.createOrder(gid, sid, user, aid, totalPrice);
        System.out.println(gid);
        System.out.println(sid);
        System.out.println(aid);
        System.out.println(totalPrice);
        return "payment";
    }

    public String payment(){
        System.out.println(totalPrice);
        System.out.println(oid);
        subject = "商品购买";
        body = "商品描述";
        System.out.println(subject);
        System.out.println(body);
        Map m = ActionContext.getContext().getSession();
        User u = (User) m.get("loginUser");
        System.out.println(u);
        return "topay";
    }

    public String paySuccess(){
        HttpServletRequest request = ServletActionContext.getRequest();
        System.out.println(oid);

        if (oid == null){
            oid = request.getParameter("out_trade_no");
        }
        String pid = request.getParameter("trade_no");
        Map m = ActionContext.getContext().getSession();
        User u = (User) m.get("loginUser");
        int number = orderService.paySuccess(oid, pid, u);
        u.setGold(u.getGold() + number);
        System.out.println(u);
        return "toCart";
    }

    public String returnUrl(){
        Map m = ActionContext.getContext().getSession();
        User u = (User) m.get("loginUser");
        System.out.println(u);

        //获取支付宝GET过来反馈信息
        HttpServletRequest request = ServletActionContext.getRequest();
        PrintWriter out = null;
        try {
            out = ServletActionContext.getResponse().getWriter();
        } catch (IOException e) {
            e.printStackTrace();
        }
        Map<String,String> params = new HashMap<String,String>();
        Map<String,String[]> requestParams = request.getParameterMap();
        for (Iterator<String> iter = requestParams.keySet().iterator(); iter.hasNext();) {
            String name = (String) iter.next();
            String[] values = (String[]) requestParams.get(name);
            String valueStr = "";
            for (int i = 0; i < values.length; i++) {
                valueStr = (i == values.length - 1) ? valueStr + values[i]
                        : valueStr + values[i] + ",";
            }
            //乱码解决，这段代码在出现乱码时使用
            try {
                valueStr = new String(valueStr.getBytes("ISO-8859-1"), "utf-8");
            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
            }
            params.put(name, valueStr);
        }

        boolean signVerified = false; //调用SDK验证签名
        try {
            signVerified = AlipaySignature.rsaCheckV1(params, AlipayConfig.alipay_public_key, AlipayConfig.charset, AlipayConfig.sign_type);
        } catch (AlipayApiException e) {
            e.printStackTrace();
        }

        //——请在这里编写您的程序（以下代码仅作参考）——
        if(signVerified) {
            //商户订单号
            try {
                oid = new String(request.getParameter("out_trade_no").getBytes("ISO-8859-1"),"UTF-8");
            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
            }

            //支付宝交易号
            try {
                pid = new String(request.getParameter("trade_no").getBytes("ISO-8859-1"),"UTF-8");
            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
            }

            //付款金额
            String total_amount = null;
            try {
                total_amount = new String(request.getParameter("total_amount").getBytes("ISO-8859-1"),"UTF-8");
            } catch (UnsupportedEncodingException e) {
                e.printStackTrace();
            }

            out.println("trade_no:"+pid+"<br/>out_trade_no:"+oid+"<br/>total_amount:"+total_amount);
            return "success";

        }else {
            out.println("验签失败");
        }
        return "error";
    }

    public JSONObject getData() {
        return data;
    }

    public void setData(JSONObject data) {
        this.data = data;
    }

    public String getOid() {
        return oid;
    }

    public void setOid(String oid) {
        this.oid = oid;
    }

    public double getTotalPrice() {
        return totalPrice;
    }

    public void setTotalPrice(double totalPrice) {
        this.totalPrice = totalPrice;
    }

    public String[] getSid() {
        return sid;
    }

    public void setSid(String[] sid) {
        this.sid = sid;
    }


    public String[] getGid() {
        return gid;
    }

    public void setGid(String[] gid) {
        this.gid = gid;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public String getBody() {
        return body;
    }

    public void setBody(String body) {
        this.body = body;
    }

    public String getPid() {
        return pid;
    }

    public void setPid(String pid) {
        this.pid = pid;
    }

    public String getAid() {
        return aid;
    }

    public void setAid(String aid) {
        this.aid = aid;
    }
}
