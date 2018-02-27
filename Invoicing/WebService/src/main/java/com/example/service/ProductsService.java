package com.example.service;

import java.util.List;

import com.example.model.Product;
import com.example.model.Products;

public interface ProductsService {
	
	public List<Products> getAllProducts();

	public Products getProductsById(Long pid);
	
	public void update(Products product2, Long long1);

	 
	 

}
