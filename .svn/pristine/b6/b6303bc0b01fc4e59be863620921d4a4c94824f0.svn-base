package com.qst.grade.dao.Impl;

import com.qst.grade.dao.NoticDao;
import com.qst.grade.po.Notic;
import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.stereotype.Repository;

import javax.annotation.Resource;
import java.util.List;

@Repository
public class NoticDaoImpl extends HibernateTemplate implements NoticDao {
    @Resource(name = "sessionFactory")
    public void setSessionFactory(SessionFactory sessionFactory){
        super.setSessionFactory(sessionFactory);
    }
    @Override
    public String addNotic(Notic notic) {
        return (String) super.save(notic);
    }

    @Override
    public List<Notic> findAll() {
        Query query = super.getSession().createSQLQuery("select * from notic").addEntity(Notic.class);
        return query.list();
    }

    @Override
    public Notic findByNid(String nid) {
        Query query = super.getSession().createSQLQuery("select * from notic where nid = ?").addEntity(Notic.class);
        query.setString(0,nid);
        return (Notic) query.uniqueResult();
    }

    @Override
    public boolean updateNotic(Notic notic) {
        super.update(notic);
        return true;
    }
}
