package com.qst.grade.service;

import com.qst.grade.po.Message;
import com.qst.grade.po.User;
import net.sf.json.JSONObject;

public interface MessageService {
    String save(Message message);
    JSONObject packJson(Message message, User src, User destUser);
    JSONObject parseMessage(String str);
    JSONObject onOpen(String userId, String destUserId);
    void setMessageStatus(String srcId, String destId, int status);
}
