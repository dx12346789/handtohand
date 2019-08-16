package com.qst.grade.action;

import com.qst.grade.po.Notic;
import com.qst.grade.po.User;
import com.qst.grade.service.NoticService;
import com.qst.grade.service.UserService;
import com.qst.grade.util.UUID;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import java.util.Date;
import java.util.List;

@Controller
public class NoticAction {

    private NoticService noticService;
    private UserService userService;

    private Notic notic;
    private List<Notic> notics;
    private JSONObject jsonObject;
    private String nid;

    @Autowired
    public NoticAction(NoticService noticService, UserService userService) {
        this.noticService = noticService;
        this.userService = userService;
    }

    public String addReport() {
        System.out.println(notic);
        notic.setNid("N" + UUID.getUUID(32));
        notic.setCreateTime(new Date());
        notic.setTitle("举报");
        noticService.addNotic(notic);
        return "success";
    }

    public String delReport() {
        System.out.println("删除" + nid);
        noticService.updateStatus(1,nid);
        return "success";
    }

    public String updateStatus(){
        System.out.println("更新状态" + nid);
        noticService.updateStatus(2,nid);
        return "success";
    }

    public String findAll() {
        notics = noticService.findAll();
        jsonObject = new JSONObject();
        jsonObject.put("status", "200");
        jsonObject.put("msg", "OK");
        JSONArray jsonArray = new JSONArray();
        for (Notic notic : notics) {
            JSONObject localJSONObject = new JSONObject();
            localJSONObject.put("nid", notic.getNid());
            localJSONObject.put("title", notic.getTitle());
            localJSONObject.put("content", notic.getContent());
            localJSONObject.put("date", notic.getCreateTime().toString());
            User user = userService.findByuId(notic.getSender());
            localJSONObject.put("sender", user.getNickname());

            user = userService.findByuId(notic.getRecipient());
            localJSONObject.put("recipient", user.getNickname());

            localJSONObject.put("status", notic.getStatus());
            jsonArray.add(localJSONObject);
        }
        jsonObject.put("data", jsonArray);
        return "success";
    }


    public Notic getNotic() {
        return notic;
    }

    public void setNotic(Notic notic) {
        this.notic = notic;
    }

    public JSONObject getJsonObject() {
        return jsonObject;
    }

    public void setJsonObject(JSONObject jsonObject) {
        this.jsonObject = jsonObject;
    }

    public List<Notic> getNotics() {
        return notics;
    }

    public void setNotics(List<Notic> notics) {
        this.notics = notics;
    }

    public String getNid() {
        return nid;
    }

    public void setNid(String nid) {
        this.nid = nid;
    }
}
