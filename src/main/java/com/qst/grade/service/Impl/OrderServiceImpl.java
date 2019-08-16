package com.qst.grade.service.Impl;

import com.qst.grade.dao.*;
import com.qst.grade.po.*;
import com.qst.grade.service.OrderService;
import com.qst.grade.util.PointUtil;
import com.qst.grade.util.UUID;
import org.dom4j.DocumentException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Timestamp;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Service
@Transactional
public class OrderServiceImpl implements OrderService {
    private final OrderDao orderDao;
    private final CartDao cartDao;
    private final GoodsDao goodsDao;
    private final OrderDetailDao orderDetailDao;
    private final UserDao userDao;

    @Autowired
    public OrderServiceImpl(OrderDao orderDao, CartDao cartDao, GoodsDao goodsDao, OrderDetailDao orderDetailDao, UserDao userDao) {
        this.orderDao = orderDao;
        this.cartDao = cartDao;
        this.goodsDao = goodsDao;
        this.orderDetailDao = orderDetailDao;
        this.userDao = userDao;
    }

    public String createOrder(String[] gid, String[] sid, User user, String aid, double totalPrice) {
        String oid = "O" + UUID.getUUID(32);
        Order order = new Order();
        order.setOid(oid);
        order.setPrice(totalPrice);
        Date date = new Date(System.currentTimeMillis());
        order.setCreateTime(new Timestamp(date.getTime()));
        order.setAid(aid);
        orderDao.save(order);
        int gold = user.getGold();
        int price = new Double(totalPrice).intValue() * 100;
        if (gold > price) {
            gold = price;
        }
        System.out.println(gold);
        System.out.println(user.getUid());
        user.setGold(user.getGold() - gold);
        userDao.subGold(user.getUid(), gold);
        createOrderDetail(gid,sid,user.getUid(),oid);
        return oid;
    }

    @Override
    public Integer paySuccess(String oid, String pid, User user) {
        PointUtil pointUtil = new PointUtil();
        int gold = user.getGold();
        int number = 0;
        try {
            List<Point> pointList = pointUtil.findAll();
            if (pointList != null){
                for (Point point: pointList) {
                    int low = Integer.valueOf(point.getLow());
                    int high = Integer.valueOf(point.getHigh());
                    if (low <= gold && high >= gold){
                        number =  Integer.valueOf(point.getNumber());
                        break;
                    }
                }
            }
        } catch (DocumentException e) {
            e.printStackTrace();
        }
        userDao.addGold(user.getUid(), number);
        orderDao.save(oid, pid);
        return number;
    }



    private void createOrderDetail(String[] gid, String[] sid, String uid, String oid) {

        for(int i = 0; i < gid.length; i++) {
            OrderDetail orderDetail = new OrderDetail();
            Goods goods = goodsDao.findGoodsByGid(gid[i]);
            ShopCart shopCart = cartDao.findBySid(sid[i]);
            String oDid = "o" + UUID.getUUID(32);
            orderDetail.setGid(goods.getGid());
            orderDetail.setOid(oid);
            orderDetail.setBuyyer(uid);
            orderDetail.setSeller(goods.getUid());
            orderDetail.setCount(shopCart.getCount());
            orderDetail.setoDid(oDid);
            orderDetailDao.save(orderDetail);
            goodsDao.updateCountByGid(goods.getGid(), shopCart.getCount());
            cartDao.deleteOrderItem(shopCart.getSid());
        }
    }
}
