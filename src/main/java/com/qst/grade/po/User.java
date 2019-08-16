package com.qst.grade.po;

import javax.persistence.*;
import java.util.Date;
import java.util.Objects;

@Entity
@Table(name = "`user`")
public class User {
    private String uid;
    private String pass;
    private String nickname;
    private String mail;
    private String headImage;
    private String telphone;
    private Integer sex;
    private Date birthday;
    private int gold;
    private int status;
    private int auth;
    private Date createTime;
    private Date latestLoginTime;

    @Id
    @Column(name = "uid")
    public String getUid() {
        return uid;
    }

    public void setUid(String uid) {
        this.uid = uid;
    }

    @Basic
    @Column(name = "pass")
    public String getPass() {
        return pass;
    }

    public void setPass(String pass) {
        this.pass = pass;
    }

    @Basic
    @Column(name = "nickname")
    public String getNickname() {
        return nickname;
    }

    public void setNickname(String nickname) {
        this.nickname = nickname;
    }

    @Basic
    @Column(name = "mail")
    public String getMail() {
        return mail;
    }

    public void setMail(String mail) {
        this.mail = mail;
    }

    @Basic
    @Column(name = "head_image")
    public String getHeadImage() {
        return headImage;
    }

    public void setHeadImage(String headImage) {
        this.headImage = headImage;
    }

    @Basic
    @Column(name = "telphone")
    public String getTelphone() {
        return telphone;
    }

    public void setTelphone(String telphone) {
        this.telphone = telphone;
    }

    @Basic
    @Column(name = "sex")
    public Integer getSex() {
        return sex;
    }

    public void setSex(Integer sex) {
        this.sex = sex;
    }

    @Basic
    @Column(name = "birthday")
    public Date getBirthday() {
        return birthday;
    }

    public void setBirthday(Date birthday) {
        this.birthday = birthday;
    }

    @Basic
    @Column(name = "gold")
    public int getGold() {
        return gold;
    }

    public void setGold(int gold) {
        this.gold = gold;
    }

    @Basic
    @Column(name = "status")
    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    @Basic
    @Column(name = "auth")
    public int getAuth() {
        return auth;
    }

    public void setAuth(int auth) {
        this.auth = auth;
    }

    @Basic
    @Column(name = "create_time")
    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    @Basic
    @Column(name = "latest_login_time")
    public Date getLatestLoginTime() {
        return latestLoginTime;
    }

    public void setLatestLoginTime(Date latestLoginTime) {
        this.latestLoginTime = latestLoginTime;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        User user = (User) o;
        return gold == user.gold &&
                status == user.status &&
                auth == user.auth &&
                Objects.equals(uid, user.uid) &&
                Objects.equals(pass, user.pass) &&
                Objects.equals(nickname, user.nickname) &&
                Objects.equals(mail, user.mail) &&
                Objects.equals(headImage, user.headImage) &&
                Objects.equals(telphone, user.telphone) &&
                Objects.equals(sex, user.sex) &&
                Objects.equals(birthday, user.birthday) &&
                Objects.equals(createTime, user.createTime) &&
                Objects.equals(latestLoginTime, user.latestLoginTime);
    }

    @Override
    public int hashCode() {
        return Objects.hash(uid, pass, nickname, mail, headImage, telphone, sex, birthday, gold, status, auth, createTime, latestLoginTime);
    }

    @Override
    public String toString() {
        return "User{" +
                "uid='" + uid + '\'' +
                ", pass='" + pass + '\'' +
                ", nickname='" + nickname + '\'' +
                ", mail='" + mail + '\'' +
                ", headImage='" + headImage + '\'' +
                ", telphone='" + telphone + '\'' +
                ", sex=" + sex +
                ", birthday=" + birthday +
                ", gold=" + gold +
                ", status=" + status +
                ", auth=" + auth +
                ", createTime=" + createTime +
                ", latestLoginTime=" + latestLoginTime +
                '}';
    }
}
