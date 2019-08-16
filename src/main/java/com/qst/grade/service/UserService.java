package com.qst.grade.service;

import com.qst.grade.po.User;

import java.io.File;
import java.util.List;

public interface UserService {
    /**
     * 增加用户
     *
     * @param user
     * @return
     */
    String addUser(User user);

    /**
     * 更新用户信息
     *
     * @param user
     * @return
     */
    boolean updateUser(User user);

    /**
     * 更新头像
     * @param uId
     * @param file
     * @param fileName
     * @param fileType
     * @return
     */
    boolean updateUserHeadImage(String uId, File file, String fileName, String fileType);

    boolean checkPassByUidAndPass(String uid,String pass);

    /**
     * 通过邮箱找用户
     *
     * @param mail
     * @return
     */
    User findByMail(String mail);

    /**
     * 通过手机号找用户
     *
     * @param phone
     * @return
     */
    User findByPhone(String phone);


    /**
     * 通过邮箱和密码查找可用用户
     *
     * @param mail
     * @param pass
     * @return
     */
    User findByMailAndPass(String mail, String pass);

    /**
     * 通过电话和密码查找可用用户
     *
     * @param phone
     * @param pass
     * @return
     */
    User findByPhoneAndPass(String phone, String pass);

    /**
     * 通过id查找用户
     *
     * @param uid
     * @return
     */
    User findByuId(String uid);

    /**
     * 查找所有用户
     */
    List<User> findAll();

    int findAllByCount();
}
