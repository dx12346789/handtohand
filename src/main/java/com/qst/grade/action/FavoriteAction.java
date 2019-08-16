package com.qst.grade.action;

import com.opensymphony.xwork2.ActionContext;
import com.qst.grade.po.Favorite;
import com.qst.grade.po.Goods;
import com.qst.grade.po.User;
import com.qst.grade.service.FavoriteService;
import com.qst.grade.service.GoodsService;
import com.qst.grade.util.UUID;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.*;

@Controller
public class FavoriteAction {
    private Integer pageCode;
    private int pageSize=20;
    private int totalPage;
    private int num;
    private String[] gid;
    private Favorite favorite;
    private FavoriteService favoriteService;
    private GoodsService goodsService;
    private List<Favorite> favoriteList;
    private List<Goods> goodsList;
    @Autowired
    public FavoriteAction(FavoriteService favoriteService,GoodsService goodsService) {
        this.favoriteService = favoriteService;
        this.goodsService=goodsService;
    }

    /**
     * 添加收藏夹
     * @return
     */
    public void add(){
        HttpServletResponse response = ServletActionContext.getResponse();
        Map session = ActionContext.getContext().getSession();
        User user= (User) session.get("loginUser");
        if (user==null){
            try {
                response.getWriter().print("tologin");
            } catch (IOException e) {
                e.printStackTrace();
            }
        }else {
            favorite=new Favorite();
            favorite.setGid(gid[0]);
            favorite.setUid(user.getUid());
            System.out.println("gids="+gid[0]);
            if (favoriteService.findByGidUid(gid[0],user.getUid())!=null){
                int id=favoriteService.delete(gid,user.getUid());
                try {
                    response.getWriter().print("delete");
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }else {
                String fid="F"+UUID.getUUID(32);
                favorite.setFid(fid);
                favorite.setAddTime(new Date(System.currentTimeMillis()));
                String id=favoriteService.add(favorite);
                try {
                    response.getWriter().print("add");
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }
    public String tofavorite(){
        User user=(User)ActionContext.getContext().getSession().get("loginUser");
        totalPage=favoriteService.count(user.getUid());
        num=totalPage;
        if (totalPage%pageSize==0){
            setTotalPage(totalPage/pageSize);
        }else {
            setTotalPage(totalPage/pageSize+1);
        }
        if (pageCode==null){
            setPageCode(1);
        }
        favoriteList=favoriteService.findByUid(user.getUid(),(pageCode-1)*pageSize,pageSize);
        goodsList= new ArrayList<Goods>();
        for (int i = 0; i<favoriteList.size();i++){
            Favorite favorite1=favoriteList.get(i);
            Goods goods=goodsService.findGoodsByGid(favorite1.getGid());
            goodsList.add(goods);
        }
        return "tofavorite";
    }
    public String delete(){
        System.out.println(Arrays.toString(gid));
        User user=(User)ActionContext.getContext().getSession().get("loginUser");
        System.out.println(user.getUid());
        int num=favoriteService.delete(gid,user.getUid());
        HttpServletResponse response= ServletActionContext.getResponse();
            return "tofavorite";
    }
    public String[] getGid() {
        return gid;
    }

    public void setGid(String[] gid) {
        this.gid = gid;
    }

    public Favorite getFavorite() {
        return favorite;
    }

    public void setFavorite(Favorite favorite) {
        this.favorite = favorite;
    }

    public List<Favorite> getFavoriteList() {
        return favoriteList;
    }

    public void setFavoriteList(List<Favorite> favoriteList) {
        this.favoriteList = favoriteList;
    }

    public List<Goods> getGoodsList() {
        return goodsList;
    }

    public void setGoodsList(List<Goods> goodsList) {
        this.goodsList = goodsList;
    }

    public int getPageCode() {
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

    public int getNum() {
        return num;
    }

    public void setNum(int num) {
        this.num = num;
    }
}
