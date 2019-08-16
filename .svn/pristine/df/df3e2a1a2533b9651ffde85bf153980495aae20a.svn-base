package com.qst.grade.service.Impl;

import com.qst.grade.dao.UserDao;
import com.qst.grade.po.User;
import com.qst.grade.service.UserManageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.List;

@Service
@Transactional
public class UserManageServiceImpl implements UserManageService {
    private UserDao userDao;


    @Autowired
    public UserManageServiceImpl(UserDao userDao) {
        this.userDao = userDao;
    }

    @Override
    public List<User> findUserAll() {
        List<User> users = new ArrayList<User>();
        List<User> localUsers = userDao.findAll();
        for (User user : localUsers) {
            if (user.getAuth() == 0) {
                users.add(user);
            }
        }
        return users;
    }

    @Override
    public List<User> findAdminAll() {
        List<User> users = new ArrayList<User>();
        List<User> localUsers = userDao.findAll();
        for (User user : localUsers) {
            if (user.getAuth() != 0) {
                users.add(user);
            }
        }
        return users;
    }
}
