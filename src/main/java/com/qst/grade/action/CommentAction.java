package com.qst.grade.action;

import com.opensymphony.xwork2.ActionContext;
import com.qst.grade.po.Comment;
import com.qst.grade.po.OrderDetail;
import com.qst.grade.po.User;
import com.qst.grade.service.CommentService;
import com.qst.grade.service.OrderDetailService;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.sql.Timestamp;
import java.util.Date;
import java.util.Map;

public class CommentAction {

    private int anonymous;
    private Comment comment;
    private CommentService commentService;
    private OrderDetailService orderDetailService;
    private String orderid;
    private OrderDetail orderDetail;

    @Autowired
    public CommentAction(CommentService commentService, OrderDetailService orderDetailService) {
        this.commentService = commentService;
        this.orderDetailService = orderDetailService;
    }

    public String savediscuss() {
//        System.out.println("进入SAVE");
//        Map session = ActionContext.getContext().getSession();
//        User user = (User) session.get("loginUser");
//        System.out.println(user);
//        System.out.println(comment);
//        comment.setCommentator(user.getUid());
//        Date date = new Date(System.currentTimeMillis());
//        comment.setCreateTime(new Timestamp(date.getTime()));
//        comment.setStatus(0);
//        if (anonymous == 1) {
//            comment.setAnonymous(0);
//        } else {
//            comment.setAnonymous(1);
//        }
        if (save() == null) {
            System.out.println("保存失败");
        } else {
            System.out.println("保存成功");
            System.out.println("orderidYAYAYAY"+comment.getOdid());
            orderDetail = orderDetailService.findByodid(comment.getOdid());
            System.out.println(orderDetail);
            orderDetail.setStatus(3);
            orderDetailService.updateorderDetail(orderDetail);
        }
        return "success";
    }
    public void savefeedback(){
        HttpServletResponse response=ServletActionContext.getResponse();
        if (save() == null) {
            try {
                response.getWriter().print("error");
            } catch (IOException e) {
                e.printStackTrace();
            }
        } else {
            try {
                response.getWriter().print("success");
            } catch (IOException e) {
                e.printStackTrace();
            }
        }
    }
    public String save(){
        System.out.println("进入SAVE");
        Map session = ActionContext.getContext().getSession();
        User user = (User) session.get("loginUser");
        System.out.println("comment="+comment);
        comment.setCommentator(user.getUid());
        Date date = new Date(System.currentTimeMillis());
        comment.setCreateTime(new Timestamp(date.getTime()));
        comment.setStatus(0);
        if (anonymous == 1) {
            comment.setAnonymous(0);
        } else {
            comment.setAnonymous(1);
        }
        return commentService.saveComment(comment);
    }
    public OrderDetail getOrderDetail() {
        return orderDetail;
    }

    public void setOrderDetail(OrderDetail orderDetail) {
        this.orderDetail = orderDetail;
    }

    public String getOrderid() {
        return orderid;
    }

    public void setOrderid(String orderid) {
        this.orderid = orderid;
    }

    public Comment getComment() {
        return comment;
    }

    public void setComment(Comment comment) {
        this.comment = comment;
    }

    public int getAnonymous() {
        return anonymous;
    }

    public void setAnonymous(int anonymous) {
        this.anonymous = anonymous;
    }
}
