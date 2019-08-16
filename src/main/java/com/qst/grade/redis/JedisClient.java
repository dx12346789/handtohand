package com.qst.grade.redis;

import java.util.List;

public interface JedisClient {
    String set(String key, String value);
    String get(String key);
    Boolean exists(String key);
    Long expire(String key, int senconds);
    Long ttl(String key);
    Long incr(String key);
    Long hset(String key, String field, String value);
    String hget(String key, String field);
    Long hdel(String key, String... field);
    Boolean hexists(String key, String field);
    List<String> hvals(String key);
    Long del(String key);
    void lpush(String key, String... value);
    void rpush(String key, String... value);
    Long llen(String key);
    void ltrim(String key);
    List<String> lrange(String key, int start, int stop);

}
