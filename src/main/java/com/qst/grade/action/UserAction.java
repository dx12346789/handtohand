package com.qst.grade.action;

import com.opensymphony.xwork2.ActionContext;
import com.qst.grade.po.User;
import com.qst.grade.service.UserService;
import com.qst.grade.util.UUID;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import java.util.Date;
import java.util.HashMap;
import java.util.Map;

@Controller
public class UserAction {
    private String uid;
    private String account;
    private User user;
    private UserService userService;
    private JSONObject jsonObject;

    @Autowired
    public UserAction(UserService userService) {
        this.userService = userService;
    }

    public String toRegister(){
        return "success";
    }
    public String toLogin(){
        return "success";
    }

    /**
     * 处理注册请求
     * @return 失败返回注册界面，成功返回登录界面,并回填用户名
     */
    public String register() {
        jsonObject = new JSONObject();
        jsonObject.put("status","400");
        jsonObject.put("msg","ERROR");
        if(account.contains("@")){
            account = account.toLowerCase();
            user.setMail(account);
            User user1 = userService.findByMail(user.getMail());
            if(user1 != null){
                if(user1.getStatus() == 0){
                    jsonObject.put("data","有正常用户");
                    return "error";
                }else if(user1.getStatus() == 2){
                    jsonObject.put("data","该账号已被冻结,请联系管理员");
                    return "error";
                }
            }
        }else {
            user.setTelphone(account);
        }
        user.setUid("U" + UUID.getUUID(32));
        user.setHeadImage("images/default.jpg");
        user.setGold(0);
        user.setSex(-1);
        user.setStatus(0);
        user.setCreateTime(new Date());
        System.out.println(user);
        if (userService.addUser(user) != null) {
            jsonObject.put("status","200");
            jsonObject.put("msg","OK");
            jsonObject.put("data","OK");
            if(user.getAuth() != 0){
                System.out.println("管理员注册");
                return "admin";
            }
            System.out.println("普通用户注册");
            return "success";
        }
        jsonObject.put("data","注册异常");
        return "error";
    }

    /**
     * 处理登录请求
     * @return  成功返回个人信息界面，失败返回登录界面
     */
    public String login() {
        User user1 = null;
        if(account.contains("@")){
            account.toLowerCase();
            user.setMail(account);
            user1 = userService.findByMailAndPass(user.getMail(),user.getPass());
        }else {
            user.setTelphone(account);
            user1 = userService.findByPhoneAndPass(user.getTelphone(),user.getPass());
        }
        System.out.println(user);
        if (user1 != null) {
            user1.setLatestLoginTime(new Date());
            Map session = ActionContext.getContext().getSession();
            session.put("loginUser",user1);
            System.out.println(user1);
            uid = user1.getUid();
            userService.updateUser(user1);
            /**
             * 将登陆用户写入application
             */
            Map application = ActionContext.getContext().getApplication();
            Map<String,Object> loginUsers = (Map<String, Object>) application.get("loginUsers");
            if(loginUsers == null){
                loginUsers = new HashMap<String, Object>();
            }
            Map loginUserSession = (Map) loginUsers.get(uid);
            if(loginUserSession != null){
                loginUserSession.clear();
            }
            loginUsers.put(uid,session);
            application.put("loginUsers",loginUsers);
            return "success";
        }
        jsonObject = new JSONObject();
        jsonObject.put("status","400");
        jsonObject.put("msg","ERROR");
        jsonObject.put("data","账号或密码错误");
        return "error";
    }

    /**
     * 清除本次回话一切信息，退出登录
     * @return
     */
    public String exit(){
        Map session = ActionContext.getContext().getSession();
        User localUser = (User) session.get("loginUser");

        /**
         * 退出用户从application移出
         */
        Map application = ActionContext.getContext().getApplication();
        Map loginUsers = (Map) application.get("loginUsers");
        loginUsers.remove(localUser.getUid());
        session.clear();
        return "success";
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public String getAccount() {
        return account;
    }

    public void setAccount(String account) {
        this.account = account;
    }

    public JSONObject getJsonObject() {
        return jsonObject;
    }

    public void setJsonObject(JSONObject jsonObject) {
        this.jsonObject = jsonObject;
    }

    public String getUid() {
        return uid;
    }

    public void setUid(String uid) {
        this.uid = uid;
    }
}
