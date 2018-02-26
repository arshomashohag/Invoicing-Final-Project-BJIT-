package com.example.dao;

import java.util.List;

import com.example.model.Product;

public interface ProductDao {
	
	void add(Product prod);
	List<Product> getAll();
	void update(Product prod);
	 
}
