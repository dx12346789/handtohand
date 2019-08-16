package com.qst.grade.service.Impl;

import com.qst.grade.dao.NoticDao;
import com.qst.grade.po.Notic;
import com.qst.grade.service.NoticService;
import net.sf.json.JSONObject;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service
@Transactional
public class NoticServiceImpl implements NoticService {
    private NoticDao noticDao;

    @Autowired
    public NoticServiceImpl(NoticDao noticDao) {
        this.noticDao = noticDao;
    }

    @Override
    public String addNotic(Notic notic) {
        return noticDao.addNotic(notic);
    }

    @Override
    public boolean updateNotic(Notic notic) {
        noticDao.updateNotic(notic);
        return true;
    }

    @Override
    public List<Notic> findAll() {
        List<Notic> notics = noticDao.findAll();
        List<Notic> localNotic = new ArrayList<Notic>();
        for(Notic notic:notics){
            if(notic.getStatus() != 1 && notic.getRecipient() != null){
                localNotic.add(notic);
            }
        }
        return localNotic;
    }

    @Override
    public Notic findByNid(String nid) {
        return noticDao.findByNid(nid);
    }

    @Override
    public boolean updateStatus(int status,String nid) {
        Notic notic = findByNid(nid);
        notic.setStatus(status);
        updateNotic(notic);
        return true;
    }
}
