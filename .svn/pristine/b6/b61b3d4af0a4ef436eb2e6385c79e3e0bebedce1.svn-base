package com.qst.grade.dao.Impl;

import com.qst.grade.dao.MessageDao;
import com.qst.grade.po.Message;
import org.hibernate.Query;
import org.hibernate.SessionFactory;
import org.hibernate.classic.Session;
import org.springframework.orm.hibernate3.HibernateTemplate;
import org.springframework.stereotype.Repository;

import javax.annotation.Resource;
import java.math.BigInteger;
import java.util.Date;
import java.util.List;

@Repository
public class MessageDaoImpl extends HibernateTemplate implements MessageDao {
    @Resource(name = "sessionFactory")
    public void setSessionFactory(SessionFactory sessionFactory){
        super.setSessionFactory(sessionFactory);
    }

    private Session before(){
        SessionFactory sessionFactory = super.getSessionFactory();
        assert sessionFactory != null;
        return sessionFactory.openSession();
    }

    @Override
    public String save(Message message) {
        return (String) super.save(message);
    }

    @Override
    public List<String> findAllByUid(String uid) {
        Session session = super.getSessionFactory().openSession();
        Query query = session.createSQLQuery("SELECT sender from `message` where recipient= ?\n " +
                " UNION \n" +
                " SELECT recipient from `message` where sender= ?");
        query.setString(0, uid);
        query.setString(1, uid);
        return query.list();
    }

    @Override
    public List<Message> findHistoryMessage(String srcId, String destId, Date time) {
        Session session = this.before();
        Query query = session.createSQLQuery("SELECT * FROM `message` WHERE send_time < ? AND \n" +
                "((sender = ? AND recipient = ?)\n" +
                "OR\n" +
                "(sender = ? AND recipient = ?))\n" +
                "order by send_time DESC\n" +
                "LIMIT 10").addEntity(Message.class);
        query.setTimestamp(0, time);
        query.setString(1, srcId);
        query.setString(2, destId);
        query.setString(3, destId);
        query.setString(4, srcId);
        return query.list();
    }

    @Override
    public List<Message> findMessage(String srcId, String destId) {
        System.out.println(srcId);
        System.out.println(destId);
        Session session = this.before();
        String sql = "SELECT * FROM `message` WHERE status != 1 AND " +
                "                (sender=? AND recipient=?) " +
                "                OR " +
                "               (sender =? and recipient =?) " +
                "                order by send_time DESC " +
                "                LIMIT 5";
        Query query = session.createSQLQuery(sql).addEntity(Message.class);
        query.setString(0,srcId);
        query.setString(1,destId);
        query.setString(2,destId);
        query.setString(3,srcId);
        System.out.println(query.toString());
        return query.list();
    }

    @Override
    public void setMessageStatus(String srcId, String destId, int status) {
        Session session = this.before();
        Query query = session.createSQLQuery("update `message` set status = ? where sender = ? AND recipient = ?");
        query.setInteger(0,status);
        query.setString(1,srcId);
        query.setString(2,destId);
        query.executeUpdate();
    }

    @Override
    public Integer unReadMessage(String srcUid, String destUid) {
        Session session = this.before();
        Query query = session.createSQLQuery("SELECT COUNT(*) from `message` WHERE recipient = ? AND sender = ? AND status = 0;");
        query.setString(0, destUid);
        query.setString(1, srcUid);
        return ((BigInteger)query.uniqueResult()).intValue();
    }
}
