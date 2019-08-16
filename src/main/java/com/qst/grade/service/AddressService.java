package com.qst.grade.service;

import com.qst.grade.po.Address;

import java.util.List;

public interface AddressService {
    Address findByAid(String aId);
    List<Address> findByUid(String uid);
    String addAddress(Address address);
    boolean updateAddress(Address address);
    boolean delAddress(String aId);
}
