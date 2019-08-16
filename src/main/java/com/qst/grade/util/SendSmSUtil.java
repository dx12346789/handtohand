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

    public static final String SIGN_NAME = "HandToHand";           //签名，不介意修改
    public static final String REGIONID = "default";               //区域id，不建议修改

    public static final String REGISTER_CODE = "SMS_171858629";    //注册时使用
    public static final String CHANGE_CODE = "SMS_171858630";      //变更重要信息时使用
    public static final String RESET_PASSWORD = "SMS_172209451";   //重置密码时使用
    public static final String FREEZE_USERS = "SMS_172224483";     //冻结用户时使用
    public static final String DELETE_USERS = "SMS_172209454";     ///删除用户时使用

    /**
     * 发送短信
     * @param regionId  地区ID，建议使用 default
     * @param phoneNumbers 接收者手机号码
     * @param templateCode  模板CODE
     * @param templateParam 模板参数 json格式
     */
    public static String sendSmS(String regionId, String phoneNumbers, String templateCode, String templateParam){
        String result = "";
        DefaultProfile profile = DefaultProfile.getProfile(regionId, "LTAIzS4wQyexsd9o", "5hA7KHw8UHCTOpPhx3XzrI9dLLwf9n");
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
        String result = sendSmS(REGIONID,"15274450509",REGISTER_CODE,"{\"code\":\"123456\"}");
        System.out.println(result);
    }
}
