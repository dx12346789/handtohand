package com.qst.grade.service.Impl;

import com.qst.grade.po.Point;
import com.qst.grade.service.PointService;
import com.qst.grade.util.PointUtil;
import org.dom4j.DocumentException;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.io.IOException;
import java.util.List;

@Service
public class PointServiceImpl implements PointService {
    private PointUtil point;

    @Autowired
    public PointServiceImpl(PointUtil point) {
        this.point = point;
    }

    @Override
    public List<Point> findAll() throws DocumentException {
       return point.findAll();
    }

    @Override
    public String addPoint(Point po) throws IOException, DocumentException {
        return point.addPoint(po);

    }

    @Override
    public boolean delPoint(String pid) throws IOException, DocumentException {

        return point.delPoint(pid);
    }

    @Override
    public boolean updatePoint(Point po) throws IOException, DocumentException {
        return point.updatePoint(po);
    }

}
