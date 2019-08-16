package com.qst.grade.action.admin;

import com.qst.grade.po.User;
import com.qst.grade.service.UserService;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;

import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;

public class RegisterUsersContentAction {
    private JSONObject jsonObject;
    private UserService userService;

    @Autowired
    public RegisterUsersContentAction(UserService userService) {
        this.userService = userService;
    }

    public String toRegisterContent() {
        List<User> users = userService.findAll();
        int sexMan = 0;
        int sexWuman = 0;
        int sexOther = 0;
        Date nowDate = new Date();

        int[] contentCount = new int[11];
        for (User user : users) {
            if (user.getSex() == -1) {
                sexOther++;
            } else if (user.getSex() == 0) {
                sexWuman++;
            } else {
                sexMan++;
            }
            int day = (int) ((nowDate.getTime() - user.getCreateTime().getTime()) / (1000 * 60 * 60 * 24));
            if (day < 10) {
                contentCount[9 - day]++;
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
        JSONObject localJSONObject = new JSONObject();
        localJSONObject.put("man", sexMan);
        localJSONObject.put("wuman", sexWuman);
        localJSONObject.put("other", sexOther);
        localJSONObject.put("title", title);
        localJSONObject.put("content", content);
        jsonObject = new JSONObject();
        jsonObject.put("status", "200");
        jsonObject.put("msg", "OK");
        jsonObject.put("data", localJSONObject);
        System.out.println(localJSONObject);
        return "success";
    }

    public JSONObject getJsonObject() {
        return jsonObject;
    }

    public void setJsonObject(JSONObject jsonObject) {
        this.jsonObject = jsonObject;
    }
}
