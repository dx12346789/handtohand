package com.qst.grade.redis;

import org.junit.Test;
import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;


public class RedisCacheUtil {

    public static JedisClient getJedisClient(){
        ApplicationContext applicationContext = new ClassPathXmlApplicationContext("classpath:applicationContext-*.xml");
        return applicationContext.getBean(JedisClient.class);
    }

    @Test
    public void testSpringJedisSingle(){
        ApplicationContext applicationContext = new ClassPathXmlApplicationContext("classpath:applicationContext-*.xml");
        JedisClient jedisClient = applicationContext.getBean(JedisClient.class);

        String str = jedisClient.get("key1");
        System.out.println(str);

    }

}
