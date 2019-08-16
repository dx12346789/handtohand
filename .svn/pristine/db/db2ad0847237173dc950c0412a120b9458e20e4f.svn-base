package com.qst.grade.util;

import org.junit.Test;

public class UUID {

    @Test
    public void getUID(){
        System.out.println(getUUID(32));
    }

    public static String getUUID(int length) {
        String s = java.util.UUID.randomUUID().toString();
        s = s.replace("-", "");
        return s.substring(0, length);
    }
}
