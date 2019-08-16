package com.qst.grade.dao;

import com.qst.grade.po.Order;

public interface OrderDao {

    Integer save(Order order);
    Integer save(String oid, String pid);
    Order findOrderByoid(String oid);

}
