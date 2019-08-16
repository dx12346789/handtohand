package com.qst.grade.service;

import com.qst.grade.po.User;

import java.util.List;

public interface UserManageService {
    public List<User> findUserAll();
    public List<User> findAdminAll();
}
