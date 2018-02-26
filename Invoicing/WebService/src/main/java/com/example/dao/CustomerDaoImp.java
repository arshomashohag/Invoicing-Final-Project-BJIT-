package com.example.dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import javax.transaction.Transactional;

import org.springframework.stereotype.Repository;

import com.example.model.Customer;

@Repository
public class CustomerDaoImp implements CustomerDao{
	 @PersistenceContext
	 private EntityManager em;
	
	 
	@Transactional
	public List<Customer> getAllCustomer() {
		
		CriteriaQuery<Customer> criteriaQuery = em.getCriteriaBuilder().createQuery(Customer.class);
		  @SuppressWarnings("unused")
		  Root<Customer> root = criteriaQuery.from(Customer.class) ;
		  
		  return em.createQuery(criteriaQuery).getResultList();
	}

	 
	@Transactional
	public Customer getCustomerById(Long id) {
		 
		return em.find(Customer.class, id);
	}

}
