package com.qst.grade.dao.Impl;

import com.qst.grade.dao.UserDao;
import com.qst.grade.po.User;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.stereotype.Repository;

import javax.annotation.Resource;
import java.util.List;

@Repository
public class UserDaoImpl extends HibernateTemplate implements UserDao {

    @Resource(name = "sessionFactory")
    public void setSessionFactory(SessionFactory sessionFactory) {
        super.setSessionFactory(sessionFactory);
    }

    @Override
    public String addUser(User user) {
        return (String) super.save(user);
    }

    @Override
    public boolean updateUser(User user) {
        super.update(user);
        return true;
    }

    @Override
    public List<User> findByMail(String mail) {
        Query query = super.getSession().createSQLQuery("select * from user where mail = ?").addEntity(User.class);
        query.setString(0, mail);
        return query.list();
    }

    @Override
    public List<User> findByPhone(String phone) {
        Query query = super.getSession().createSQLQuery("select * from user where telphone = ?").addEntity(User.class);
        query.setString(0, phone);
        return query.list();
    }

    @Override
    public List<User> findByMailAndPass(String mail, String pass) {
        Query query = super.getSession().createSQLQuery("select * from user where mail = ? and pass = ?").addEntity(User.class);
        query.setString(0, mail);
        query.setString(1, pass);
        return query.list();
    }

    @Override
    public List<User> findByPhoneAndPass(String phone, String pass) {
        Query query = super.getSession().createSQLQuery("select * from user where telphone = ? and pass = ?").addEntity(User.class);
        query.setString(0, phone);
        query.setString(1, pass);
        return query.list();
    }

    @Override
    public User findByuId(String uid) {
        System.out.println((uid));
        Query query = super.getSession().createSQLQuery("select * from user where uid = ?").addEntity(User.class);
        query.setString(0,uid);
        return (User) query.uniqueResult();
    }

    @Override
    public List<User> findAll() {
        Query query = super.getSession().createQuery("from  User ORDER BY status");
        return query.list();
    }

    @Override
    public Integer findAllByCount() {
        Query query = super.getSession().createSQLQuery("select count(*) from user");
        return Integer.valueOf(query.uniqueResult().toString());
    }

    @Override
    public Integer addGold(String uid, int number) {
        Query query = super.getSession().createSQLQuery("update `user` set  gold = gold + ? where uid = ?");
        query.setInteger(0, number);
        query.setString(1, uid);
        return query.executeUpdate();
    }

    @Override
    public Integer subGold(String uid, int number) {
        Query query = super.getSession().createSQLQuery("update `user` set  gold = gold - ? where uid = ?");
        query.setInteger(0, number);
        query.setString(1, uid);
        return query.executeUpdate();
    }
}
