package com.example.dao;

import java.util.List;

import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;

import com.example.model.Customer;
import com.example.model.Product;

public interface CustomerDao {
	
	public List<Customer> getAllCustomer();
	public Customer getCustomerById(Long id);

}
