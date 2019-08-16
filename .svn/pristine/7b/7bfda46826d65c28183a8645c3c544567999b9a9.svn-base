package com.qst.grade.dao;

import com.qst.grade.po.ShopCart;

import java.util.List;

public interface CartDao {
    List<ShopCart> findAllByUid(String uid);
    Integer getAllOfGoodsNumberByUid(String uid);
    Integer getAllOfInvalidNumberByUid(String uid);
    Integer changeShopCartItem(String gid, int num);
    int deleteOrderItem(String sid);
    ShopCart findAllByGidAndUid(String gid, String uid);
    ShopCart findBySid(String sid);
    ShopCart findByUidGid(String uid,String gid);
    String addCart(ShopCart shopCart);
    int updateCount(ShopCart shopCart);
}
