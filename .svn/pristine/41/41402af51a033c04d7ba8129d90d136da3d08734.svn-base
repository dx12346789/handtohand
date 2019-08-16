package com.qst.grade.service.Impl;

import com.qst.grade.dao.AddressDao;
import com.qst.grade.po.Address;
import com.qst.grade.service.AddressService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AddressServiceImpl implements AddressService {
    private AddressDao addressDao;

    @Autowired
    public AddressServiceImpl(AddressDao addressDao) {
        this.addressDao = addressDao;
    }

    @Override
    public Address findByAid(String aId) {
        Address localAddress = addressDao.findByAid(aId);
        return localAddress;
    }

    @Override
    public List<Address> findByUid(String uid) {
        return addressDao.findByUid(uid);
    }

    @Override
    public String addAddress(Address address) {
        return addressDao.addAddress(address);
    }

    @Override
    public boolean updateAddress(Address address) {
        addressDao.updateAddress(address);
        return true;
    }

    @Override
    public boolean delAddress(String aId) {
        addressDao.delAddress(aId);
        return false;
    }
}
