package com.qst.grade.service.Impl;

import com.qst.grade.dao.AddressDao;
import com.qst.grade.dao.CartDao;
import com.qst.grade.dao.GoodsDao;
import com.qst.grade.dao.UserDao;
import com.qst.grade.po.Address;
import com.qst.grade.po.Goods;
import com.qst.grade.po.ShopCart;
import com.qst.grade.po.User;
import com.qst.grade.service.CartService;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class CartServiceImpl implements CartService {

    private final CartDao cartDao;
    private final GoodsDao goodsDao;
    private final UserDao userDao;
    private final AddressDao addressDao;

    @Autowired
    public CartServiceImpl(CartDao cartDao, GoodsDao goodsDao, UserDao userDao, AddressDao addressDao) {
        this.cartDao = cartDao;
        this.goodsDao = goodsDao;
        this.userDao = userDao;
        this.addressDao = addressDao;
    }

    @Override
    public List<ShopCart> findAllByUid(String uid) {
        return cartDao.findAllByUid(uid);
    }

    @Override
    public ShopCart findByUidGid(String uid, String gid) {
        return cartDao.findByUidGid(uid, gid);
    }

    public Integer getAllOfGoodsNumberByUid(String uid) {
        return cartDao.getAllOfGoodsNumberByUid(uid);
    }

    @Override
    public Integer getAllOfInvalidNumberByUid(String uid) {
        return cartDao.getAllOfInvalidNumberByUid(uid);
    }

    @Override
    public Integer changeShopCartItem(String gid, int num) {
        return cartDao.changeShopCartItem(gid, num);
    }

    @Override
    public int deleteOrderItem(String sid) {
        return cartDao.deleteOrderItem(sid);
    }

    @Override
    public JSONObject toOrder(String[] gid, User user) {
        String uid = user.getUid();
        int gold = user.getGold();
        JSONArray jsonArray = new JSONArray();
        if (gid != null) {
            for (String s : gid) {
                ShopCart cart = cartDao.findAllByGidAndUid(s, uid);
                if (cart == null) {
                    cart = new ShopCart();
                    cart.setGid(s);
                    cart.setUid(uid);
                }
                JSONObject object = new JSONObject();
                object.put("cart", cart);
                Goods goods = goodsDao.findGoodsByGid(s);
                object.put("good", goods);
                User user1 = userDao.findByuId(goods.getUid());
                System.out.println(user1);
                System.out.println(object);
                object.put("user", user1);
                jsonArray.add(object);
            }
        } else {
            return null;
        }
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("data", jsonArray);
        List<Address> address = addressDao.findByUid(uid);
        jsonObject.put("address", address);
        jsonObject.put("gold",gold);
        System.err.println(gold);
        System.out.println(address);
        return jsonObject;
    }

    public JSONArray getInformationOfGoods(List<ShopCart> carts) {
        JSONArray jsonArray = new JSONArray();
        for (int i = 0; i < carts.size(); i++) { //循环获取所有商品信息
            ShopCart cart = carts.get(i);
            Goods goods = goodsDao.findGoodsByGid(cart.getGid());
            JSONObject jsonObject = this.getGoodsInformation(goods);
            jsonObject.put("sid", cart.getSid());
            jsonObject.put("count", cart.getCount());
            String nickname = this.getNicknameByUid(goods.getUid());
            jsonObject.put("seller", nickname);

            jsonArray.add(i, jsonObject);
        }

        return jsonArray;
    }

    private String getNicknameByUid(String uid) {
        User user = userDao.findByuId(uid);
        return user.getNickname();
    }

    private JSONObject getGoodsInformation(Goods goods) {
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("gid", goods.getGid());
        jsonObject.put("name", goods.getName());
        jsonObject.put("status", goods.getStatus());
        jsonObject.put("price", goods.getPrice());
        jsonObject.put("imgPath", goods.getImgPath());
        jsonObject.put("stock", goods.getCount());
        return jsonObject;
    }

    @Override
    public JSONObject toCart(String uid) {
        List<ShopCart> carts = this.findAllByUid(uid);
        JSONObject jsonObject = new JSONObject();
        jsonObject.put("status", "200");
        jsonObject.put("message", "OK");

        JSONObject jsonObject1 = new JSONObject();

        Integer allOfGoodsNumber = this.getAllOfGoodsNumberByUid(uid);
        Integer allOfInvalidNumber = this.getAllOfInvalidNumberByUid(uid);
        jsonObject1.put("goodsNumber", allOfGoodsNumber);
        jsonObject1.put("invalidNumber", allOfInvalidNumber);

        jsonObject1.put("goods", getInformationOfGoods(carts));
        jsonObject.put("data", jsonObject1);

        System.out.println(jsonObject);
        return jsonObject;
    }

    @Override
    public String addCart(ShopCart shopCart) {
        return cartDao.addCart(shopCart);
    }

    @Override
    public int updateCount(ShopCart shopCart) {
        return cartDao.updateCount(shopCart);
    }
}
