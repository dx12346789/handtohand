package com.qst.grade.dao;

import com.qst.grade.po.Address;

import java.util.List;

public interface AddressDao {
    Address findByAid(String aid);
    List<Address> findByUid(String uid);
    String addAddress(Address address);
    boolean updateAddress(Address address);
    boolean delAddress(String aId);
}
