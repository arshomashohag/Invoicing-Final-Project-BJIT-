package com.example.dao;

import java.util.List;

import com.example.model.Invoice;

public interface InvoiceDao {
	Long addInvoice(Invoice invoice);
	
	List<Invoice> getAllInvoice();
	void updateInvoice(Invoice invoice);

	Invoice getInvoiceById(Long id);

	void registerPayment(Long id);

}
