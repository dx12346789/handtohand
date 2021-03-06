package com.qst.grade.service.Impl;

import com.qst.grade.dao.FavoriteDao;
import com.qst.grade.po.Favorite;
import com.qst.grade.service.FavoriteService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@Transactional
public class FavoriteServiceImpl implements FavoriteService {
    private final FavoriteDao favoriteDao;

    @Autowired
    public FavoriteServiceImpl(FavoriteDao favoriteDao) {
        this.favoriteDao = favoriteDao;
    }

    @Override
    public String add(Favorite favorite) {
        System.out.println("favorite="+favoriteDao.add(favorite));
        return favoriteDao.add(favorite);
    }

    @Override
    public Favorite findByGidUid(String gid, String uid) {
        return favoriteDao.findByGidUid(gid,uid);
    }

    @Override
    public int delete(String[] gid, String Uid) {
        return favoriteDao.delete(gid, Uid);
    }

    @Override
    public List<Favorite> findByUid(String uid,Integer pageCode,int pageSize) {
        return favoriteDao.findByUid(uid,pageCode,pageSize);
    }

    @Override
    public int count(String uid) {
        return favoriteDao.count(uid);
    }
}
