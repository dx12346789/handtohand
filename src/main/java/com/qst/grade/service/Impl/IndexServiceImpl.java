package com.qst.grade.service.Impl;

import com.qst.grade.dao.GoodsDao;
import com.qst.grade.dao.OrderDetailDao;
import com.qst.grade.po.Goods;
import com.qst.grade.redis.JedisClient;
import com.qst.grade.redis.RedisCacheUtil;
import com.qst.grade.service.IndexService;
import net.sf.json.JSON;
import net.sf.json.JSONArray;
import net.sf.json.JSONObject;
import net.sf.json.JsonConfig;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import redis.clients.jedis.Jedis;

import java.io.*;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Service
public class IndexServiceImpl implements IndexService {
    private final GoodsDao goodsDao;
    private final OrderDetailDao orderDetailDao;

    private final int OFFSET = 30;  //每页个数

    @Autowired
    public IndexServiceImpl(GoodsDao goodsDao, OrderDetailDao orderDetailDao) {
        this.goodsDao = goodsDao;
        this.orderDetailDao = orderDetailDao;
    }

    @Override
    public Integer getTotalPage() {
        Integer result = goodsDao.getTotalCount();
        if (result == null || result == 0) {
            return 0;
        }
        if (result % 6 == 0) {
            return result / 6;
        } else {
            return result / 6 + 1;
        }
    }

    @Override
    public List<Goods> getGoods(Integer currentPage, Integer totalPage) {
        JedisClient jedisClient = RedisCacheUtil.getJedisClient();
        List<Goods> goodsList;
        if (!jedisClient.exists("0")) {
            System.out.println("没有key");
            goodsList = goodsDao.findAllByPageAndOffset(currentPage, OFFSET);
            saveRedis(jedisClient, goodsList);
        } else{
                goodsList = readRedis(jedisClient);
        }
        return goodsList;
    }

    @Override
    public Integer getSellBumber(String uid) {
        return orderDetailDao.getSellNumber(uid);
    }

    @Override
    public Integer getBuyNumber(String uid) {
        return orderDetailDao.getBuyNumber(uid);
    }

    private void saveRedis(JedisClient jedisClient, List<Goods> goodsList) {

        int length = goodsList.size();
        JSONArray array = new JSONArray();
        for (int i = 0; i < length; i++) {
            Goods goods = goodsList.get(i);
            JSONObject jsonObject = JSONObject.fromObject(goods);
            array.add(jsonObject);
        }
//        jedisClient.rpush("0",array.toString());
        jedisClient.set("0",array.toString());
        jedisClient.expire("0",60 * 30);
    }

    private List<Goods> readRedis(JedisClient jedisClient) {
//        List<String> list = jedisClient.lrange("0",0,-1);
        String str = jedisClient.get("0");
        JSONArray jsonArray = JSONArray.fromObject(str);
        List<?> goodsList = JSONArray.toList(jsonArray, new Goods(), new JsonConfig());

        return (List<Goods>) goodsList;
    }



}
