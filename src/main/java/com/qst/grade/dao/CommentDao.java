package com.qst.grade.dao;

import com.qst.grade.po.Comment;

import java.util.List;

public interface CommentDao {
    public List<Comment> findByGid(String gid);
    String savecomment (Comment comment);
    Comment findByOid(String oid);
    int count(String gid);
}
