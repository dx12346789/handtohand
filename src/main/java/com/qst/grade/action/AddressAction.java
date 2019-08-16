package com.qst.grade.action;

import com.opensymphony.xwork2.ActionContext;
import com.qst.grade.po.Address;
import com.qst.grade.po.User;
import com.qst.grade.service.AddressService;
import com.qst.grade.util.UUID;
import net.sf.json.JSONObject;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.Map;

public class AddressAction {
    private static final Log log = LogFactory.getLog(AddressAction.class);
    private Address address;
    private AddressService addressService;
    private String aid;

    private JSONObject jsonObject;

    @Autowired
    public AddressAction(AddressService addressService) {
        this.addressService = addressService;
    }

    public String toAddress() {
        return "success";
    }

    /**
     * 增加收货地址
     *
     * @return
     */
    public String addAddress() {
        log.info("传输前地址" + address);
        address.setAid("A" + UUID.getUUID(32));
        Map session = ActionContext.getContext().getSession();
        User localUser = (User) session.get("loginUser");
        address.setUid(localUser.getUid());
        log.info("传输后的地址" + address);
        if (addressService.addAddress(address) != null) {
            return "success";
        }
        return "error";
    }

    public String toUpdateAddress(){
        address = addressService.findByAid(aid);
        return "success";
    }

    public String updateAddress() {
        log.info(address);
        Address localAddress = addressService.findByAid(address.getAid());
        address.setUid(localAddress.getUid());
        log.info(address);
        if (addressService.updateAddress(address)) {
            return "success";
        }
        jsonObject = new JSONObject();
        jsonObject.put("status","200");
        jsonObject.put("msg","OK");
        jsonObject.put("data","OK");
        return "error";
    }

    public String delAddress() {
        addressService.delAddress(aid);
        jsonObject = new JSONObject();
        jsonObject.put("status","200");
        jsonObject.put("msg","OK");
        jsonObject.put("data","OK");
        return "success";
    }

    public Address getAddress() {
        return address;
    }

    public void setAddress(Address address) {
        this.address = address;
    }

    public String getAid() {
        return aid;
    }

    public void setAid(String aid) {
        this.aid = aid;
    }

    public JSONObject getJsonObject() {
        return jsonObject;
    }

    public void setJsonObject(JSONObject jsonObject) {
        this.jsonObject = jsonObject;
    }
}
