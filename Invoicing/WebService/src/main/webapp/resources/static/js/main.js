var newProductRow;
var numberOfProduct = 0;
var message;
var maximum = -1;
var productList = [];
var prevp;
var prevtax;
var prevuntaxed;
var newp;
var newtax;
var newuntaxed;
var row ;
var id ;
var psids=0;
var quantitycount=0;

function addAProduct() {

    message = "";
    newProductRow = "<tr><td><select  class='form-control' onchange='addDetails(this)' required name='psid'><option value='0'></option>";
   
    $.get({
        url: 'products',
        success: function(res) {
            productList = res;

            $.each(res, function(key, value) {
                if(value.quantity>=1)newProductRow += "<option value='" + value.psid + "' >" +
                    value.productname + "</option>";
                else{
                	newProductRow += "<option style='color:red' value='" + value.psid + "' disabled>" +
                    value.productname + "<span >*</span></option>";
                }
                if (maximum < value.quantity) maximum = value.quantity;
            });

            newProductRow += "</select><span id='prodn"+psids+"'></td><td></td><td><input type='number' class='form-control' disabled min='1' max='" + maximum + "' value='1' required name='quantity'  onkeydown='preventInput(event)' onchange='calculateAmount(this)'><span id='prodq"+psids+"'</td><td>0.0</td><td>0.0</td><td>0.0</td>";
            $('#productlisttabbody')
                .html(newProductRow + $('#productlisttabbody').html());
            isProductsAvailable = true;
            psids++;

        },

        error: function() {
            message += "<tr><td colspan='6'><span>Error sending request</span></td></tr>";
            $('#productlisttabbody').html(
                message + $('#productlisttabbody').html());

        }

    });

}

function addDetails(v) {
  
     row = (v.parentNode).parentNode;
     id = v.value;
    
    
    
     
    $(v.options).each(function(){
        if($(this).val()==id){  
            $(this).attr("selected","selected");    
        }
        else{
        	 $(this).attr("selected",false); 
        }
    });
    
    
    
    if (id != "0") {
        $.each(productList,function(key, value) {
                if (value.psid == id) {
                	var tax = parseFloat(row.cells[4].innerHTML);
                	 newtax = (value.price*value.tax)/100;
                	
                	
                	 prevp = parseFloat(row.cells[5].innerHTML);
                	 newp = value.price + newtax;
                	 
                	
                	 
                	 prevuntaxed = (parseFloat(row.cells[5].innerHTML)*100)/(tax+100);
                	 newuntaxed = value.price;
                	 
                	 prevtax = prevp-prevuntaxed;
                	 
                    row.cells[1].innerHTML = value.description;
                
                    row.cells[2].getElementsByTagName("INPUT")[0].setAttribute("max", value.quantity);
                    row.cells[2].getElementsByTagName("INPUT")[0].setAttribute("value", 1);
                    row.cells[2].getElementsByTagName("INPUT")[0].value=1;
                    row.cells[2].getElementsByTagName("INPUT")[0].disabled=false;
                    row.cells[3].innerHTML = newuntaxed;
                    row.cells[4].innerHTML = value.tax;
                    row.cells[5].innerHTML = newp;
                    
                    $('#totaluntaxedamounttopay').html( (parseFloat( $('#totaluntaxedamounttopay').html())-prevuntaxed+newuntaxed).toFixed(2));
                    $('#totaltaxtopay').html( ( (parseFloat( $('#totaltaxtopay').html()).toFixed(2)) -prevtax+newtax).toFixed(2) );
                    $('#totalamounttopay').html( (parseFloat($('#totalamounttopay').html()).toFixed(2)-prevp+newp).toFixed(2) );

					 
                }

            });
        
        
    } else {
    	  
    	 var tax = parseFloat(row.cells[4].innerHTML);

	   	 newtax = 0.0;
		
	   	
	   	 prevp = parseFloat(row.cells[5].innerHTML);
	   	 
	   	 newp = 0.0;
	   	 
	   	
	   	 
	   	 prevuntaxed = (100*prevp)/(tax+100);
	   	 newuntaxed = 0.0;
	   	 
	   	prevtax = prevp-prevuntaxed;
    	
        row.cells[1].innerHTML = "";
        row.cells[2].getElementsByTagName("INPUT")[0].setAttribute("max", 120);
        row.cells[2].getElementsByTagName("INPUT")[0].setAttribute("value", 1);
        row.cells[2].getElementsByTagName("INPUT")[0].value=1;
        row.cells[2].getElementsByTagName("INPUT")[0].disabled=true;
        
        row.cells[3].innerHTML = "0.0";
        row.cells[4].innerHTML = "0.0";
        row.cells[5].innerHTML = "0.0";
        $('#totaluntaxedamounttopay').html( (parseFloat( $('#totaluntaxedamounttopay').html())-prevuntaxed+newuntaxed).toFixed(2));
        $('#totaltaxtopay').html( ( (parseFloat( $('#totaltaxtopay').html()).toFixed(2)) -prevtax+newtax).toFixed(2) );
        $('#totalamounttopay').html( (parseFloat($('#totalamounttopay').html()).toFixed(2)-prevp+newp).toFixed(2) );
    }

}


function calculateAmount(v){
	 var unitprice;
	 var tax;
	 
	 row = v.parentNode.parentNode;
	 quantity = v.value;
	 
	 var cselect = row.cells[0];
	 
	  
	 
	 $(cselect.options).each(function(){
	        if( $(this).attr("selected")=="selected"){  
	             id= $(this).val();
	              return false;
	        }
	         
	    });
	 
	 $.each(productList,function(key, value) {
		 if(parseInt(id)==parseInt(value.psid) ){
			 unitprice = value.price;
			 tax = value.tax;
			 return false;
		 }

		 
	 });
	 
	  
	 newuntaxed = unitprice*quantity;
	 	
	 newtax = (newuntaxed*tax)/100;
	
	 newp = newuntaxed+newtax;
	 
	
	 prevp = parseFloat(row.cells[5].innerHTML);
	 prevuntaxed = (prevp*100)/(100+tax);
	 
	 prevtax = (prevuntaxed*tax)/100;
	 
	 row.cells[5].innerHTML = newp;
	 
	 $(v).attr("value", quantity);
	  
	 $('#totaluntaxedamounttopay').html( (parseFloat( $('#totaluntaxedamounttopay').html())-prevuntaxed+newuntaxed).toFixed(2));
     $('#totaltaxtopay').html( ( (parseFloat( $('#totaltaxtopay').html()).toFixed(2)) -prevtax+newtax).toFixed(2) );
     $('#totalamounttopay').html( (parseFloat($('#totalamounttopay').html()).toFixed(2)-prevp+newp).toFixed(2) );
     
	
}

function submitform(){
	$('#submitbutton').click();
}



function preventInput(ev) {
    ev.preventDefault();
}