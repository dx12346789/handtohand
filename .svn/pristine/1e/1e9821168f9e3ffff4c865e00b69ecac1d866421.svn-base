package com.qst.grade.action;

import com.qst.grade.po.Category;
import com.qst.grade.po.Goods;
import com.qst.grade.service.SearchService;
import net.sf.json.JSONObject;
import org.apache.struts2.ServletActionContext;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import java.math.BigDecimal;
import java.util.List;

@Controller
public class SearchAction {
    private SearchService searchService;
    private String title;
    private Double price1;
    private Double price2;
    private String cid;
    private List<Category> categoryList;
    private List<Goods> goodsList;

    private Integer page;

    private JSONObject jsonObject;

    @Autowired
    public SearchAction(SearchService searchService) {
        this.searchService = searchService;
    }

    public String search() {
        String t = ServletActionContext.getRequest().getParameter("type");
        System.out.println(t);
        System.out.println(title + "----" + price1 + "-----" + price2 + "------" + cid);
        System.out.println(page);
        JSONObject localJSONObject;
        if (null == price1 || price1 < 0) {
            price1 = null;
        }
        if (null == price2 || price2 < 0) {
            price2 = null;
        }
        if (page == null){
            localJSONObject = searchService.findAllByNameAndPrice1AndPrice2AndCid(title, price1, price2, cid, 0);
        } else {
            localJSONObject = searchService.findAllByNameAndPrice1AndPrice2AndCid(title,price1,price2,cid,page);
        }
        if (null != title) {
            localJSONObject.put("title", title);
        }
        jsonObject = new JSONObject();
        jsonObject.put("status", "200");
        jsonObject.put("msg", "OK");
        jsonObject.put("data", localJSONObject);
        System.out.println(jsonObject);
        if (t != null) {
            return "toSearch";
        }
        return "success";
    }

    public String getGoodsType() {
        categoryList = searchService.listCategory();
        System.out.println(categoryList);
        return "success";
    }

    public String getGoodsTitle() {
        goodsList = searchService.listGoodsByName(title);
        return "success";
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public Double getPrice1() {
        return price1;
    }

    public void setPrice1(Double price1) {
        this.price1 = price1;
    }

    public Double getPrice2() {
        return price2;
    }

    public void setPrice2(Double price2) {
        this.price2 = price2;
    }

    public String getCid() {
        return cid;
    }

    public void setCid(String cid) {
        this.cid = cid;
    }

    public JSONObject getJsonObject() {
        return jsonObject;
    }

    public void setJsonObject(JSONObject jsonObject) {
        this.jsonObject = jsonObject;
    }

    public Integer getPage() {
        return page;
    }

    public void setPage(Integer page) {
        this.page = page;
    }

    public List<Category> getCategoryList() {
        return categoryList;
    }

    public void setCategoryList(List<Category> categoryList) {
        this.categoryList = categoryList;
    }

    public List<Goods> getGoodsList() {
        return goodsList;
    }

    public void setGoodsList(List<Goods> goodsList) {
        this.goodsList = goodsList;
    }

}
