package com.example.service;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import com.example.dao.ProductDao;
import com.example.model.Product;


@Service
public class ProductServiceImp implements ProductService
{
	@Autowired
	ProductDao prodDao;

	 
	public void add(Product prod) {
		// TODO Auto-generated method stub
		prodDao.add(prod);
	}

	 
	public List<Product> getAll() {
		// TODO Auto-generated method stub		
		
		return prodDao.getAll();
	}


	 
	public void update(Product product) {
		// TODO Auto-generated method stub
		prodDao.update(product);
	}


	

}
