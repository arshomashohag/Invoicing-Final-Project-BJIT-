package com.example.model;

import java.util.List;
import java.util.Map;

public class ProductResponse {
	 private Product product;
	 private boolean validated;
	 private List<Product> listProd;
	 private Map<String, String> errorMessages;
	 
	 
	 
	public List<Product> getListProd() {
		return listProd;
	}
	public void setListProd(List<Product> listProd) {
		this.listProd = listProd;
	}
	public Product getProduct() {
		return product;
	}
	public void setProduct(Product product) {
		this.product = product;
	}
	public boolean isValidated() {
		return validated;
	}
	public void setValidated(boolean validated) {
		this.validated = validated;
	}
	public Map<String, String> getErrorMessages() {
		return errorMessages;
	}
	public void setErrorMessages(Map<String, String> errorMessages) {
		this.errorMessages = errorMessages;
	}
	 
	 
	 
}
