package com.qst.grade.service;

import com.qst.grade.po.*;

import java.util.List;

public interface OrderDetailService {
    /**
     *查询该用户已购买的订单详情
     * @param uid
     * @return
     */
    List<OrderDetail> findOrdersBypayer(String uid);

    /**
     * 查询用户已卖出的订单详情
     * @param uid
     * @return
     */
    List<OrderDetail> findOrdersByseller(String uid);
    /**
     * 该用户订单详情中的商品详情
     * @param orderDetails
     * @return
     */
    Goods findGoodsBygid(String gid);

    /**
     * 通过订单详情的Uid查找对应卖家名
     * @param orderDetails
     * @return
     */
    User findUsersByuid(String uid);

    /**
     * 通过订单详情中的订单ID查找对应的订单信息
     * @param orderDetails
     * @return
     */
  Order  findorderByoid(String oid);

  OrderDetail findByodid(String odid);
  void updateorderDetail(OrderDetail orderDetail);

  List<OrderDetail> findAll();

}
