package com.qst.grade.service;

import com.qst.grade.po.ShopCart;
import com.qst.grade.po.User;
import net.sf.json.JSONObject;

import java.util.List;

public interface CartService {
    List<ShopCart> findAllByUid(String uid);
    JSONObject toCart(String uid);
    Integer getAllOfGoodsNumberByUid(String uid);
    Integer getAllOfInvalidNumberByUid(String uid);
    Integer changeShopCartItem(String gid, int num);
    int deleteOrderItem(String sid);
    JSONObject toOrder(String[] gid, User user);
    ShopCart findByUidGid(String uid,String gid);
    String addCart(ShopCart shopCart);
    int updateCount(ShopCart shopCart);
}
