package com.qst.grade.action;

import org.apache.struts2.ServletActionContext;

import javax.servlet.http.HttpSession;

public class SerAction {

    public void login(){
        HttpSession session =  ServletActionContext.getRequest().getSession();

    }
}
