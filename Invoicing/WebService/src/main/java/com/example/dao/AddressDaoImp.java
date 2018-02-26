package com.example.dao;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.transaction.Transactional;

import org.springframework.stereotype.Repository;

import com.example.model.CustomerAddress;

@Repository
public class AddressDaoImp implements AddressDao{

	 
	@PersistenceContext
	 private EntityManager em;
	
	@Transactional
	public CustomerAddress getAddress(Long id) {
		 
		return em.find(CustomerAddress.class, id);
	}

}
