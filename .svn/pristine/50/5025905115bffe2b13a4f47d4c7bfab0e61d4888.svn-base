package com.qst.grade.util;

import net.sf.json.JSONObject;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.dom4j.Document;
import org.dom4j.DocumentException;
import org.dom4j.Element;
import org.dom4j.io.SAXReader;

import javax.activation.DataHandler;
import javax.activation.FileDataSource;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeMultipart;
import java.io.File;
import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.util.List;
import java.util.Properties;

public class EmailImpl implements Email {

    private static final Log log = LogFactory.getLog(EmailImpl.class);
    private String filePath = this.getClass().getClassLoader().getResource("").getPath();

    private Element emailUser;
    private Session session;
    private Transport transport;
    private MimeMessage message;


    private Transport sendEmailBefor() throws MessagingException, DocumentException, UnsupportedEncodingException {
        emailUser = getManagerEmail();
        Properties prop = new Properties();
        prop.setProperty("mail.host", emailUser.elementText("HostName"));
        prop.setProperty("mail.transport.protocol", emailUser.elementText("protocol"));
        prop.setProperty("mail.smtp.auth", emailUser.elementText("auth"));
        prop.setProperty("mail.smtp.port", emailUser.elementText("port"));//发送端口
        prop.setProperty("mail.debug", emailUser.elementText("debug"));//true 打印信息到控制台
        prop.setProperty("mail.smtp.ssl.enable", emailUser.elementText("ssl"));

        //使用JavaMail发送邮件的5个步骤
        //1、创建session
        session = Session.getInstance(prop);
        //开启Session的debug模式，这样就可以查看到程序发送Email的运行状态
        session.setDebug(true);
        //2、通过session得到transport对象
        Transport ts = session.getTransport();
        //3、使用邮箱的用户名和密码连上邮件服务器，发送邮件时，发件人需要提交邮箱的用户名和密码给smtp服务器，用户名和密码都通过验证之后才能够正常发送邮件给收件人。
        ts.connect(emailUser.elementText("HostName"), emailUser.elementText("userName"), emailUser.elementText("password"));
        //4、创建邮件
        message = new MimeMessage(session);
        //指明邮件的发件人
        message.setFrom(new InternetAddress(emailUser.elementText("userName"),emailUser.elementText("name")));
        return ts;
    }

    private void sendEmailAfter(Transport ts, Message message) throws MessagingException {
        //5、发送邮件
        ts.sendMessage(message, message.getAllRecipients());
        ts.close();
    }

    /**
     * 发送只有文本内容的邮件
     *
     * @param recipient 收件人
     * @param title     标题
     * @param content   内容
     * @return
     * @throws DocumentException
     * @throws MessagingException
     */
    @Override
    public JSONObject sendTextEmail(String recipient, String title, String content) throws DocumentException, MessagingException, UnsupportedEncodingException {
        sendTextAndImageAndMixedEmail(recipient, title, content, null, null);
        return null;
    }

    /**
     * 发送只有图片内容的邮件
     *
     * @param recipient     收件人
     * @param title         标题
     * @param imageAddresss 图片
     * @return
     * @throws DocumentException
     * @throws MessagingException
     * @throws IOException
     */
    @Override
    public JSONObject sendImageEmail(String recipient, String title, List<String> imageAddresss) throws DocumentException, MessagingException, IOException {
        sendTextAndImageEmail(recipient, title, "", imageAddresss);
        return null;
    }

    /**
     * 发送只有附件的邮件
     *
     * @param recipient     收件人
     * @param title         标题
     * @param mixedAddresss 附件
     * @return
     * @throws DocumentException
     * @throws MessagingException
     */
    @Override
    public JSONObject sendMixedEmail(String recipient, String title, List<String> mixedAddresss) throws DocumentException, MessagingException, UnsupportedEncodingException {
        sendTextAndMixedEmail(recipient, title, "", mixedAddresss);
        return null;
    }

    /**
     * 发送包含文本和图片的邮件
     *
     * @param recipient     收件人
     * @param title         标题
     * @param content       内容
     * @param imageAddresss 图片
     * @return
     * @throws DocumentException
     * @throws MessagingException
     */
    @Override
    public JSONObject sendTextAndImageEmail(String recipient, String title, String content, List<String> imageAddresss) throws DocumentException, MessagingException, IOException {
        sendTextAndImageAndMixedEmail(recipient, title, content, imageAddresss, null);
        return null;
    }

    /**
     * 发送文本加附件
     *
     * @param recipient     收件人
     * @param title         标题
     * @param content       内容
     * @param mixedAddresss 附件
     * @return
     * @throws DocumentException
     * @throws MessagingException
     */
    @Override
    public JSONObject sendTextAndMixedEmail(String recipient, String title, String content, List<String> mixedAddresss) throws DocumentException, MessagingException, UnsupportedEncodingException {
        sendTextAndImageAndMixedEmail(recipient, title, content, null, mixedAddresss);
        return null;
    }

    @Override
    public JSONObject sendImageAndMixedEmail(String recipient, String title, List<String> imageAddresss, List<String> mixedAddresss) throws DocumentException, MessagingException, UnsupportedEncodingException {
        sendTextAndImageAndMixedEmail(recipient, title, "", imageAddresss, mixedAddresss);
        return null;
    }

    @Override
    public JSONObject sendTextAndImageAndMixedEmail(String recipient, String title, String content, List<String> imageAddresss, List<String> mixedAddresss) throws DocumentException, MessagingException, UnsupportedEncodingException {
        Transport transport = sendEmailBefor();
        //4、创建邮件
        //收件人
        message.setRecipient(Message.RecipientType.TO, new InternetAddress(recipient));
        //邮件标题
        message.setSubject(title);

        MimeMultipart mimeMultipart = new MimeMultipart();
        MimeBodyPart text = new MimeBodyPart();

        if (imageAddresss != null) {
            MimeMultipart mm = new MimeMultipart();
            for (int i = 0; i < imageAddresss.size(); i++) {
                content += "<img src=\'cid:" + i + "'></img></br>";
            }
            text.setContent(content, "text/html;charset=UTF-8");
            int i = 0;
            for (String imgFile : imageAddresss) {
                // 准备图片数据
                MimeBodyPart image = new MimeBodyPart();
                DataHandler dh = new DataHandler(new FileDataSource(imgFile));
                image.setDataHandler(dh);
                image.setContentID(i + "");
                image.setFileName(dh.getName());
                mm.addBodyPart(image);
                i++;
            }
            mm.addBodyPart(text);
            mm.setSubType("related");
            MimeBodyPart c = new MimeBodyPart();
            c.setContent(mm);
            mimeMultipart.addBodyPart(c);
        } else {
            text.setContent(content, "text/html;charset=UTF-8");
            mimeMultipart.addBodyPart(text);
        }

        if (mixedAddresss != null) {
            for (String fileAddress : mixedAddresss) {
                MimeBodyPart attach = new MimeBodyPart();
                DataHandler dh = new DataHandler(new FileDataSource(fileAddress));
                attach.setDataHandler(dh);
                attach.setFileName(dh.getName());
                mimeMultipart.addBodyPart(attach);
            }
            mimeMultipart.setSubType("mixed");
        }


        message.setContent(mimeMultipart);
        message.saveChanges();


        sendEmailAfter(transport, message);
        return null;
    }

    private Element getManagerEmail() throws DocumentException {
        String xmlFilePath = filePath + "/email.xml";

        SAXReader reader = new SAXReader();
        Document doc = reader.read(new File(xmlFilePath));
        Element rootElement = doc.getRootElement();
        List<Element> list = rootElement.elements();
        Element element = list.get(0);
        return element;
    }
}
