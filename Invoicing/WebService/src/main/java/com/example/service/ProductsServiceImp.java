package com.example.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.dao.ProductsDao;
import com.example.model.Products;

@Service
public class ProductsServiceImp implements ProductsService{
	
	@Autowired
	private ProductsDao productsDao;

	 
	public List<Products> getAllProducts() {
		// TODO Auto-generated method stub
		return productsDao.getAllProduts();
	}


	@Override
	public Products getProductsById(Long pid) {
		// TODO Auto-generated method stub
		return productsDao.getProductsById(pid);
	}


	@Override
	public void update(Products products, Long q) {
		// TODO Auto-generated method stub
		productsDao.update(products, q);
	}
	
	

}
