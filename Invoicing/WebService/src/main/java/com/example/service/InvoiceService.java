package com.example.service;

import java.util.List;

import org.springframework.stereotype.Service;

import com.example.model.Invoice;



public interface InvoiceService {
	
	Long addInvoice(Invoice invoice);
	List<Invoice> getAllInvoice();
	void update(Invoice invoice);
	Invoice getInvoiceById(Long id);
	void registerPayment(Long id);
	 

}
