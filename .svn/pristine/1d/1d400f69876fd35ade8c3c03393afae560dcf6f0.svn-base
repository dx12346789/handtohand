package com.qst.grade.interceptor;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.Interceptor;
import com.qst.grade.po.User;
import org.apache.struts2.ServletActionContext;

import javax.servlet.http.HttpServletRequest;
import java.util.Map;

public class LoginUserInterceptor implements Interceptor {
    @Override
    public void destroy() {
        System.out.println("销毁登录拦截器");
    }

    @Override
    public void init() {
        System.out.println("初始化登录拦截器");
    }

    @Override
    public String intercept(ActionInvocation actionInvocation) throws Exception {
        System.out.println("处理登录拦截器");
        Map session = ActionContext.getContext().getSession();
        HttpServletRequest request = ServletActionContext.getRequest();
        String ip = request.getHeader("x-forwarded-for");
          if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
                  ip = request.getHeader("Proxy-Client-IP");
              }
          if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
                  ip = request.getHeader("WL-Proxy-Client-IP");
              }
          if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
                  ip = request.getHeader("HTTP_CLIENT_IP");
              }
          if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
                  ip = request.getHeader("HTTP_X_FORWARDED_FOR");
              }
          if (ip == null || ip.length() == 0 || "unknown".equalsIgnoreCase(ip)) {
                  ip = request.getRemoteAddr();
              }
        System.err.println(ip);
        System.out.println(ServletActionContext.getRequest().getRemoteAddr());
        String actionName = actionInvocation.getAction().toString();

        User user = (User) session.get("loginUser");
        System.err.println(actionName);

        if (user == null){
            return "GlobalToLogin";
        }
        return actionInvocation.invoke();
    }
}
