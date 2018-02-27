package com.example.dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import javax.transaction.Transactional;

import org.springframework.stereotype.Repository;

import com.example.model.Products;

@Repository
public class ProductsDaoImp implements ProductsDao{
    @PersistenceContext
    private EntityManager em;
	
	
	@Transactional
	public List<Products> getAllProduts() {
			  CriteriaQuery<Products> criteriaQuery = em.getCriteriaBuilder().createQuery(Products.class);			
			  @SuppressWarnings("unused")
			  Root<Products> root = criteriaQuery.from(Products.class) ;
			  return em.createQuery(criteriaQuery).getResultList();
	
	}


	@Transactional
	public Products getProductsById(Long pid) {
		// TODO Auto-generated method stub
		return em.find(Products.class, pid);
	}


	@Transactional
	public void update(Products products, Long q) {
		// TODO Auto-generated method stub
		
		Products prods = em.find(Products.class, products.getPsid());
		 
		prods.setQuantity(prods.getQuantity()-q); 
	}

	

}
