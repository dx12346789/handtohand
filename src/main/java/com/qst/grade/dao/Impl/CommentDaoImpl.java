package com.qst.grade.dao.Impl;

import com.qst.grade.dao.CommentDao;
import com.qst.grade.po.Comment;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.stereotype.Repository;

import javax.annotation.Resource;
import java.math.BigInteger;
import java.util.List;

@Repository
public class CommentDaoImpl extends HibernateTemplate implements CommentDao {
    @Resource(name = "sessionFactory")
    public void setSessionFactory(SessionFactory sessionFactory){
         super.setSessionFactory(sessionFactory);
    }
    public Session before(){
        SessionFactory sessionFactory=super.getSessionFactory();
        assert sessionFactory!=null;
        return sessionFactory.getCurrentSession();
    }
    @Override
    public List<Comment> findByGid(String gid) {
        Query query=super.getSession().createSQLQuery("select * from `comment` where gid=? order by create_time desc ").addEntity(Comment.class);
        query.setString(0,gid);
        return query.list();
    }

    @Override
    public String savecomment(Comment comment) {
        return (String) super.save(comment);
    }

    @Override
    public Comment findByOid(String oid) {
        Query query = super.getSession().createSQLQuery("select * " +
                "from `comment` " +
                "WHERE o_did = ? AND respondent is ?").addEntity(Comment.class);
        query.setString(0,oid);
        query.setString(1,null);
        return (Comment) query.uniqueResult();
    }

    @Override
    public int count(String gid) {
        Query query=super.getSession().createSQLQuery("select count(*) from `comment` where gid=? and respondent is ?");
        query.setString(0,gid);
        query.setString(1,null);
        return ((BigInteger)query.uniqueResult()).intValue();
    }
}
