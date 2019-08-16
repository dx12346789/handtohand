package com.qst.grade.dao;

import com.qst.grade.po.User;

import java.util.List;

public interface UserDao {
    /**
     * 添加用户信息
     *
     * @param user
     * @return
     */
    String addUser(User user);

    boolean updateUser(User user);

    /**
     * 通过邮箱和密码查找用户
     *
     * @param mail
     * @return
     */
    List<User> findByMail(String mail);

    /**
     * 通过手机号和密码查找用户
     *
     * @param phone
     * @return
     */
    List<User> findByPhone(String phone);

    /**
     * 通过邮箱和密码查找用户
     *
     * @param mail
     * @param pass
     * @return
     */
    List<User> findByMailAndPass(String mail, String pass);

    /**
     * 通过手机号和密码查找用户
     *
     * @param phone
     * @param pass
     * @return
     */
    List<User> findByPhoneAndPass(String phone, String pass);

    /**
     * 通过uid查找用户
     *
     * @param uid
     * @return
     */
    User findByuId(String uid);

    /**
     * 查找所有用户
     * @return
     */
    List<User> findAll();

    Integer findAllByCount();

    Integer addGold(String uid, int number);

    Integer subGold(String uid, int number);
}
