package com.example.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.dao.InvoiceDao;
import com.example.model.Invoice;

@Service
public class InvoiceServiceImp implements InvoiceService{

	@Autowired
	private InvoiceDao invoiceDao;
	
	public Long addInvoice(Invoice invoice) {
		// TODO Auto-generated method stub
		return invoiceDao.addInvoice(invoice);
	}

	 
	public List<Invoice> getAllInvoice() {
		// TODO Auto-generated method stub
		return invoiceDao.getAllInvoice();
	}

	 
	public void update(Invoice invoice) {
		// TODO Auto-generated method stub
		invoiceDao.updateInvoice(invoice);
		
	}


	@Override
	public Invoice getInvoiceById(Long id) {
		// TODO Auto-generated method stub
		
		return invoiceDao.getInvoiceById(id);
		
		
	}


	@Override
	public void registerPayment(Long id) {
		// TODO Auto-generated method stub
		
		invoiceDao.registerPayment(id);
	}

}
