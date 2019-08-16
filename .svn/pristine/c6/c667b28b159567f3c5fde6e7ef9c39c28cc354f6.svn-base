package com.qst.grade.action;

import com.qst.grade.po.Goods;
import com.qst.grade.service.IndexService;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;

import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

public class IndexAction {


    private final IndexService indexService;

    @Autowired
    public IndexAction(IndexService indexService) {
        this.indexService = indexService;
    }

    private Integer totalPage;
    private Integer cuurentPage;
    private Integer sell;
    private Integer buy;
    private String uid;
    private List<Goods> goodsList;

    public String toIndex(){
        System.out.println(totalPage);
        System.out.println(cuurentPage);
        if (totalPage == null) {
            totalPage = indexService.getTotalPage();
        }
        if (cuurentPage == null) {
            cuurentPage = 1;
        }
        if (cuurentPage > totalPage){
            cuurentPage = totalPage;
        }
        if (cuurentPage <= 0) {
            cuurentPage = 1;
        }
        goodsList = indexService.getGoods(cuurentPage - 1, totalPage);
        return "success";
    }

    public void getBuyNumber(){
        buy = indexService.getBuyNumber(uid);
        HttpServletResponse response = ServletActionContext.getResponse();
        try {
            response.getWriter().print(buy);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public void getSellNumber(){
        sell = indexService.getSellBumber(uid);
        HttpServletResponse response = ServletActionContext.getResponse();
        try {
            response.getWriter().print(sell);
        } catch (IOException e) {
            e.printStackTrace();
        }
    }

    public Integer getTotalPage() {
        return totalPage;
    }

    public void setTotalPage(Integer totalPage) {
        this.totalPage = totalPage;
    }

    public Integer getCuurentPage() {
        return cuurentPage;
    }

    public void setCuurentPage(Integer cuurentPage) {
        this.cuurentPage = cuurentPage;
    }

    public List<Goods> getGoodsList() {
        return goodsList;
    }

    public void setGoodsList(List<Goods> goodsList) {
        this.goodsList = goodsList;
    }

    public Integer getSell() {
        return sell;
    }

    public void setSell(Integer sell) {
        this.sell = sell;
    }

    public Integer getBuy() {
        return buy;
    }

    public void setBuy(Integer buy) {
        this.buy = buy;
    }

    public String getUid() {
        return uid;
    }

    public void setUid(String uid) {
        this.uid = uid;
    }
}
