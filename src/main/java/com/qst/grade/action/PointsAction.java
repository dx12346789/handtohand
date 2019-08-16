package com.qst.grade.action;

import com.qst.grade.po.Point;
import com.qst.grade.service.PointService;
import net.sf.json.JSONObject;
import org.dom4j.DocumentException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import java.io.IOException;
import java.util.List;


@Controller
public class PointsAction {
    private List<Point> points;
    private Point point;
    private PointService pointService;
    private JSONObject jsonObject;
    private String delid;
    @Autowired
    public PointsAction(PointService pointService) {
        this.pointService = pointService;
    }

    public String showpoints() throws DocumentException {
        points = pointService.findAll();
        System.out.println(points.size());
        return "success";
    }

    public String addpoint() throws IOException, DocumentException {
        jsonObject = new JSONObject();
        System.out.println("测试" + point);
        String pid=pointService.addPoint(point);
        if (pid!="0") {
            jsonObject.put("status", "200");
            jsonObject.put("msg", "保存成功");
            jsonObject.put("data",pid);
        } else {
            jsonObject.put("status", "400");
            jsonObject.put("msg", "操作失败");
            jsonObject.put("data", "-1");
        }
        System.out.println(jsonObject);
        return "success";
    }
    public String updatepoint() throws IOException, DocumentException {
        System.out.println("修改"+point);
        jsonObject=new JSONObject();
        if( pointService.updatePoint(point))
        {
            System.out.println("修改成功");
            jsonObject.put("status", "201");
            jsonObject.put("msg", "ok");
            jsonObject.put("data", "修改成功");
        }else{
            System.out.println("修改失败");
            jsonObject.put("status", "400");
            jsonObject.put("msg", "ok");
            jsonObject.put("data", "操作失败");
        }
        return "success";
    }
    public String delpoint() throws IOException, DocumentException {
        System.out.println("删除"+delid);
        jsonObject = new JSONObject();
        if(pointService.delPoint(delid)){
            System.out.println("删除成功");
            jsonObject.put("status","200");
            jsonObject.put("msg","删除成功");
        }else{
            System.out.println("删除失败");
            jsonObject.put("status","400");
            jsonObject.put("msg","删除失败");
        }


        return "success";
    }

    public String getDelid() {
        return delid;
    }

    public void setDelid(String delid) {
        this.delid = delid;
    }

    public JSONObject getJsonObject() {
        return jsonObject;
    }

    public void setJsonObject(JSONObject jsonObject) {
        this.jsonObject = jsonObject;
    }

    public List<Point> getPoints() {
        return points;
    }

    public void setPoints(List<Point> points) {
        this.points = points;
    }

    public Point getPoint() {
        return point;
    }

    public void setPoint(Point point) {
        this.point = point;
    }
}
