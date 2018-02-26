package com.example.controller;

import java.util.List;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.servlet.ModelAndView;

import com.example.model.Product;
import com.example.service.ProductService;

@Controller
public class ProductController {
	@Autowired
	private ProductService productService;
	
	@GetMapping("/product/")
	public ModelAndView product() {   	
		
		ModelAndView view = new ModelAndView("index");	
		
		List<Product> allProd = productService.getAll();
		
		
		view.addObject("listProduct", allProd);
		
		return view;
	}

	 
	
	
	
}