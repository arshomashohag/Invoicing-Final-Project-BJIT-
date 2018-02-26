package com.example.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.dao.CustomerDao;
import com.example.model.Customer;

@Service
public class CustomerServiceImp implements CustomerService{
	
	 @Autowired
	 private CustomerDao customerDao;
	 
	 
	public List<Customer> getAllCustomer() {
		 return customerDao.getAllCustomer();
	}

	 
	public Customer getCustomerById(Long id) {
		return customerDao.getCustomerById(id);
	}

}
