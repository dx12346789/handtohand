package com.qst.grade.util;

import net.sf.json.JSONObject;
import org.dom4j.DocumentException;

import javax.mail.MessagingException;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.List;

public interface Email {

    /**
     * 发送只有文本内容的邮件
     *
     * @param recipient 收件人
     * @param title     标题
     * @param content   内容
     * @return
     */
    public JSONObject sendTextEmail(String recipient, String title, String content) throws DocumentException, MessagingException, UnsupportedEncodingException;

    /**
     * 发送只有图片的邮件
     *
     * @param recipient     收件人
     * @param title         标题
     * @param imageAddresss 图片
     * @return
     */
    public JSONObject sendImageEmail(String recipient, String title, List<String> imageAddresss) throws DocumentException, MessagingException, IOException;

    /**
     * 创建只有附件的邮件
     *
     * @param recipient     收件人
     * @param title         标题
     * @param mixedAddresss 附件
     * @return
     */
    public JSONObject sendMixedEmail(String recipient, String title, List<String> mixedAddresss) throws DocumentException, MessagingException, UnsupportedEncodingException;

    /**
     * 创建文本加图片的邮件
     *
     * @param recipient     收件人
     * @param title         标题
     * @param content       内容
     * @param imageAddresss 图片
     * @return
     */
    public JSONObject sendTextAndImageEmail(String recipient, String title, String content, List<String> imageAddresss) throws DocumentException, MessagingException, IOException;

    /**
     * 发送只有文本加附件的邮件
     *
     * @param recipient     收件人
     * @param title         标题
     * @param content       内容
     * @param mixedAddresss 附件
     * @return
     */
    public JSONObject sendTextAndMixedEmail(String recipient, String title, String content, List<String> mixedAddresss) throws DocumentException, MessagingException, UnsupportedEncodingException;

    /**
     * 发送有图片和附件的邮件
     *
     * @param recipient     收件人
     * @param title         标题
     * @param imageAddresss 图片
     * @param mixedAddresss 附件
     * @return
     */
    public JSONObject sendImageAndMixedEmail(String recipient, String title, List<String> imageAddresss, List<String> mixedAddresss) throws DocumentException, MessagingException, UnsupportedEncodingException;

    /**
     * 发送有文本、图片和附件的邮件
     *
     * @param recipient     收件人
     * @param title         标题
     * @param content       内容
     * @param imageAddresss 图片
     * @param mixedAddresss 附件
     * @return
     */
    public JSONObject sendTextAndImageAndMixedEmail(String recipient, String title, String content, List<String> imageAddresss, List<String> mixedAddresss) throws DocumentException, MessagingException, UnsupportedEncodingException;

}
