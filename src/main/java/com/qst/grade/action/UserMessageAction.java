package com.qst.grade.action;

import com.opensymphony.xwork2.ActionContext;
import com.qst.grade.po.Address;
import com.qst.grade.po.User;
import com.qst.grade.service.AddressService;
import com.qst.grade.service.UserService;
import net.sf.json.JSONObject;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.util.List;
import java.util.Map;

public class UserMessageAction {
    private UserService userService;
    private AddressService addressService;
    private String uid;
    private User user;
    private List<Address> addresses;
    private String account;
    private int accountType;
    private String pass;

    private String dest;

    private File doc;
    private String docFileName;
    private String docContentType;

    private JSONObject jsonObject;

    @Autowired
    public UserMessageAction(UserService userService, AddressService addressService) {
        this.userService = userService;
        this.addressService = addressService;
    }

    /**
     * 跳转到用户详情页
     *
     * @return
     */
    public String toUserDetails() {
        System.out.println("进入详情");
        System.out.println(uid);
        if (uid != null) {
            user = userService.findByuId(uid);
        } else {
            Map session = ActionContext.getContext().getSession();
            user = (User) session.get("loginUser");
            uid = user.getUid();
        }
        addresses = addressService.findByUid(uid);
        System.out.println(user);
        return "success";
    }

    /**
     * 更新用户基本信息
     *
     * @return
     */
    public String updateEssentialInformation() {
        System.out.println("更新前用户:" + user);
        User localUser = userService.findByuId(uid);
        localUser.setNickname(user.getNickname());
        localUser.setBirthday(user.getBirthday());
        localUser.setSex(user.getSex());
        System.out.println("更新后用户信息" + localUser);
        userService.updateUser(localUser);
        Map session = ActionContext.getContext().getSession();
        session.put("loginUser", localUser);
        return "success";
    }

    /**
     * 更新头像
     *
     * @return
     */
    public String updateHeadImage() {
        if (userService.updateUserHeadImage(uid, doc, docFileName, docContentType)) {
            return "success";
        }
        return "error";
    }

    /**
     * 跳转到修改联系方式界面  0为手机号   1为邮箱
     * @return
     */
    public String toUpdateAccount() {

        Map session = ActionContext.getContext().getSession();
        User localUser = (User) session.get("loginUser");
        if (accountType == 0) {
            account = localUser.getTelphone();

        } else if (accountType == 1) {
            account = localUser.getMail();
        }
        System.out.println(account + "---" + accountType);

        return "success";
    }

    /**
     * 更换联系方式
     *
     * @return
     */
    public String updateAccount() {
        boolean isOk = true;
        Map session = ActionContext.getContext().getSession();
        User localUser = (User) session.get("loginUser");
        System.out.println("修改的联系方式" + account);
        if (account.contains("@")) {
            if (userService.findByMail(account) != null) {
                isOk = false;
            } else {
                account.toLowerCase();
                localUser.setMail(account);
            }
        } else {
            if (userService.findByPhone(account) != null) {
                isOk = false;
            } else {
                localUser.setTelphone(account);
            }
        }
        if (!isOk) {
            jsonObject = new JSONObject();
            jsonObject.put("status","400");
            jsonObject.put("msg","error");
            jsonObject.put("data","联系方式存在");
            return "error";
        }
        userService.updateUser(localUser);
        session.put("loginUser", localUser);
        return "success";
    }


    /**
     * 跳转到忘记密码界面
     * @return
     */
    public String toForgetPassword(){
        return "success";
    }

    /**
     * 处理忘记密码请求
     * @return
     */
    public String forgetPassword(){
        User localUser;
        if (account.contains("@")) {
            localUser = userService.findByMail(account);
        }else {
            localUser = userService.findByPhone(account);
        }
        if(localUser != null){
            localUser.setPass(pass);
            userService.updateUser(localUser);
        }
        return "success";
    }

    public String checkAccount(){
        User localUser;
        jsonObject = new JSONObject();
        jsonObject.put("status","200");
        jsonObject.put("msg","OK");
        jsonObject.put("data","1");
        if (account.contains("@")) {
            localUser = userService.findByMail(account);
        }else {
            localUser = userService.findByPhone(account);
        }
        if(localUser != null){
            jsonObject.put("data",localUser.getStatus() + "");
        }
        System.out.println(jsonObject);
        return "success";
    }

    /**
     * 检查密码是否一致
     * @return
     */
    public String checkPass(){
        jsonObject = new JSONObject();
        jsonObject.put("status","200");
        System.out.println(uid + "-----" + pass);
        if(userService.checkPassByUidAndPass(uid,pass)){
            jsonObject.put("msg","ok");
            jsonObject.put("data","ok");
        }else {
            jsonObject.put("msg","error");
            jsonObject.put("data","密码不一致");
        }
        return "success";
    }

    /**
     * 修改密码
     * 如果是登录用户,注销账户，重新登录
     * @return
     */
    public String updatePass(){
        Map session = ActionContext.getContext().getSession();
        User localLoginUser = (User) session.get("loginUser");
        User localUser = userService.findByuId(uid);
        localUser.setPass(pass);
        userService.updateUser(localUser);
        if(localLoginUser.getUid().equals(localUser.getUid())){
            return "successExit";
        }
        jsonObject = new JSONObject();
        jsonObject.put("status","200");
        jsonObject.put("msg","ok");
        jsonObject.put("data","ok");
        return "success";
    }

    public String toWebSocket(){
        System.out.println(dest);
        Map m = ActionContext.getContext().getSession();
        User user = (User) m.get("loginUser");
        if (user != null){
            return "websocket";
        }
        return "tologin";
    }

    public String getUid() {
        return uid;
    }

    public void setUid(String uid) {
        this.uid = uid;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public File getDoc() {
        return doc;
    }

    public void setDoc(File doc) {
        this.doc = doc;
    }

    public String getDocFileName() {
        return docFileName;
    }

    public void setDocFileName(String docFileName) {
        this.docFileName = docFileName;
    }

    public String getDocContentType() {
        return docContentType;
    }

    public void setDocContentType(String docContentType) {
        this.docContentType = docContentType;
    }

    public String getAccount() {
        return account;
    }

    public void setAccount(String account) {
        this.account = account;
    }

    public List<Address> getAddresses() {
        return addresses;
    }

    public void setAddresses(List<Address> addresses) {
        this.addresses = addresses;
    }

    public int getAccountType() {
        return accountType;
    }

    public void setAccountType(int accountType) {
        this.accountType = accountType;
    }

    public JSONObject getJsonObject() {
        return jsonObject;
    }

    public void setJsonObject(JSONObject jsonObject) {
        this.jsonObject = jsonObject;
    }

    public String getPass() {
        return pass;
    }

    public void setPass(String pass) {
        this.pass = pass;
    }

    public String getDest() {
        return dest;
    }

    public void setDest(String dest) {
        this.dest = dest;
    }

}
