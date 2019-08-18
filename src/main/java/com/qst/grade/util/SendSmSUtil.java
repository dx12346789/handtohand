package com.qst.grade.util;

import com.aliyuncs.CommonRequest;
import com.aliyuncs.CommonResponse;
import com.aliyuncs.DefaultAcsClient;
import com.aliyuncs.IAcsClient;
import com.aliyuncs.exceptions.ClientException;
import com.aliyuncs.exceptions.ServerException;
import com.aliyuncs.http.MethodType;
import com.aliyuncs.profile.DefaultProfile;
import net.sf.json.JSONObject;

public class SendSmSUtil {

    public static final String SIGN_NAME = "应用民";           //签名，不介意修改
    public static final String REGIONID = "default";               //区域id，不建议修改

    public static final String REGISTER_CODE = "获取";    //注册时使用
    public static final String CHANGE_CODE = "获取";      //变更重要信息时使用
    public static final String RESET_PASSWORD = "获取";   //重置密码时使用
    public static final String FREEZE_USERS = "获取";     //冻结用户时使用
    public static final String DELETE_USERS = "获取";     ///删除用户时使用

    /**
     * 发送短信
     * @param regionId  地区ID，建议使用 default
     * @param phoneNumbers 接收者手机号码
     * @param templateCode  模板CODE
     * @param templateParam 模板参数 json格式
     */
    public static String sendSmS(String regionId, String phoneNumbers, String templateCode, String templateParam){
        String result = "";
        DefaultProfile profile = DefaultProfile.getProfile(regionId, "阿里云获取", "阿里云获取");
        IAcsClient client = new DefaultAcsClient(profile);
        CommonRequest request = new CommonRequest();
        request.setMethod(MethodType.POST);
        request.setDomain("dysmsapi.aliyuncs.com");
        request.setVersion("2017-05-25");
        request.setAction("SendSms");
        request.putQueryParameter("RegionId", regionId);
        request.putQueryParameter("PhoneNumbers", phoneNumbers);
        request.putQueryParameter("SignName", SIGN_NAME);
        request.putQueryParameter("TemplateCode", templateCode);
        request.putQueryParameter("TemplateParam", templateParam);
        try {
            CommonResponse response = client.getCommonResponse(request);
            result = response.getData();
        } catch (ServerException e) {
            e.printStackTrace();
        } catch (ClientException e) {
            e.printStackTrace();
        }
        return result;
    }

    public static void main(String[] args) {
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("code","123456");
        System.out.println(jsonObject.toString());
        String result = sendSmS(REGIONID,"测试用",REGISTER_CODE,"{\"code\":\"123456\"}");
        System.out.println(result);
    }
}
