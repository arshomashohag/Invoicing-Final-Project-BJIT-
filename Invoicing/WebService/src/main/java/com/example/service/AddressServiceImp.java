package com.example.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.dao.AddressDao;
import com.example.model.CustomerAddress;

@Service
public class AddressServiceImp implements AddressService{

	@Autowired
	private AddressDao addressDao;
	
	public CustomerAddress getCustomerAddress(Long id) {
		// TODO Auto-generated method stub
		return addressDao.getAddress(id);
	}

}
