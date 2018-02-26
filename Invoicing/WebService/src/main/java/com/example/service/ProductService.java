package com.example.service;

import java.util.List;

import com.example.model.Product;

public interface ProductService {
	void add(Product prod);
	List<Product> getAll();
	void update(Product product);
	 
}
