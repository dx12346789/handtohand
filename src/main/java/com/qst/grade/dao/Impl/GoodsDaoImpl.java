package com.qst.grade.dao.Impl;

import com.qst.grade.dao.GoodsDao;
import com.qst.grade.po.Goods;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.hibernate.Transaction;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.stereotype.Repository;

import javax.annotation.Resource;
import java.math.BigInteger;
import java.util.List;

@Repository
public class GoodsDaoImpl extends HibernateTemplate implements GoodsDao {

    @Resource(name = "sessionFactory")
    public void setSessionFactory(SessionFactory sessionFactory) {
        super.setSessionFactory(sessionFactory);
    }

    private Session before() {
        SessionFactory sessionFactory = super.getSessionFactory();
        assert sessionFactory != null;
        return sessionFactory.getCurrentSession();
    }

    @Override
    public String addGoods(Goods goods) {
        return (String) super.save(goods);
    }

    /**
     * 按Gid查找goods表所有信息
     *
     * @return
     */
    @Override
    public Goods findGoodsByGid(String gid) {
        Session session = this.before();
        Query query = session.createQuery("from Goods where gid=?");
        query.setString(0, gid);
        return (Goods) query.uniqueResult();
    }

    @Override
    public List<Goods> findBytypeid(String typeid) {
        Query query = super.getSession().createSQLQuery("select * from goods where cid = ?").addEntity(Goods.class);
        query.setString(0,typeid);
        return query.list();
    }

    @Override
    public Integer updateCountByGid(String gid, int count) {
        Session session = this.before();
        Query query = session.createSQLQuery("update `goods` set count = count - ? where gid = ?");
        query.setInteger(0, count);
        query.setString(1, gid);
        return query.executeUpdate();
    }

    @Override
    public List<Goods> findGoodsByUid(String uid, Integer pageCode,int pageSize) {
        Query query = super.getSession().createSQLQuery("select * from `goods` where uid=? limit ?,?").addEntity(Goods.class);
        query.setString(0,uid);
        query.setInteger(1,pageCode);
        query.setInteger(2,pageSize);
        return query.list();
    }

    @Override
    public Integer  makeGoodsStatusToRemoveShelf(String gid) {
        Query query=super.getSession().createSQLQuery("update goods set status=? where gid=?");
        query.setInteger(0,2);
        query.setString(1,gid);
        return query.executeUpdate();
    }

    @Override
    public Integer makeGoodsStatusToOnShelf(String gid) {
        Query query=super.getSession().createSQLQuery("update goods set status=? where gid=?");
        query.setInteger(0,0);
        query.setString(1,gid);
        return query.executeUpdate();
    }

    @Override
    public Integer makeGoodsStatusToDelete(String gid) {
        Query query=super.getSession().createSQLQuery("update goods set status=? where gid=?");
        query.setInteger(0,1);
        query.setString(1,gid);
        return query.executeUpdate();
    }

    @Override
    public int count(String uid) {
        Query query=super.getSession().createSQLQuery("select count(*) from `goods` where uid=?");
        query.setString(0,uid);
        return ((BigInteger)query.uniqueResult()).intValue();
    }
    @Override
    public void addGoodsHit(String uid) {
        Query query = super.getSession().createSQLQuery("update `goods` set hit = hit + 1 where gid = ?");
        query.setString(0, uid);
        query.executeUpdate();
    }

    @Override
    public void updateMyGoods(Goods goods) {
        super.update(goods);
    }

    @Override
    public int countOnOrDownShelfGoodsNum(String uid, int status) {
        Query query=super.getSession().createSQLQuery("select count(*) from goods where uid=? and status=?");
        query.setString(0,uid);
        query.setInteger(1,status);
        return ((BigInteger)query.uniqueResult()).intValue();
    }

    @Override
    public Integer getTotalCount() {
        Query query = super.getSession().createSQLQuery("select count(*) from `goods`");
        return ((BigInteger)query.uniqueResult()).intValue();
    }

    @Override
    public List<Goods> findAllByPageAndOffset(Integer page, Integer offset) {
        Query query = super.getSession().createSQLQuery("select * from `goods` where status = 0 order by hit DESC limit ?,?").addEntity(Goods.class);
        query.setInteger(0, page * offset);
        query.setInteger(1, offset);
        return query.list();
    }

}
