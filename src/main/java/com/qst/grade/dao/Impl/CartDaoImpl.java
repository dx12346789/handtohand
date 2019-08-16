package com.qst.grade.dao.Impl;

import com.qst.grade.dao.CartDao;
import com.qst.grade.po.ShopCart;
import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.hibernate.classic.Session;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.stereotype.Repository;

import javax.annotation.Resource;
import java.math.BigInteger;
import java.util.List;

@Repository
public class CartDaoImpl extends HibernateTemplate implements CartDao {

    @Resource(name = "sessionFactory")
    public void setSessionFactory(SessionFactory sessionFactory) {
        super.setSessionFactory(sessionFactory);
    }

    private Session before(){
        SessionFactory sessionFactory = super.getSessionFactory();
        assert sessionFactory != null;
        return sessionFactory.getCurrentSession();
    }

    @Override
    public List<ShopCart> findAllByUid(String uid) {
        Session session = this.before();
        Query query = session.createSQLQuery("select * from `shop_cart` where uid = ?").addEntity(ShopCart.class);
        query.setString(0,uid);
        return query.list();
    }

    @Override
    public ShopCart findByUidGid(String uid, String gid) {
        Query query=super.getSession().createQuery("from ShopCart where uid=? and gid=?");
        query.setString(0,uid);
        query.setString(1,gid);
        return (ShopCart)query.uniqueResult();
    }

    @Override
    public String addCart(ShopCart shopCart) {
        return (String)super.save(shopCart);
    }

    @Override
    public int updateCount(ShopCart shopCart) {
        Query query=super.getSession().createSQLQuery("update `shop_cart` set count=? where sid=?");
        query.setInteger(0,shopCart.getCount());
        query.setString(1,shopCart.getSid());
        return query.executeUpdate();
    }

    @Override
    public Integer getAllOfGoodsNumberByUid(String uid) {
        Session session = this.before();
        Query query = session.createSQLQuery("select count(*) from `shop_cart` where uid = ?");
        query.setString(0, uid);
        return ((BigInteger) query.uniqueResult()).intValue();
    }

    @Override
    public Integer getAllOfInvalidNumberByUid(String uid) {
        Session session = this.before();
        Query query = session.createSQLQuery("select count(*) from `goods` where\n" +
                "status != 0 and gid in (select gid from `shop_cart` where uid = ?)");
        query.setString(0, uid);
        return ((BigInteger) query.uniqueResult()).intValue();
    }

    @Override
    public Integer changeShopCartItem(String gid, int num) {
        Session session = this.before();
        Query query = session.createSQLQuery("update `shop_cart` set count = ? where gid = ?");
        query.setInteger(0, num);
        query.setString(1, gid);
        return query.executeUpdate();
    }

    @Override
    public int deleteOrderItem(String sid) {
        Session session = this.before();
        Query query = session.createSQLQuery("delete from `shop_cart` where sid = ?");
        query.setString(0, sid);
        return query.executeUpdate();
    }

    @Override
    public ShopCart findAllByGidAndUid(String gid, String uid) {
        Session session = this.before();
        Query query = session.createSQLQuery("select * from `shop_cart` where gid = ? and uid = ? order by gid").addEntity(ShopCart.class);
        query.setString(0, gid);
        query.setString(1, uid);
        return (ShopCart) query.uniqueResult();
    }

    @Override
    public ShopCart findBySid(String sid) {
        Session session = this.before();
        Query query = session.createQuery("from ShopCart where sid = ?");
        query.setString(0, sid);
        return (ShopCart) query.uniqueResult();
    }

}
