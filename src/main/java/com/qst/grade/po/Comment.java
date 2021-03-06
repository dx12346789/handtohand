package com.qst.grade.po;

import javax.persistence.*;
import java.util.Date;
import java.util.Objects;

@Entity
@Table(name = "`comment`")
public class Comment {
    private String commentId;
    private String commentator;
    private String respondent;
    private String gid;
    private String content;
    private int status;
    private Date createTime;
    private int anonymous;
    private String odid;

    @Id
    @Column(name = "comment_id")
    public String getCommentId() {
        return commentId;
    }

    public void setCommentId(String commentId) {
        this.commentId = commentId;
    }

    @Basic
    @Column(name = "commentator")
    public String getCommentator() {
        return commentator;
    }

    public void setCommentator(String commentator) {
        this.commentator = commentator;
    }

    @Basic
    @Column(name = "respondent")
    public String getRespondent() {
        return respondent;
    }

    public void setRespondent(String respondent) {
        this.respondent = respondent;
    }

    @Basic
    @Column(name = "gid")
    public String getGid() {
        return gid;
    }

    public void setGid(String gid) {
        this.gid = gid;
    }

    @Basic
    @Column(name = "content")
    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
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
    @Column(name = "create_time")
    public Date getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Date createTime) {
        this.createTime = createTime;
    }

    @Basic
    @Column(name = "anonymous")
    public int getAnonymous() {
        return anonymous;
    }

    public void setAnonymous(int anonymous) {
        this.anonymous = anonymous;
    }

    @Basic
    @Column(name = "o_did")
    public String getOdid() {
        return odid;
    }

    public void setOdid(String odid) {
        this.odid = odid;
    }

    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;
        Comment comment = (Comment) o;
        return status == comment.status &&
                anonymous == comment.anonymous &&
                Objects.equals(commentId, comment.commentId) &&
                Objects.equals(commentator, comment.commentator) &&
                Objects.equals(respondent, comment.respondent) &&
                Objects.equals(gid, comment.gid) &&
                Objects.equals(content, comment.content) &&
                Objects.equals(createTime, comment.createTime) &&
                Objects.equals(odid, comment.odid);
    }

    @Override
    public int hashCode() {
        return Objects.hash(commentId, commentator, respondent, gid, content, status, createTime, anonymous, odid);
    }

    @Override
    public String toString() {
        return "Comment{" +
                "commentId='" + commentId + '\'' +
                ", commentator='" + commentator + '\'' +
                ", respondent='" + respondent + '\'' +
                ", gid='" + gid + '\'' +
                ", content='" + content + '\'' +
                ", status=" + status +
                ", createTime=" + createTime +
                ", anonymous=" + anonymous +
                ", oDid='" + odid + '\'' +
                '}';
    }
}
