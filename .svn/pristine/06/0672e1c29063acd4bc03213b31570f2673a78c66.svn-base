package com.qst.grade.dao;

import com.qst.grade.po.Category;
import com.qst.grade.po.Goods;

import java.math.BigDecimal;
import java.util.List;

public interface SearchDao {
    int findCountByNameAndPriceAndCid(String name, Double price1,Double price2,String cIds);
    List<Goods> findAllByNameAndPriceAndCid(String name, Double price1,Double price2,String cIds,int num);
    List<Category> listCategory();
    List<Goods> listGoodsByNameAndPinYin(String title, String acronym, String fullPinYin);
}
