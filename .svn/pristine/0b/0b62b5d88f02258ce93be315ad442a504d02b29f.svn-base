package com.qst.grade.action.admin;

import com.opensymphony.xwork2.ActionContext;
import com.qst.grade.po.Goods;
import com.qst.grade.service.GoodsService;
import com.qst.grade.service.IndexService;
import com.qst.grade.service.OrderDetailService;
import com.qst.grade.service.UserService;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.List;
import java.util.Map;

public class AdminIndexAction {

    private UserService userService;
    private GoodsService goodsService;
    private OrderDetailService orderDetailService;
    private List<Goods> goods;

    @Autowired
    public AdminIndexAction(UserService userService, GoodsService goodsService, OrderDetailService orderDetailService) {
        this.userService = userService;
        this.goodsService = goodsService;
        this.orderDetailService = orderDetailService;
    }

    private JSONObject jsonObject;

    public String toAdminIndex() {
        jsonObject = new JSONObject();

        Map application = ActionContext.getContext().getApplication();
        Map loginUsers = (Map) application.get("loginUsers");
        JSONObject localJSONObject = new JSONObject();

        localJSONObject.put("volume", orderDetailService.findAll().size());
        localJSONObject.put("online", loginUsers.size());
        localJSONObject.put("registerNumber", userService.findAllByCount());

        jsonObject.put("status", "200");
        jsonObject.put("msg", "OK");
        jsonObject.put("data", localJSONObject);
        return "success";
    }

    public String getHitGoods() {
        goods = goodsService.findAllByHit(0, 10);
        return "success";
    }

    public JSONObject getJsonObject() {
        return jsonObject;
    }

    public void setJsonObject(JSONObject jsonObject) {
        this.jsonObject = jsonObject;
    }


    public List<Goods> getGoods() {
        return goods;
    }

    public void setGoods(List<Goods> goods) {
        this.goods = goods;
    }
}
