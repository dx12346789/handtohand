package com.qst.grade.action.admin;

import com.opensymphony.xwork2.ActionContext;
import com.qst.grade.po.User;
import net.sf.json.JSONObject;
import org.apache.struts2.ServletActionContext;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

public class OnlineAction {
    private List<User> users;
    private String uid;
    private JSONObject jsonObject;

    public String toOnline(){
        users = new ArrayList<User>();
        Map application = ActionContext.getContext().getApplication();
        Map loginUsers = (Map) application.get("loginUsers");
        for(Object key:loginUsers.keySet()){
            Map session = (Map) loginUsers.get(key);
            users.add((User) session.get("loginUser"));
        }
        return "success";
    }

    public String offline(){
        uid = ServletActionContext.getRequest().getParameter("uid");
        System.out.println(uid);
        Map application = ActionContext.getContext().getApplication();
        Map loginUsers = (Map) application.get("loginUsers");
        Map session = (Map) loginUsers.get(uid);
        session.clear();
        loginUsers.remove(uid);
        jsonObject = new JSONObject();
        jsonObject.put("status","200");
        jsonObject.put("msg","Ok");
        jsonObject.put("data","Ok");
        return "success";
    }

    public List<User> getUsers() {
        return users;
    }

    public void setUsers(List<User> users) {
        this.users = users;
    }

    public String getUid() {
        return uid;
    }

    public void setUid(String uid) {
        this.uid = uid;
    }

    public JSONObject getJsonObject() {
        return jsonObject;
    }

    public void setJsonObject(JSONObject jsonObject) {
        this.jsonObject = jsonObject;
    }
}
