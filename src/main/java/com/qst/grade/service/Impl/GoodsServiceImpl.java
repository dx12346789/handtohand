package com.qst.grade.service.Impl;

import com.qst.grade.dao.GoodsDao;
import com.qst.grade.po.Goods;
import com.qst.grade.po.User;
import com.qst.grade.redis.JedisClient;
import com.qst.grade.redis.RedisCacheUtil;
import com.qst.grade.service.GoodsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class GoodsServiceImpl implements GoodsService {

    private GoodsDao goodsDao;

    @Autowired
    public GoodsServiceImpl(GoodsDao goodsDao){
        this.goodsDao=goodsDao;
    }

    @Override
    public String addGoods(Goods goods) {
        return goodsDao.addGoods(goods);
    }

    @Override
    public Goods findGoodsByGid(String gid) {
        return goodsDao.findGoodsByGid(gid);
    }

    @Override
    public List<Goods> findGoodsByUid(String uid, Integer pageCode,int pageSize) {
        return goodsDao.findGoodsByUid(uid,pageCode,pageSize);
    }

    @Override
    public Integer makeGoodsStatusToRemoveShelf(String gid) {
        return goodsDao.makeGoodsStatusToRemoveShelf(gid);
    }

    @Override
    public Integer makeGoodsStatusToOnShelf(String gid) {
        return goodsDao.makeGoodsStatusToOnShelf(gid);
    }

    @Override
    public Integer makeGoodsStatusToDelete(String gid) {
        return goodsDao.makeGoodsStatusToDelete(gid);
    }

    @Override
    public int count(String uid) {
        return goodsDao.count(uid);
    }
    @Override
    public void addGoodsHit(String gid) {
        goodsDao.addGoodsHit(gid);
    }

    @Override
    public void updateMyGoods(Goods goods) {
        goodsDao.updateMyGoods(goods);
    }

    @Override
    public int countOnOrDownShelfGoodsNum(String uid, int status) {
        return goodsDao.countOnOrDownShelfGoodsNum(uid,status);
    }

    @Override
    public void judgeHit(String gid, User user) {
        JedisClient jedisClient = RedisCacheUtil.getJedisClient();
        String uids = null;
        String key = gid + "_" + user.getUid();
        if (jedisClient.exists(key)){
            uids = jedisClient.get(key);
        }
        if (null == uids) {
            uids = user.getUid();
            jedisClient.set(key, uids);
            jedisClient.expire(key, 60 * 30);
            goodsDao.addGoodsHit(gid);
        } else {
            if (!uids.contains(user.getUid())) {
                uids += "," + user.getUid();
                jedisClient.set(key, uids);
                jedisClient.expire(key, 60 * 30);
                goodsDao.addGoodsHit(gid);
            }
        }
    }

    @Override
    public List<Goods> findAllByHit(int page,int num) {
        return goodsDao.findAllByPageAndOffset(page,num);
    }

}
