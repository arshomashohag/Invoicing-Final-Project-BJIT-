package com.example.service;

import java.util.List;

import com.example.model.Customer;

public interface CustomerService {
	
	public List<Customer> getAllCustomer();
	public Customer getCustomerById(Long id);

}
