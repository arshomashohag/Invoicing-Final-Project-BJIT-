package com.example.dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.OrderBy;
import javax.persistence.PersistenceContext;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import javax.transaction.Transactional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import com.example.model.Product;

@Repository
public class ProductDaoImp implements ProductDao{
	  
	 @PersistenceContext
	 private EntityManager em;
	
	 @Transactional
	public void add(Product prod) {
		// TODO Auto-generated method stub
		em.persist(prod);
	}

	 
	@Transactional
	public List<Product> getAll() {
		  CriteriaQuery<Product> criteriaQuery = em.getCriteriaBuilder().createQuery(Product.class);
		  @SuppressWarnings("unused")
		  Root<Product> root = criteriaQuery.from(Product.class) ;
		  return em.createQuery(criteriaQuery).getResultList();
	}


	@Transactional
	public void update(Product prod) {
		// TODO Auto-generated method stub		
		 
		Product p = new Product();	
		Long l = prod.getPid();
		p = em.find(Product.class, l);
		
		p.setProducts(prod.getProducts());
		p.setQuantity(prod.getQuantity());
		p.setTotal(prod.getTotal());
	}


	 

}
