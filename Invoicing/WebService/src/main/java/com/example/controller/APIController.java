package com.example.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.model.Invoice;
import com.example.model.Product;
import com.example.model.Products;
import com.example.service.CustomerService;
import com.example.service.InvoiceService;
import com.example.service.ProductService;
import com.example.service.ProductsService;

@Controller
public class APIController {
	@Autowired
	ProductsService productsservice;
	
	@Autowired 
	CustomerService customerservice;
	
	
	@Autowired
	ProductService productservice;
	
	@Autowired 
	InvoiceService invoiceservice;
	
	
	@GetMapping("/products")
	@ResponseBody
	public List<Products> getAllProducts(){
		List<Products> products = productsservice.getAllProducts();
		return products;
	}
	
	@PostMapping(value="/create")
	@ResponseBody
	public String createNewInvoice(@RequestParam("date") String invoiceDate, @RequestParam("paymentTerm") String paymentTerm, @RequestParam("cname") Long cname, @RequestParam("salesPerson") String salesPerson, @RequestParam("prods") List<Long> prods){
		int i, l=prods.size();
		double total, tax, invoiceTotal;
		Long pid, quantity;
		Invoice invoice = new Invoice();
		
		invoice.setInvoiceDate(invoiceDate);
		invoice.setSalesperson(salesPerson);
		invoice.setPayment_term(paymentTerm);

		System.out.println(cname);
		
		invoice.setCustomer(customerservice.getCustomerById(cname));
		invoice.setStatus("Open");
		 
		Products singleproducts;
		Product product;
		List<Product> listProduct = new ArrayList<Product>();
		Map<Long,Long> checkList = new HashMap<Long, Long>();
		
		invoiceTotal=0;
		 for(i=0; i<l; i+=2){
			pid= prods.get(i);
			if(pid!=0){
			
			quantity = prods.get(i+1);
			singleproducts = productsservice.getProductsById(pid);
			total = quantity*singleproducts.getPrice();
			tax = (total*singleproducts.getTax())/100;
			total+=tax;
			
			
			
			invoiceTotal+=total;
			
			
			
			if(!checkList.containsKey(pid)){
				checkList.put(pid, quantity);
				product = new Product();
				product.setTotal(total);
				product.setQuantity(quantity);
				product.setProducts(singleproducts);
				listProduct.add(product);
			}
			else{
				for (Product product2 : listProduct) {
					if(product2.getProducts().getPsid()==pid){
						product2.setQuantity(quantity+ product2.getQuantity());
						product2.setTotal(total+product2.getTotal());
						
					}
				}
			}
			
			 
			
			 
			
		   }
			
		 }
		 
		 invoice.setTotalBill(invoiceTotal);
		 invoice.setSrcDocument("NA");
		 
		 invoice.setInvoiceNumber("NA");
		 invoice.setDueDate(invoiceDate);
		 if(i>0)invoice.setProductList(listProduct);
		 
		 invoiceservice.addInvoice(invoice);
		
		return "hoiche";
	}
	
	
	@PostMapping("/update")
	@ResponseBody	
	public String updateInvoice(@RequestParam("id") Long id,@RequestParam("prods") List<Long> prods){
		int i, l=prods.size();
		double total, tax, invoiceTotal;
		Long pid, quantity;
		Invoice invoice = new Invoice();
		
		invoice.setStatus("Open");
		 
		Products singleproducts;
		Product product;
		List<Product> listProduct = new ArrayList<Product>();
		Map<Long,Long> checkList = new HashMap<Long, Long>();
		
		invoiceTotal=0;
		 for(i=0; i<l; i+=2){
			 
			pid= prods.get(i);
			
			if(pid!=0){
			
			quantity = prods.get(i+1);
			singleproducts = productsservice.getProductsById(pid);
			total = quantity*singleproducts.getPrice();
			tax = (total*singleproducts.getTax())/100;
			total+=tax;
			
			
			
			invoiceTotal+=total;
			
			
			
			if(!checkList.containsKey(pid)){
				checkList.put(pid, quantity);
				product = new Product();
				product.setTotal(total);
				product.setQuantity(quantity);
				product.setProducts(singleproducts);
				listProduct.add(product);
			}
			else{
				for (Product product2 : listProduct) {
					if(product2.getProducts().getPsid()==pid){
						product2.setQuantity(quantity+ product2.getQuantity());
						product2.setTotal(total+product2.getTotal());
						
					}
				}
			}
			
			 
			
			 
			
		   }
			
		 }
		 invoice.setId(id);
		 invoice.setTotalBill(invoiceTotal);
		 
		 invoice.setProductList(listProduct);
		 
		 invoiceservice.update(invoice);
		
		 
		return "hoiche";
	}
	
	@PostMapping("/register")
	@ResponseBody
	public String register(@RequestParam("id") Long id){
		
		invoiceservice.registerPayment(id);
		
		
		return "Hoiche";
	}

}
