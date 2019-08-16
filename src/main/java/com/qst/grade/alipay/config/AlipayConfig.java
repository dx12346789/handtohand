package com.qst.grade.alipay.config;

import java.io.FileWriter;
import java.io.IOException;

/* *
 *类名：AlipayConfig
 *功能：基础配置类
 *详细：设置帐户有关信息及返回路径
 *修改日期：2017-04-05
 *说明：
 *以下代码只是为了方便商户测试而提供的样例代码，商户可以根据自己网站的需要，按照技术文档编写,并非一定要使用该代码。
 *该代码仅供学习和研究支付宝接口使用，只是提供一个参考。
 */

public class AlipayConfig {

//↓↓↓↓↓↓↓↓↓↓请在这里配置您的基本信息↓↓↓↓↓↓↓↓↓↓↓↓↓↓↓

    // 应用ID,您的APPID，收款账号既是您的APPID对应支付宝账号
    public static String app_id = "2016092400587141";

    // 商户私钥，您的PKCS8格式RSA2私钥
    public static String merchant_private_key = "MIIEvQIBADANBgkqhkiG9w0BAQEFAASCBKcwggSjAgEAAoIBAQCRV93+JUlQgya3CZDX+J+eF3dRsgROLPDxf8AWIlPoDRXfC+vpXoU3LU0xAR5AzAbK8jg1pzF8D3vCETbmxfywEngqqOUVuYX0rlrz8ibmNyZc0J4cP3HiDAjQOrk7/mshJUrYBJbTDxQcIXdQFhwc4jMxypSzFG9YhEFWy0AYZ1Bc7pMMbCghHv6dZ31U0h6pCe3ks1gWvPEx/dQAlf8Baj7ZOM+qbh4RmxI0u7tTLeNWdOCswn6v2HkdtreUAHyvfeCkNXb3K9rTZDKe5YF6nN6TmEQ2hlEBUmwOlzxJiX0UjFjJ57TVtGqYNfEm2ZsYa9qppYtwC6uOdfm2ogPpAgMBAAECggEAVBCwc9j5KLpS4DeGMYS6PeRwvS3r05Om4Of1IFhGk8dNyS7KCrcC8kEfjqKI7w2TODsVS+MiehEykbMHQD9vwh9Mpc/+gKxH0JgwPzzmRu3LIJABg3Em24n+ZwIwNYUYTZmWSo+M9RKZnRO2QPoo1IP4/GmhzFqbdGU6rYrtza68+NKP3nwElQydw0UVXh6FYXwC8XTucaJ45dEwXu/EKl74amz4djyT9x8RjxBXnqPCixRPHIHyj2Wi4J8R1zvODp0BQ9ZfEMnGjhu/fF6uI+3ZSKh6RFmojMDnUHeM9gBPS2bmnTOikdUqivXWR9PmU9BRsdxWRANlnBXMp2H/6QKBgQD7ocNT1k4LhGQgggW4wsgM77M3L5NLioXWtddBc57Fqr2yp7J12ub1frl3uG14Xh/8Fv7DN8SEzW9DMmYQ2V/OllWWdnS8ZOt7v2oe2OgbJL5lbZwOcvUqsASRF7AiJXpwABRbPHTjby+pmC2H+syRYF/n7yel7a1vimdH7ILPzwKBgQCT3cOFcPSOhhxpDiOk+CBwu5ytdXCo+DY4znLmWQsjtnjgrzZldYliw6zoXdkOTMl+0aEiRgVRFzV6AblCuG2rJqFazN5wNPc8Is48ZuYVQv/sEDafOMTBFEF4B3vOO+dbxjUQCwW1jWu5BD6XyY5TrBapoHoWL7vlKzEC0vpmxwKBgH3r6W9e4xdoXSLXbj2TW8D9gtWu/SrkWy2jOeELFv0cAGoS+X941/MqQ23h4QZHNAJXD45prfI3S+J4qhLsdMFRAeuVw70zU5RNqbFeImjS7mSbgWjJpl6CTwa8r+umjarWn1k429WkollgSgiuPQjTDatnRpQGaLBUtnKLrLqJAoGAGnaY9HvXuN41nXOjW3Xw0FwzWTPoesUZZydDlwgen0Cb95JECPp1IRDmFBwfqZiCg0jfLrQbZXzi3DgMwO0i63uZaxe5Q5mnGcMc5+B+kxWPmd7495wAUpHeea3VMX61FE6v1nQyjGCIA+/HiADRkRX+ZFNNJkVaulP1jIzXtacCgYEApDT5NS9mAfl5jC7TW0i4s7jfH3HvsxrI8C/1l4ryatIjOl8zBV+fKboIL/R54OmJ1Quct6MeO/VuTAr9RzXI2dZQ1INanqJmHsg2uRbsgQniP/1aB/1m6CZjHQZUsQ1n3bWDyplllRK8BCgTYu1cfsESR7CXf8eQkjRsj58pwSc=";

    // 支付宝公钥,查看地址：https://openhome.alipay.com/platform/keyManage.htm 对应APPID下的支付宝公钥。
    public static String alipay_public_key = "MIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEAuOUyMUJ98BYGQ8P/tEQEbExZNTGIE5GdrvLiDk/LkHWmdyILh7hP0GtiIhPan18xhS5SmiqMGqfkshQ6VdP9s8eJ8Ho7bNYq+neKRh0RSRqRLJ0MWOZRGVfJdI/g15ZAcZx0UJ8fHik/t1dna73EIpp5eAMVuzpZRfO0DHc0ps8OBOZXY4MQbPfE3AjD3M++iWyfa719Aene14tu5tBFrqLAJcec9oAGE6uL2lVU0/WcUpc74bTz6PRWUDNWI3FeBfItQMPwnj6M4N1SKC+AvJG6+V/m047MYAAa5jfujVTgUBl7w5b+3CooCsZB2L2VJYZABToHJTeevm+nN0K/VQIDAQAB";

    // 服务器异步通知页面路径  需http://格式的完整路径，不能加?id=123这类自定义参数，必须外网可以正常访问
    public static String notify_url = "http://127.0.0.1:8080/Transaction/notify_url.jsp";

    // 页面跳转同步通知页面路径 需http://格式的完整路径，不能加?id=123这类自定义参数，必须外网可以正常访问
    public static String return_url = "http://localhost:8080/Transaction/return_url";

    // 签名方式
    public static String sign_type = "RSA2";

    // 字符编码格式
    public static String charset = "utf-8";

    // 支付宝网关
    public static String gatewayUrl = "https://openapi.alipaydev.com/gateway.do";

    // 支付宝网关
    public static String log_path = "C:\\";


//↑↑↑↑↑↑↑↑↑↑请在这里配置您的基本信息↑↑↑↑↑↑↑↑↑↑↑↑↑↑↑

    /**
     * 写日志，方便测试（看网站需求，也可以改成把记录存入数据库）
     * @param sWord 要写入日志里的文本内容
     */
    public static void logResult(String sWord) {
        FileWriter writer = null;
        try {
            writer = new FileWriter(log_path + "alipay_log_" + System.currentTimeMillis()+".txt");
            writer.write(sWord);
        } catch (Exception e) {
            e.printStackTrace();
        } finally {
            if (writer != null) {
                try {
                    writer.close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
    }
}