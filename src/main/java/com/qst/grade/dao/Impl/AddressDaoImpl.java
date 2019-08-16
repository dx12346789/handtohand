package com.qst.grade.dao.Impl;

import com.qst.grade.dao.AddressDao;
import com.qst.grade.po.Address;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.stereotype.Repository;

import javax.annotation.Resource;
import java.util.List;

@Repository
public class AddressDaoImpl extends HibernateTemplate implements AddressDao {
    @Resource(name = "sessionFactory")
    public void setSessionFactory(SessionFactory sessionFactory) {
        super.setSessionFactory(sessionFactory);
    }

    @Override
    public Address findByAid(String aid) {
        Query query = super.getSession().createSQLQuery("select * from address where aid = ?").addEntity(Address.class);
        query.setString(0, aid);
        return (Address) query.uniqueResult();
    }

    @Override
    public List<Address> findByUid(String uid) {
        Session session = super.getSession();
        Query query = session.createQuery("from Address where uid=?");
        query.setString(0, uid);
        return query.list();
    }

    @Override
    public String addAddress(Address address) {
        String sId = (String) super.save(address);
        return sId;
    }

    @Override
    public boolean updateAddress(Address address) {
        super.update(address);
        return true;
    }

    @Override
    public boolean delAddress(String aId) {
        super.delete(findByAid(aId));
        return true;
    }
}
