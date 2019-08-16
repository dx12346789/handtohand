package com.qst.grade.dao.Impl;

import com.qst.grade.dao.FavoriteDao;
import com.qst.grade.po.Favorite;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.stereotype.Repository;

import javax.annotation.Resource;
import java.math.BigInteger;
import java.util.List;

@Repository
public class FavoriteDaoImpl extends HibernateTemplate implements FavoriteDao {
    @Resource(name = "sessionFactory")
    public void setSessionFactory(SessionFactory sessionFactory){
        super.setSessionFactory(sessionFactory);
    }

    @Override
    public String add(Favorite favorite) {
        return (String)super.save(favorite);
    }

    @Override
    public Favorite findByGidUid(String gid, String uid) {
        Session session=super.getSession();
        Query query=session.createQuery("from Favorite where uid=? and gid=?");
        query.setString(0,uid);
        query.setString(1,gid);
        return (Favorite) query.uniqueResult();
    }

    @Override
    public int delete(String[] gid, String uid) {
       Query query=super.getSession().createSQLQuery("delete from `favorite` where uid = ? and gid = ?");
       int num=0;
        System.out.println("gidsize="+gid.length);
       for (int i = 0;i<gid.length;i++){
           query.setString(0, uid);
           query.setString(1, gid[i]);
           num +=query.executeUpdate();
       }
        System.out.println(num);
        return num;
    }

    @Override
    public List<Favorite> findByUid(String uid,Integer pageCode,int pageSize) {
        Query query=super.getSession().createSQLQuery("select * from `favorite` where uid=? order by add_time desc limit ?,?").addEntity(Favorite.class);
        query.setString(0,uid);
        query.setInteger(1,pageCode);
        query.setInteger(2,pageSize);
        return (List<Favorite>)query.list();
    }

    @Override
    public int count(String uid) {
        Query query=super.getSession().createSQLQuery("select count(*) from `favorite` where uid = ?");
        query.setString(0, uid);
        return ((BigInteger)query.uniqueResult()).intValue();
    }
}
