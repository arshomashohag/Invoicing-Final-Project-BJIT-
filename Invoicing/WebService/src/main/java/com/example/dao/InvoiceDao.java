package com.example.dao;

import java.util.List;

import com.example.model.Invoice;

public interface InvoiceDao {
	void addInvoice(Invoice invoice);
	
	List<Invoice> getAllInvoice();
	void updateInvoice(Invoice invoice);

	Invoice getInvoiceById(Long id);

	void registerPayment(Long id);

}
