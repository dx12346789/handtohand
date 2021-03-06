package com.qst.grade.action.admin;

import com.qst.grade.po.Order;
import com.qst.grade.po.OrderDetail;
import com.qst.grade.service.OrderDetailService;
import net.sf.json.JSONObject;
import org.aspectj.weaver.ast.Or;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.Date;
import java.util.List;

public class VolumeAction {
    private OrderDetailService orderDetailService;
    private JSONObject jsonObject;

    @Autowired
    public VolumeAction(OrderDetailService orderDetailService) {
        this.orderDetailService = orderDetailService;
    }

    /**
     * 成交量统计
     * @return
     */
    public String toVolume(){
        List<OrderDetail> orderDetails = orderDetailService.findAll();
        jsonObject = new JSONObject();
        jsonObject.put("status","200");
        jsonObject.put("msg","OK");
        JSONObject localJSONObject = new JSONObject();

        Date nowDate = new Date();
        int[] contentCount = new int[10];
        for (OrderDetail orderDetail:orderDetails){
            Order order = orderDetailService.findorderByoid(orderDetail.getOid());
            if(order.getStatus() != 0 && order.getPayTime() != null){
                int day = (int) ((nowDate.getTime() - order.getPayTime().getTime()) / (1000 * 60 * 60 * 24));
                if (day < 10) {
                    contentCount[9 - day]++;
                }
            }
        }
        String title = "[";
        for (int x = 5; x < 17; x++) {
            title += x + ",";
        }
        title =  title.substring(0, title.length() - 1) + "]";
        String content = "[";
        for (int i:contentCount){
            content += i + ",";
        }
        content =  content.substring(0, content.length() - 1) + "]";
        localJSONObject.put("title", title);
        localJSONObject.put("content", content);
        jsonObject.put("data",localJSONObject);
        return "success";
    }

    public JSONObject getJsonObject() {
        return jsonObject;
    }

    public void setJsonObject(JSONObject jsonObject) {
        this.jsonObject = jsonObject;
    }
}
