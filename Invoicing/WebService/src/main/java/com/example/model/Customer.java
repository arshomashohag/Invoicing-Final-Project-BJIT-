package com.example.model;

import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;

@Entity
public class Customer {
	
	@Id
	private Long cid;
	
	private String name;
	
	@OneToOne(cascade=CascadeType.ALL, fetch=FetchType.EAGER)
	private CustomerAddress address;
	
	@OneToMany(cascade=CascadeType.ALL, mappedBy="customer")
	private List<Invoice> invoiceList;

	
	public Long getCid() {
		return cid;
	}

	public void setCid(Long cid) {
		this.cid = cid;
	}

	 

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public CustomerAddress getAddress() {
		return address;
	}

	public void setAddress(CustomerAddress address) {
		this.address = address;
	}
	
	
	

	public List<Invoice> getInvoiceList() {
		return invoiceList;
	}

	public void setInvoiceList(List<Invoice> invoiceList) {
		this.invoiceList = invoiceList;
	}

	@Override
	public String toString() {
		return "Customer [id=" + cid + ", name=" + name + ", address=" + address + "]";
	}
	
	

}
