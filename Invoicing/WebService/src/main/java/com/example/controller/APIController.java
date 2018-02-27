package com.example.controller;

import java.time.LocalDate;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.MediaType;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.model.Customer;
import com.example.model.Invoice;
import com.example.model.Product;
import com.example.model.Products;
import com.example.service.CustomerService;
import com.example.service.InvoiceService;
import com.example.service.ProductService;
import com.example.service.ProductsService;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.sun.corba.se.impl.protocol.giopmsgheaders.RequestMessage;
import com.example.controller.ValidationOfInput;

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
	 
	
	@Autowired
	ValidationOfInput validation;
	
	
	@GetMapping("/products")
	@ResponseBody
	public List<Products> getAllProducts(){
		List<Products> products = productsservice.getAllProducts();
		return products;
	}
	
	@PostMapping(value="/create")
	@ResponseBody
	public String  createNewInvoice(@RequestParam("date") String invoiceDate, @RequestParam("paymentTerm") String paymentTerm, @RequestParam("cname") Long cname, @RequestParam("salesPerson") String salesPerson, @RequestParam("prods") List<Long> prods){
		int i, l=prods.size();
		int j;
		double total, tax, invoiceTotal;
		Long pid, quantity;
		List<String> returnMessage =new ArrayList<String>();
		Invoice invoice = new Invoice();
		
		Gson gsonBuilder = new GsonBuilder().create();
		
		invoice.setInvoiceDate(invoiceDate);
		invoice.setSalesperson(salesPerson);
		invoice.setPayment_term(paymentTerm);

		
		Customer customer = customerservice.getCustomerById(cname);
		
		 
		 
		Products singleproducts;
		Product product;
		List<Product> listProduct = new ArrayList<Product>();
		Map<Long,Long> checkList = new HashMap<Long, Long>();
		
		invoiceTotal=0;
		
		
		
		 
			returnMessage = validation.validateInput(invoiceDate, salesPerson, paymentTerm);
			
			if(returnMessage.size()==0 && !returnMessage.contains("dateofinvoice")){
				invoice.setDueDate(invoiceDate);
				Date current = new Date();
				LocalDate localdate = current.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
				invoice.setInvoiceDate(localdate.toString());
			}
			
			if(returnMessage.size()==0){
				invoice.setSalesperson(salesPerson);
			}
			
			if(returnMessage.size()==0){
				invoice.setPayment_term(paymentTerm);
			}
			
			if(customer==null){
				returnMessage.add("customer");
				returnMessage.add("Invalid Customer");
			}
			
			else if(returnMessage.size()==0){
				invoice.setCustomer(customer);
				invoice.setStatus("Open");
			}
			
			
			 
		
		
		 for(i=0, j=0; i<l; i+=2){
			pid= prods.get(i);
			
			if(pid!=0){
			
			quantity = prods.get(i+1);
			
			 
			
			singleproducts = productsservice.getProductsById(pid);
			
			
					if(singleproducts!=null){			
						total = quantity*singleproducts.getPrice();
						tax = (total*singleproducts.getTax())/100;
						total+=tax;
						
						
						
						invoiceTotal+=total;
						
						
						
						if(!checkList.containsKey(pid)){
							
							
							
							if(singleproducts.getQuantity()>=quantity){
								checkList.put(pid, quantity);
								product = new Product();
								product.setTotal(total);
								product.setQuantity(quantity);
								product.setProducts(singleproducts);
								product.setQuantity(quantity);
								listProduct.add(product);
							}
							else{
								returnMessage.add("prodq"+j);
								returnMessage.add("Limited storage!");
							}
							
							
						}
						else{
							for (Product product2 : listProduct) {
								
								Products prod = product2.getProducts();
								if(prod.getPsid()==pid){
									
									if(prod.getQuantity()>=(quantity+product2.getQuantity())){
										product2.setQuantity(quantity+ product2.getQuantity());
										product2.setTotal(total+product2.getTotal());
									}
									else{
										returnMessage.add("prodq"+j);
										returnMessage.add("Limited storage!");
										 
									}
									
								}
							}
						}
			
			 
		    }
			else{
				returnMessage.add("prodn"+j);
				returnMessage.add("Invalid product name!");
			}
			 
			
		   }
			
		 }
		 
		 invoice.setTotalBill(invoiceTotal);
		 invoice.setSrcDocument("NA");
		 
		 invoice.setInvoiceNumber("NA");
		 invoice.setDueDate(invoiceDate);
		 
		 
		 
		  
		 
		 if(returnMessage.size()==0)
			 {
			    invoice.setProductList(listProduct); 
			    Long ret=invoiceservice.addInvoice(invoice);
			    
			    for (Product product2 : listProduct) {
			    	 
			    	productsservice.update(product2.getProducts(), product2.getQuantity());
				}
			    
			    
			    returnMessage.add(ret.toString());
			 }
		
		return gsonBuilder.toJson(returnMessage);
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
	
	@GetMapping(value={"/page",}, produces={MediaType.APPLICATION_JSON_VALUE })
	@ResponseBody
	public String paginatePage(@RequestParam("pn") int start){
		String rows="";
		
		
		
		List<Invoice> invoiceList = invoiceservice.getAllInvoice();
		
		int l = invoiceList.size();
		 
		start=5*(start-1);
		int endp=((start+5)<l ? start+5:l);
		
		invoiceList = invoiceList.subList(start, endp);
		
		 
		for (Invoice invoice : invoiceList) {
						rows+="<tr id="+invoice.getId()+">"+
 						"<td><a href=\"details?id="+invoice.getId()+"\">"+invoice.getCustomer().getName()+"</a></td>"+
 						"<td>"+invoice.getInvoiceDate()+"</td>"+
 						"<td>"+invoice.getInvoiceNumber()+"</td>"+
 						"<td>"+invoice.getSalesperson()+"</td>"+
 						"<td>"+invoice.getDueDate()+"</td>"+
 						"<td>"+invoice.getSrcDocument()+"</td>"+
 						"<td>"+invoice.getTotalBill()+"</td>"+
					"<td>"+invoice.getDueAmount()+"</td>"+
					"<td>"+invoice.getStatus()+"</td>"+

				"</tr>";
		}
		
		return rows;
	}

}
