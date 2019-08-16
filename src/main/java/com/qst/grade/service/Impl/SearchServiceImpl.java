package com.qst.grade.service.Impl;

import com.qst.grade.dao.SearchDao;
import com.qst.grade.po.Category;
import com.qst.grade.po.Goods;
import com.qst.grade.service.SearchService;
import com.qst.grade.util.PinYinUtil;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.math.BigDecimal;
import java.util.List;

@Service
@Transactional
public class SearchServiceImpl implements SearchService {
    private SearchDao searchDao;


    @Autowired
    public SearchServiceImpl(SearchDao searchDao) {
        this.searchDao = searchDao;
    }

    @Override
    public JSONObject findAllByNameAndPrice1AndPrice2AndCid(String name, Double price1, Double price2, String cid,int page) {
        List<Goods> goods = searchDao.findAllByNameAndPriceAndCid(name,price1,price2,cid,page * 30);
        int totalPage = searchDao.findCountByNameAndPriceAndCid(name,price1,price2,cid);
        if (totalPage > 0 ){
            if (totalPage % 30 == 0){
                totalPage /= 30;
            } else {
                totalPage = totalPage / 30 + 1;
            }
        }
        JSONObject localJSONObject = new JSONObject();
        localJSONObject.put("page",page);
        localJSONObject.put("totalPage",totalPage);
        localJSONObject.put("GoodsList", JSONArray.fromObject(goods));
        System.err.println(totalPage);
        System.out.println(goods);
        return localJSONObject;
    }

    @Override
    public List<Category> listCategory() {
        return searchDao.listCategory();
    }

    @Override
    public List<Goods> listGoodsByName(String title) {
        String acronym = PinYinUtil.getAcronym(title);
        String fullPinYin = PinYinUtil.getFullPinYinWithoutNumber(title);
        String name = getVagueStr(title,1);
        acronym = getVagueStr(acronym,1);
        fullPinYin = getVagueStr(fullPinYin,2);
        System.out.println(name);
        System.out.println(acronym);
        System.out.println(fullPinYin);
        return searchDao.listGoodsByNameAndPinYin(title, acronym, fullPinYin);
    }

    private String getVagueStr(String str, int type){
        StringBuffer result = new StringBuffer(16);
        if (str == null){
            return result.toString();
        }
        if (type == 1){
            for(int i = 0; i < str.length(); i++) {
                result.append("%");
                result.append(str.charAt(i));
            }
            result.append("%");
        } else if (type == 2){
            result.append("%");
            result.append(str.replaceAll("\\d","%"));
            result.append("%");
        }
        return result.toString();
    }
}
