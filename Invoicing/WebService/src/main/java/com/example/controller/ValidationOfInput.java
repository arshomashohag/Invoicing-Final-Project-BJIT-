package com.example.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class ValidationOfInput {
 

	public List<String> validateInput(String invoiceDate, String salesP, String paymentT) {
		// TODO Auto-generated method stub
		int i=0;
		
		List<String> ret = new ArrayList();
		
		Map<String, Boolean> salesman = new HashMap();		
		salesman.put("Administrator",true);
		salesman.put("Demo Portal User", true);
		salesman.put("Demo User", true);
		
		
		Map<String, Boolean> payterm = new HashMap();
		
		payterm.put("15 Days" , true );
		payterm.put("30% Advance End of Following Month" , true );
		payterm.put( "30 Net Days",  true);
		payterm.put( "End of Following Month",  true);
		payterm.put( "Immediate Payment", true );
		
		
		if(!isThisDateValid(invoiceDate, "yyyy-MM-dd")){
			ret.add("dateofinvoice");
			ret.add("Date field is empty or Invalid date");
			 
		}
		
		
		if(!salesman.containsKey(salesP)){
			ret.add("salesp");
			ret.add("Salesperson is not valid!");
			 
		}
		
		if(!payterm.containsKey(paymentT)){
			ret.add("payterm");
			ret.add("Invalid Payment Term!");
		}
		
		
		return ret;
	}
	
	
	public boolean isThisDateValid(String dateToValidate, String dateFromat){

		if(dateToValidate == null){
		 
			return false;
		}

		SimpleDateFormat sdf = new SimpleDateFormat(dateFromat);
		sdf.setLenient(false);

		try {

			//if not valid, it will throw ParseException
			Date input = sdf.parse(dateToValidate);
			LocalDate localdate1 = input.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
			
			
			    
			Date current = new Date();
			LocalDate localdate2 = current.toInstant().atZone(ZoneId.systemDefault()).toLocalDate();
			 
			  
			 
			if(input.before(current) && !localdate1.equals(localdate2)){
				 
				return false;
			}
			 

		} catch (ParseException e) {

			 
			return false;
		}

		return true;
	}

}
