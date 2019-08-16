package com.qst.grade.dao;

import com.qst.grade.po.Category;

import java.util.List;

public interface CategoryDao {
    List<Category> findAllCategory();

    Category findCategoryByCid(String cid);

    void deltype(Category cate);

    String addtype(Category cate);

    Category findBytype(String typename);
}
