package com.qst.grade.dao.Impl;

import com.qst.grade.dao.OrderDetailDao;
import com.qst.grade.po.OrderDetail;
import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.hibernate.classic.Session;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.stereotype.Repository;

import javax.annotation.Resource;
import java.math.BigInteger;
import java.util.List;

@Repository
public class OrderDetailDaoImpl extends HibernateTemplate implements OrderDetailDao {

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
    public String save(OrderDetail orderDetail) {
        return (String) super.save(orderDetail);
    }

    @Override
    public List<OrderDetail> findorderpayerAll(String uid) {
        Query query = super.getSession().createSQLQuery("SELECT * FROM order_detail where buyyer=?").addEntity(OrderDetail.class);
        query.setString(0, uid);
        return query.list();
    }

    @Override
    public List<OrderDetail> findordersellerAll(String uid) {
        Query query = super.getSession().createSQLQuery("SELECT * FROM order_detail where seller=?").addEntity(OrderDetail.class);
        query.setString(0, uid);
        return query.list();
    }

    @Override
    public OrderDetail findByODid(String odid){
        Query query = super.getSession().createSQLQuery("SELECT * FROM order_detail where o_did = ?").addEntity(OrderDetail.class);
        query.setString(0, odid);
        List<OrderDetail> orderDetail = query.list();
        System.out.println(orderDetail.size());
        return orderDetail.get(0);
    }

    @Override
    public void updateorderDetail(OrderDetail orderDetail) {
        super.update(orderDetail);
    }

    @Override
    public List<OrderDetail> findAll() {
        Query query = super.getSession().createSQLQuery("select * from order_detail").addEntity(OrderDetail.class);

        return query.list();
    }

    @Override
    public Integer getSellNumber(String uid) {
        Query quqry = super.getSession().createSQLQuery("select count(*) from order_detail where seller = ?");
        quqry.setString(0, uid);
        return ((BigInteger) quqry.uniqueResult()).intValue();
    }

    @Override
    public Integer getBuyNumber(String uid) {
        Query quqry = super.getSession().createSQLQuery("select count(*) from order_detail where buyyer = ?");
        quqry.setString(0, uid);
        return ((BigInteger) quqry.uniqueResult()).intValue();
    }


}
