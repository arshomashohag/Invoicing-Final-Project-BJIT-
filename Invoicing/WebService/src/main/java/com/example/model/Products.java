package com.example.model;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;


@Entity
public class Products {
	
	@Id
	@GeneratedValue(strategy = GenerationType.IDENTITY)
	private Long psid;
	
	 
	public Long getPsid() {
		return psid;
	}
	public void setPsid(Long psid) {
		this.psid = psid;
	}
	private String productname;		 
	private double price;
	private Long quantity;
	private double tax;
	private String description;
	
	
	 
	 
	public String getProductname() {
		return productname;
	}
	public void setProductname(String productname) {
		this.productname = productname;
	}
	public double getPrice() {
		return price;
	}
	public void setPrice(double price) {
		this.price = price;
	}
	public Long getQuantity() {
		return quantity;
	}
	public void setQuantity(Long quantity) {
		this.quantity = quantity;
	}
	public double getTax() {
		return tax;
	}
	public void setTax(double tax) {
		this.tax = tax;
	}
	public String getDescription() {
		return description;
	}
	public void setDescription(String description) {
		this.description = description;
	}
	@Override
	public String toString() {
		return "Products [id=" + psid + ", name=" + productname + ", price=" + price + ", quantity=" + quantity + ", tax=" + tax
				+ ", description=" + description + "]";
	}
	
	 
	 
	
	

}