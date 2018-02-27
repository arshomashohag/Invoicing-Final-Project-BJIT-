package com.example.dao;

import java.util.List;

import javax.persistence.EntityManager;
import javax.persistence.PersistenceContext;
import javax.persistence.criteria.CriteriaQuery;
import javax.persistence.criteria.Root;
import javax.transaction.Transactional;

import org.springframework.stereotype.Repository;

import com.example.model.Invoice;
import com.example.model.Product;

@Repository
public class InvoiceDaoImp implements InvoiceDao{
	
	 @PersistenceContext
	 private EntityManager em;

	@Transactional
	public List<Invoice> getAllInvoice() {
		
		  CriteriaQuery<Invoice> criteriaQuery = em.getCriteriaBuilder().createQuery(Invoice.class);
		  @SuppressWarnings("unused")
		  Root<Invoice> root = criteriaQuery.from(Invoice.class) ;
		  return em.createQuery(criteriaQuery).getResultList();
		 
	}

	@Transactional
	public void updateInvoice(Invoice invoice) {
		Invoice inv = em.find(Invoice.class, invoice.getId());		
		inv.setProductList(invoice.getProductList());
		
	}

	@Transactional
	public Long addInvoice(Invoice invoice) {
		// TODO Auto-generated method stub
		em.persist(invoice);
		 return invoice.getId();
	}

	@Transactional
	public Invoice getInvoiceById(Long id) {
		 return em.find(Invoice.class, id);
	}

	@Transactional
	public void registerPayment(Long id) {
		// TODO Auto-generated method stub
		
		Invoice invoice = em.find(Invoice.class, id);
		invoice.setStatus("Paid");
	}

}
