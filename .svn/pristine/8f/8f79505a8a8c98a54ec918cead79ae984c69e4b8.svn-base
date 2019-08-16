package com.qst.grade.dao;

import com.qst.grade.po.OrderDetail;

import java.util.List;

public interface OrderDetailDao {

    /**
     * 保存订单详情
     * @param orderDetail
     * @return
     */
    String save(OrderDetail orderDetail);

    /**
     * 查找我购买的订单详情列表
     * @param uid
     * @return
     */
    List<OrderDetail> findorderpayerAll(String uid);


    /**
     * 查看我卖出的订单详情列表
     * @param uid
     * @return
     */
    List<OrderDetail> findordersellerAll(String uid);

    /**
     * 通过id找出相关信息
     * @param odid
     * @return
     */
    OrderDetail findByODid(String odid);
    void updateorderDetail(OrderDetail orderDetail);

    List<OrderDetail> findAll();

    Integer getBuyNumber(String uid);

    Integer getSellNumber(String uid);
}
