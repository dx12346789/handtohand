package com.qst.grade.dao;

import com.qst.grade.po.Notic;

import java.util.List;

public interface NoticDao {
    public String addNotic(Notic notic);
    public List<Notic> findAll();
    public Notic findByNid(String nid);
    public boolean updateNotic(Notic notic);
}
