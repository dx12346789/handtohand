package com.qst.grade.action;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionSupport;
import com.qst.grade.po.*;
import com.qst.grade.service.CommentService;
import com.qst.grade.service.OrderDetailService;
import com.qst.grade.service.OrderService;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;

import java.math.BigDecimal;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.Map;

public class OrderListAction extends ActionSupport {
    private OrderDetailService orderDetailService;
    private CommentService commentService;

    private List<OrderDetail> payerlist;
    private List<OrderDetail> sellerlist;
    private List<Goods> goodslist;
    private List<Order> orderlist;
    private List<User> userlist;
    private JSONObject jsonObject;
    private String orderid;
    private String sendnum;

    @Autowired
    public OrderListAction(OrderDetailService orderDetailService,CommentService commentService) {
        this.orderDetailService = orderDetailService;
        this.commentService = commentService;
    }


    public String orderlistbuyer() {
        jsonObject = new JSONObject();
        Map session = ActionContext.getContext().getSession();
        User user = (User) session.get("loginUser");
        payerlist = orderDetailService.findOrdersBypayer(user.getUid());

        JSONArray jsonArray = new JSONArray();
        for (OrderDetail orderDetail : payerlist)
        /*for (int i = 0; i < payerlist.size(); i++)*/ {
            Goods goods = new Goods();
            goods = orderDetailService.findGoodsBygid(orderDetail.getGid());
            Order order = new Order();
            order = orderDetailService.findorderByoid(orderDetail.getOid());
            User seller = new User();
            seller = orderDetailService.findUsersByuid(orderDetail.getSeller());
/*            OrderDetail orderDetail = payerlist.get(i);*/
            Comment comment= commentService.findByOid(orderDetail.getoDid());

            JSONObject localJSONObject = new JSONObject();
            localJSONObject.put("orderid", orderDetail.getoDid());
            localJSONObject.put("sellerid", orderDetail.getSeller());

            localJSONObject.put("goodsgid", goods.getGid());
            localJSONObject.put("goodsimg", goods.getImgPath().split(",")[0]);
            localJSONObject.put("goodsname", goods.getName());
            localJSONObject.put("goodscount", orderDetail.getCount());
            localJSONObject.put("goodspricetotal", (orderDetail.getCount() * goods.getPrice()));
            localJSONObject.put("orderstatus", orderDetail.getStatus());
            localJSONObject.put("seller", user.getNickname());
            localJSONObject.put("ordernum", order.getOid());
            localJSONObject.put("paynum", order.getPid());
            if(comment != null){
                localJSONObject.put("comment",comment.getContent());
            }else {
                localJSONObject.put("comment","");
            }

            jsonArray.add(localJSONObject);
            System.out.println(localJSONObject);
        }
        jsonObject.put("status", "200");
        jsonObject.put("msg", "OK");
        jsonObject.put("data", jsonArray);
        return "success";
    }

    public String orderlistseller() {
        jsonObject = new JSONObject();
        Map session = ActionContext.getContext().getSession();
        User user = (User) session.get("loginUser");
        sellerlist = orderDetailService.findOrdersByseller(user.getUid());

        JSONArray jsonArray = new JSONArray();
        for (int i = 0; i < sellerlist.size(); i++) {
            Goods goods = new Goods();
            goods = orderDetailService.findGoodsBygid(sellerlist.get(i).getGid());
            Order order = new Order();
            order = orderDetailService.findorderByoid(sellerlist.get(i).getOid());
            User seller = new User();
            seller = orderDetailService.findUsersByuid(sellerlist.get(i).getBuyyer());
            OrderDetail orderDetail = sellerlist.get(i);
            JSONObject localJSONObject = new JSONObject();
            localJSONObject.put("orderid", orderDetail.getoDid());
            localJSONObject.put("buyerid", orderDetail.getBuyyer());
            localJSONObject.put("goodsgid", goods.getGid());
            localJSONObject.put("goodsimg", goods.getImgPath().split(",")[0]);
            localJSONObject.put("goodsname", goods.getName());
            localJSONObject.put("goodscount", orderDetail.getCount());
            localJSONObject.put("goodspricetotal", (orderDetail.getCount() * goods.getPrice()));
            localJSONObject.put("orderstatus", orderDetail.getStatus());
            localJSONObject.put("buyer", user.getNickname());
            localJSONObject.put("ordernum", order.getOid());
            localJSONObject.put("sellernum", order.getPid());
            jsonArray.add(localJSONObject);
            System.out.println(localJSONObject);

        }
        jsonObject.put("status", "200");
        jsonObject.put("msg", "OK");
        jsonObject.put("data", jsonArray);
        return "success";
    }

    public String delivery() {
        System.out.println("orderidyyyyyy" + orderid);
        OrderDetail orderDetail = new OrderDetail();
        orderDetail = orderDetailService.findByodid(orderid);
        orderDetail.setStatus(2);
        orderDetailService.updateorderDetail(orderDetail);
        return "success";

    }

    public String send() {
        System.out.println("物流号"+sendnum);
        System.out.println("订单号"+orderid);
        OrderDetail orderDetail=new OrderDetail();
        orderDetail=orderDetailService.findByodid(orderid);
        orderDetail.setStatus(1);
        orderDetailService.updateorderDetail(orderDetail);
        return "success";
    }

    public String getSendnum() {
        return sendnum;
    }

    public void setSendnum(String sendnum) {
        this.sendnum = sendnum;
    }

    public List<OrderDetail> getSellerlist() {
        return sellerlist;
    }

    public void setSellerlist(List<OrderDetail> sellerlist) {
        this.sellerlist = sellerlist;
    }

    public List<Goods> getGoodslist() {
        return goodslist;
    }

    public String getOrderid() {
        return orderid;
    }

    public void setOrderid(String orderid) {
        this.orderid = orderid;
    }

    public void setGoodslist(List<Goods> goodslist) {
        this.goodslist = goodslist;
    }

    public List<Order> getOrderlist() {
        return orderlist;
    }

    public void setOrderlist(List<Order> orderlist) {
        this.orderlist = orderlist;
    }

    public List<User> getUserlist() {
        return userlist;
    }

    public void setUserlist(List<User> userlist) {
        this.userlist = userlist;
    }

    public JSONObject getJsonObject() {
        return jsonObject;
    }

    public void setJsonObject(JSONObject jsonObject) {
        this.jsonObject = jsonObject;
    }

    public List<OrderDetail> getPayerlist() {
        return payerlist;
    }

    public void setPayerlist(List<OrderDetail> payerlist) {
        this.payerlist = payerlist;
    }
}
