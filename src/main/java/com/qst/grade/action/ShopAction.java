package com.qst.grade.action;

import com.opensymphony.xwork2.ActionContext;
import com.qst.grade.po.Favorite;
import com.qst.grade.po.Goods;
import com.qst.grade.po.User;
import com.qst.grade.service.FavoriteService;
import com.qst.grade.service.GoodsService;
import com.qst.grade.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import java.util.ArrayList;
import java.util.List;
@Controller
public class ShopAction {
    private Integer pageCode;
    private int pageSize=20;
    private int totalPage;
    private String uid;
    private User user;
    private GoodsService goodsService;
    private UserService userService;
    private FavoriteService favoriteService;
    private List<Goods> goodsList;
    private List<Favorite> favoriteList;

    @Autowired
    public ShopAction(GoodsService goodsService,UserService userService,FavoriteService favoriteService) {
        this.goodsService = goodsService;
        this.userService = userService;
        this.favoriteService=favoriteService;
    }
    public String toShop(){
        User user1=(User)ActionContext.getContext().getSession().get("loginUser");
        totalPage=goodsService.count(uid);
        if (totalPage%pageSize==0){
            setTotalPage(totalPage/pageSize);
        }else {
            setTotalPage(totalPage/pageSize+1);
        }
        if (pageCode==null){
            setPageCode(1);
        }
        favoriteList=new ArrayList<Favorite>();
        user = userService.findByuId(uid);
        goodsList = goodsService.findGoodsByUid(uid,(pageCode-1)*pageSize,pageSize);
        for (int i = 0;i<goodsList.size();i++){
            Goods goods=goodsList.get(i);
            Favorite favorite=new Favorite();
            favorite=favoriteService.findByGidUid(goods.getGid(),user1.getUid());
            if (favorite == null){
                continue;
            }
            favoriteList.add(favorite);
        }
        return "toshop";
    }

    public String getUid() {
        return uid;
    }

    public void setUid(String uid) {
        this.uid = uid;
    }

    public List<Goods> getGoodsList() {
        return goodsList;
    }

    public void setGoodsList(List<Goods> goodsList) {
        this.goodsList = goodsList;
    }

    public User getUser() {
        return user;
    }

    public void setUser(User user) {
        this.user = user;
    }

    public List<Favorite> getFavoriteList() {
        return favoriteList;
    }

    public void setFavoriteList(List<Favorite> favoriteList) {
        this.favoriteList = favoriteList;
    }

    public Integer getPageCode() {
        return pageCode;
    }

    public void setPageCode(Integer pageCode) {
        if (pageCode==null){
            pageCode=1;
        }
        this.pageCode = pageCode;
    }

    public int getPageSize() {
        return pageSize;
    }

    public void setPageSize(int pageSize) {
        this.pageSize = pageSize;
    }

    public int getTotalPage() {
        return totalPage;
    }

    public void setTotalPage(int totalPage) {
        this.totalPage = totalPage;
    }
}
