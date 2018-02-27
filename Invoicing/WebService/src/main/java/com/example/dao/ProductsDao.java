package com.example.dao;

import java.util.List;

import com.example.model.Products;

public interface ProductsDao {
	
 public List<Products> getAllProduts();

public Products getProductsById(Long pid);

public void update(Products products, Long q);

}
