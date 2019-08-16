package com.qst.grade.interceptor;

import com.opensymphony.xwork2.ActionContext;
import com.opensymphony.xwork2.ActionInvocation;
import com.opensymphony.xwork2.interceptor.Interceptor;
import com.qst.grade.po.User;

import java.util.Map;

public class AdminInterceptor implements Interceptor {
    @Override
    public void destroy() {
        System.out.println("销毁管理员拦截器");
    }

    @Override
    public void init() {
        System.out.println("初始化管理员拦截器");
    }

    @Override
    public String intercept(ActionInvocation actionInvocation) throws Exception {
        System.out.println("处理管理员拦截器");
        Map session = ActionContext.getContext().getSession();
        User user = (User) session.get("loginUser");
        if (user.getAuth() == 0){
            return "toIndex";
        }
        return actionInvocation.invoke();
    }
}
