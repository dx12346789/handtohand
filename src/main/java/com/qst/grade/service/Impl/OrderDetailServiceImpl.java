package com.qst.grade.service.Impl;

import com.qst.grade.dao.*;
import com.qst.grade.po.*;
import com.qst.grade.service.OrderDetailService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service
@Transactional
public class OrderDetailServiceImpl implements OrderDetailService {
    private final OrderDao orderDao;
    private final UserDao userDao;
    private final GoodsDao goodsDao;
    private final OrderDetailDao orderDetailDao;
    private  final CommentDao commentDao;

    @Autowired
    public OrderDetailServiceImpl(OrderDao orderDao,  UserDao userDao, GoodsDao goodsDao, OrderDetailDao orderDetailDao,CommentDao commentDao) {
        this.orderDao = orderDao;
        this.userDao = userDao;
        this.goodsDao = goodsDao;
        this.orderDetailDao = orderDetailDao;
        this.commentDao=commentDao;
    }


    @Override
    public List<OrderDetail> findOrdersBypayer(String uid) {
        return orderDetailDao.findorderpayerAll(uid);
    }

    @Override
    public List<OrderDetail> findOrdersByseller(String uid) {

        return orderDetailDao.findordersellerAll(uid);
    }

    @Override
    public Goods findGoodsBygid(String gid) {
        return goodsDao.findGoodsByGid(gid);
    }

    @Override
    public User findUsersByuid(String uid) {

        return userDao.findByuId(uid);
    }

    @Override
    public Order findorderByoid(String oid) {
        return orderDao.findOrderByoid(oid);
    }

    @Override
    public OrderDetail findByodid(String odid) {
        return orderDetailDao.findByODid(odid);
    }

    @Override
    public void updateorderDetail(OrderDetail orderDetail) {
         orderDetailDao.updateorderDetail(orderDetail);
    }

    @Override
    public List<OrderDetail> findAll() {
        List<OrderDetail> orderDetails = orderDetailDao.findAll();
        return orderDetails;
    }
}
