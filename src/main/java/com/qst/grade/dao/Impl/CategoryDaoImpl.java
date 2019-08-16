package com.qst.grade.dao.Impl;

import com.qst.grade.dao.CategoryDao;
import com.qst.grade.po.Category;
import com.qst.grade.util.UUID;
import org.hibernate.Query;
import org.hibernate.Session;
import org.hibernate.SessionFactory;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.stereotype.Repository;

import javax.annotation.Resource;
import java.util.List;
@Repository
public class CategoryDaoImpl extends HibernateTemplate implements CategoryDao {

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
    public List<Category> findAllCategory() {
        Query query = super.getSession().createSQLQuery("select * from category").addEntity(Category.class);
        return query.list();
    }
    @Override
    public Category findCategoryByCid(String cid) {
        Session session=this.before();
        Query query=session.createQuery("from Category where cid=?");
        query.setString(0,cid);
        return (Category)query.uniqueResult();
    }

    @Override
    public void deltype(Category cate) {


        super.delete(cate);


    }

    @Override
    public String addtype(Category cate) {

      return (String) super.save(cate);
    }

    @Override
    public Category findBytype(String typename) {
        Query query = super.getSession().createSQLQuery("select * from category where name = ?").addEntity(Category.class);
        query.setString(0,typename);
        return (Category) query.uniqueResult();
    }
}
