package com.example.model;

import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.ManyToMany;
import javax.persistence.ManyToOne;
import javax.persistence.OneToMany;

@Entity
public class Invoice {
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long id;
	
	private String invoiceDate;
	
	private String dueDate;
	
	private double totalBill;
	
	private double dueAmount;
	
	private String payment_term;
	
	private String salesperson;
	
	private String srcDocument;
	
	private String status;
	
	private String invoiceNumber;
	
	@ManyToOne(fetch=FetchType.EAGER)
	private Customer customer;
	
	@OneToMany(cascade=CascadeType.ALL, fetch=FetchType.EAGER)
	private List<Product> productList;
	
	
	

	public Long getId() {
		return id;
	}

	public void setId(Long id) {
		this.id = id;
	}

	public String getInvoiceDate() {
		return invoiceDate;
	}

	public void setInvoiceDate(String invoiceDate) {
		this.invoiceDate = invoiceDate;
	}
	
	

	public double getTotalBill() {
		return totalBill;
	}

	public void setTotalBill(double totalBill) {
		this.totalBill = totalBill;
	}

	public String getPayment_term() {
		return payment_term;
	}

	public void setPayment_term(String payment_term) {
		this.payment_term = payment_term;
	}

	public String getDueDate() {
		return dueDate;
	}

	public void setDueDate(String dueDate) {
		this.dueDate = dueDate;
	}


	public double getDueAmount() {
		return dueAmount;
	}

	public void setDueAmount(double dueAmount) {
		this.dueAmount = dueAmount;
	}

	public String getSalesperson() {
		return salesperson;
	}

	public void setSalesperson(String salesperson) {
		this.salesperson = salesperson;
	}

	public String getSrcDocument() {
		return srcDocument;
	}

	public void setSrcDocument(String srcDocument) {
		this.srcDocument = srcDocument;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	public String getInvoiceNumber() {
		return invoiceNumber;
	}

	public void setInvoiceNumber(String invoiceNumber) {
		this.invoiceNumber = invoiceNumber;
	}

	public Customer getCustomer() {
		return customer;
	}

	public void setCustomer(Customer customer) {
		this.customer = customer;
	}

	public List<Product> getProductList() {
		return productList;
	}

	public void setProductList(List<Product> productList) {
		this.productList = productList;
	}

	@Override
	public String toString() {
		return "Invoice [id=" + id + ", invoiceDate=" + invoiceDate + ", dueDate=" + dueDate + ", total=" + totalBill
				+ ", dueAmount=" + dueAmount + ", salesperson=" + salesperson + ", srcDocument=" + srcDocument
				+ ", status=" + status + ", invoiceNumber=" + invoiceNumber + ", customer=" + customer
				+ ", productList=" + productList + "]";
	}
	
	
	
	
	
}
