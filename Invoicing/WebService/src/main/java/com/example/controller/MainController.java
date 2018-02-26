package com.example.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.example.model.Customer;
import com.example.model.Invoice;

import com.example.service.CustomerService;
import com.example.service.InvoiceService;
import com.example.service.ProductsService;
 

@Controller
public class MainController {
	@Autowired
	InvoiceService invoiceservice;
	
	@Autowired
	CustomerService customerservice;
	
	@Autowired
	ProductsService productsservice;
	
	@GetMapping({"/" , "/index"})
	public ModelAndView index(){
		ModelAndView view = new ModelAndView("index");
		
		List<Invoice> invoiceList = invoiceservice.getAllInvoice();
		
		view.addObject("totalPage", ((invoiceList.size()/5)+ ((invoiceList.size()%5)>0?1:0) ));
			 	 		 
		view.addObject("invoiceList", invoiceList.subList(0, 5));
		
		return view;
		
	}
	
	
	
	@GetMapping("/details")
	public ModelAndView shoDetails(@RequestParam("id") Long id){
		 
		 Invoice invoice = invoiceservice.getInvoiceById(id);		 
		 
		   
		 ModelAndView view = new ModelAndView("details");
		
		 view.addObject("invoice", invoice);
		 view.addObject("prodsList", productsservice.getAllProducts());
		
		return view;
	}
	
	
	@GetMapping("/create")
	public ModelAndView newInvoice(){
		ModelAndView view = new ModelAndView("create");
		
		List<Customer> customer = customerservice.getAllCustomer();
		
		view.addObject("customerList", customer);
		
		return view;
	}
	
	

}
