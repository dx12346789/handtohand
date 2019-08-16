package com.qst.grade.dao.Impl;

import com.alipay.api.domain.Product;
import com.qst.grade.dao.SearchDao;
import com.qst.grade.po.Category;
import com.qst.grade.po.Goods;
import org.hibernate.Criteria;
import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.hibernate.criterion.Restrictions;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.stereotype.Repository;

import javax.annotation.Resource;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.List;

@Repository
public class SearchDaoImpl extends HibernateTemplate implements SearchDao {
    @Resource(name = "sessionFactory")
    public void setSessionFactory(SessionFactory sessionFactory) {
        super.setSessionFactory(sessionFactory);
    }

    public int findCountByNameAndPriceAndCid(String name, Double price1, Double price2, String cIds){
        Criteria criteria = findAllByNameAndPriceAndCid(name,price1,price2,cIds);
        return criteria.list().size();
    }

    @Override
    public List<Goods> findAllByNameAndPriceAndCid(String name, Double price1, Double price2, String cIds,int num) {
        Criteria criteria = findAllByNameAndPriceAndCid(name,price1,price2,cIds);
        criteria.setFirstResult(num);
        criteria.setMaxResults(30);
        return criteria.list();
    }

    @Override
    public List<Category> listCategory() {
        Query query = super.getSession().createQuery("from Category");
        return query.list();
    }

    @Override
    public List<Goods> listGoodsByNameAndPinYin(String title, String acronym, String fullPinYin) {
        Query query = super.getSession().createQuery("from Goods where name like ? or acronym like ? or fullpinyin like ?");
        query.setString(0, title);
        query.setString(1, acronym);
        query.setString(2, fullPinYin);
        return query.list();
    }

    private Criteria findAllByNameAndPriceAndCid(String name, Double price1, Double price2, String cIds){
        Criteria c = super.getSession().createCriteria(Goods.class);
        c.setCacheable(true);
        c.add(Restrictions.eq("status",0));
        if (name != null && !"".equals(name.trim())) {
            c.add(Restrictions.like("name", "%" + name + "%"));
        }

        if (price1 != null) {
            c.add(Restrictions.ge("price", price1));
        }
        if (price2 != null) {
            c.add(Restrictions.le("price", price2));
        }
        if (cIds != null) {
            c.add(Restrictions.eq("cid", cIds));
        }
        return c;
    }
}
