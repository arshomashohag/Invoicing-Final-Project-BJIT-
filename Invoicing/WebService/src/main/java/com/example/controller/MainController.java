package com.example.controller;

import java.io.File;
import java.net.URL;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.example.model.Customer;
import com.example.model.Invoice;

import com.example.service.CustomerService;
import com.example.service.InvoiceService;
import com.example.service.ProductsService;
 

@Controller
@RequestMapping("/")
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
	public ModelAndView shoDetails(@RequestParam(required=false, defaultValue="0",value ="id") Long id, HttpServletRequest request){
		 
		ModelAndView view = new ModelAndView();
		
		if(id==null || id==0){
			 view.setViewName("404");
		}
		 Invoice invoice = invoiceservice.getInvoiceById(id);		 
		 
		  if(invoice!=null){		 
		 view.setViewName("details");
		 view.addObject("invoice", invoice);
		 view.addObject("prodsList", productsservice.getAllProducts());
		 }
		  else{
			  view.setViewName("404");
		  }
		
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
