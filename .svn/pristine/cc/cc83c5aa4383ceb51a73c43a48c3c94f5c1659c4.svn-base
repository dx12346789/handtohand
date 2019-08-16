package com.qst.grade.action;

import com.opensymphony.xwork2.ActionContext;
import com.qst.grade.po.Goods;
import com.qst.grade.po.ShopCart;
import com.qst.grade.po.User;
import com.qst.grade.service.CartService;
import com.qst.grade.service.GoodsService;
import com.qst.grade.util.UUID;
import net.sf.json.JSONObject;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Arrays;
import java.util.Map;

@Controller
public class CartAction {


    private final CartService cartService;
    private final GoodsService goodsService;

    @Autowired
    public CartAction(CartService cartService,GoodsService goodsService) {
        this.cartService = cartService;
        this.goodsService=goodsService;
    }

    private JSONObject data;
    private int count;
    private String gid1;
    private String uid;
    private String result;
    private String[] gid;
    private ShopCart shopCart;

    public String toCart(){
        Map m = ActionContext.getContext().getSession();
        User user = (User) m.get("loginUser");
        if (user == null){
            return "login";
        }
        return "cart";
    }

    public void addCart(){
        HttpServletResponse response=ServletActionContext.getResponse();
        User user=(User)ActionContext.getContext().getSession().get("loginUser");
        if (user==null){
            try {
                response.getWriter().print("tologin");
            } catch (IOException e) {
                e.printStackTrace();
            }
        }else {
            shopCart = new ShopCart();
            shopCart.setUid(user.getUid());
            shopCart.setGid(gid1);
            shopCart.setCount(count);
            ShopCart shopCart1=cartService.findByUidGid(user.getUid(),gid1);
            if (shopCart1==null){
                String fid= "S"+ UUID.getUUID(32);
                shopCart.setSid(fid);
                cartService.addCart(shopCart);
                try {
                    response.getWriter().print("togoods");
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }else {
                System.out.println("shopCart1="+shopCart1.getCount());
                Goods goods=goodsService.findGoodsByGid(shopCart1.getGid());
                if (goods.getCount()<(shopCart1.getCount()+count)){
                    System.out.println("执行了");
                    try {
                        response.getWriter().print("full");
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                }else {
                    shopCart1.setCount(count+shopCart1.getCount());
                    int num=cartService.updateCount(shopCart1);
                    try {
                        response.getWriter().print("togoods");
                    } catch (IOException e) {
                        e.printStackTrace();
                    }
                }
            }
        }
    }

    public String getCartInfo(){
        System.out.println(uid);
        data = cartService.toCart(uid);
        return "cart";
    }

    public String changeShopCartItem(){
        HttpServletResponse response = ServletActionContext.getResponse();
        response.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=UTF-8");
        System.out.println(result);
        JSONObject jsonObject = JSONObject.fromObject(result);
        String gid = (String) jsonObject.get("gid");
        String numStr = (String) jsonObject.get("num");
        int num = Integer.valueOf(numStr);
        System.out.println(gid);
        System.out.println(num);
        cartService.changeShopCartItem(gid, num);
        try {
            response.getWriter().print("success");
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }

    public String deleteOrderItem(){
        HttpServletResponse response = ServletActionContext.getResponse();
        response.setCharacterEncoding("utf-8");
        response.setContentType("text/html;charset=UTF-8");
        System.out.println(result);
        cartService.deleteOrderItem(result);
        try {
            response.getWriter().print("success");
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }

    public String toBuyItem(){
        System.out.println(Arrays.toString(gid));
        Map m = ActionContext.getContext().getSession();
        User user = (User) m.get("loginUser");
        if (user == null){
            return "tologin";
        }
        data = cartService.toOrder(gid, user);
        return "toorder";
    }

    public JSONObject getData() {
        return data;
    }

    public void setData(JSONObject data) {
        this.data = data;
    }

    public String getUid() {
        return uid;
    }

    public void setUid(String uid) {
        this.uid = uid;
    }

    public String getResult() {
        return result;
    }

    public void setResult(String result) {
        this.result = result;
    }

    public String[] getGid() {
        return gid;
    }

    public void setGid(String[] gid) {
        this.gid = gid;
    }

    public int getCount() {
        return count;
    }

    public void setCount(int count) {
        this.count = count;
    }

    public String getGid1() {
        return gid1;
    }

    public void setGid1(String gid1) {
        this.gid1 = gid1;
    }

    public ShopCart getShopCart() {
        return shopCart;
    }

    public void setShopCart(ShopCart shopCart) {
        this.shopCart = shopCart;
    }
}
