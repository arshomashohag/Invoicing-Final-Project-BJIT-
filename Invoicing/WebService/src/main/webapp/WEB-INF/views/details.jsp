<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>

<%@ page isELIgnored="false"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Invoicing | Details</title>
<link href="<c:url value="/resources/static/css/bootstrap.min.css"/>"
	rel="stylesheet">
<link href="<c:url value="/resources/static/css/font-awesome.min.css"/>"
	rel="stylesheet">
<link href="<c:url value="/resources/static/css/datepicker3.css"/>"
	rel="stylesheet">
<link href="<c:url value="/resources/static/css/styles.css"/>"
	rel="stylesheet">


<link
	href="https://fonts.googleapis.com/css?family=Montserrat:300,300i,400,400i,500,500i,600,600i,700,700i"
	rel="stylesheet">

<style type="text/css">
.borderless td, .borderless th {
	border: none;
}
</style>



<script type="text/javascript">

	function editInvoice() {
		$('#editbody').hide();
		$('#formdiv').show();

	}
	

	 
	function updateinvoice(ev){
		var inid = $('#invoiceid').val();
		 
		
		var pids=[];
		var prods=[];
	    var i=0;
		 ev.preventDefault();
		 
		 $('select[name="psid"]').each(function() {
			pids.push($(this).val());
			
		});
		 
		 i=0;
		 
		 $('input[name="quantity"]').each(function() {
			 prods.push([pids[i], $(this).val()]);
				i++;
			});
		 
		  
		 
	 
		    var xhttp = new XMLHttpRequest();
		    xhttp.onreadystatechange = function() {
		      if (this.readyState == 4 && this.status == 200) {
		       document.getElementById("discardinvoice").click();
		      }
		       
		    };
		    xhttp.open("POST", "update?id="+inid+"&prods="+prods);
		    xhttp.send();
		    
		 
	}
	
	function addDetailsById(id) {
		  
	     
	     
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
	                	 
	                	 newtax = (value.price*value.tax)/100;
	                	
	                	 prevp = parseFloat(row.cells[5].innerHTML);
	                	 newp = value.price + newtax;
	                	 
	                	
	                	 
	                	 prevuntaxed = parseFloat(row.cells[3].innerHTML);
	                	 newuntaxed = value.price;
	                	 
	                	 prevtax = prevp-prevuntaxed;
	                	 
	                    row.cells[1].innerHTML = value.description;
	                    row.cells[2].innerHTML = "<input type='number' class='form-control'  min='1' max='" +
	                        value.quantity +
	                        "' value='1' required onkeydown='preventInput(event)' name='quantity' onchange='calculateAmount(this)'>";
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
	        row.cells[2].innerHTML = "<input type='number' class='form-control' disabled min='1' max='" + maximum + "' value='1' required name='quantity'>";
	        row.cells[3].innerHTML = "0.0";
	        row.cells[4].innerHTML = "0.0";
	        row.cells[5].innerHTML = "0.0";
	        $('#totaluntaxedamounttopay').html( (parseFloat( $('#totaluntaxedamounttopay').html())-prevuntaxed+newuntaxed).toFixed(2));
	        $('#totaltaxtopay').html( ( (parseFloat( $('#totaltaxtopay').html()).toFixed(2)) -prevtax+newtax).toFixed(2) );
	        $('#totalamounttopay').html( (parseFloat($('#totalamounttopay').html()).toFixed(2)-prevp+newp).toFixed(2) );
	    }

	}
function validatePayment(id) {
	 
	 var xhttp = new XMLHttpRequest();
    xhttp.onreadystatechange = function() {
      if (this.readyState == 4 && this.status == 200) {
       document.getElementById("discardinvoice").click();
      }
       
    };
    xhttp.open("POST", "register?id="+id);
    xhttp.send(); 
}
	
</script>

</head>
<body >
	<nav class="navbar navbar-custom navbar-fixed-top" role="navigation">
		<div class="container-fluid">
			<div class="navbar-header">
				<button type="button" class="navbar-toggle collapsed"
					data-toggle="collapse" data-target="#sidebar-collapse">
					<span class="sr-only">Toggle navigation</span> <span
						class="icon-bar"></span> <span class="icon-bar"></span> <span
						class="icon-bar"></span>
				</button>

				<a class="navbar-brand" href="index"><span>Invoicing</span></a>

			</div>
		</div>
		<!-- /.container-fluid -->
	</nav>



	<div id="sidebar-collapse" class="col-sm-3 col-lg-2 sidebar">
		<div class="profile-sidebar">
			<div class="profile-usertitle">

				<a href="index" class="profile-usertitle-name">Customer Invoices</a>

			</div>
			<div class="clear"></div>
		</div>

	</div>
	<!--/.sidebar-->

	<div class="col-sm-8 col-sm-offset-3 col-lg-10 col-lg-offset-2 main">

		<ol class="breadcrumb">
			<li class="active">Customer Invoices / ${invoice.invoiceNumber}</li>
		</ol>

		<div class="panel panel-container" id="mainbody">



			<!-- Form div start -->
			<div id="formdiv" style="display: none;">
				<div class="container">

					<div class="col col-md-4" id="actions">
						<button class="btn btn-primary" id="saveinvoice"
							onclick='submitform()'>Save</button>
						<a href="details?id=${invoice.id}" class="btn btn-default" id="discardinvoice" >Discard</a>
					</div>


				</div>


				<br>
				<div class="panel panel-warning">
					<div class="panel-heading">
						<div style="float: right">
						<c:choose>
							<c:when test="${invoice.status=='Open'}">
								<span class="btn btn-primary" style="border-radius: 50%">Open</span>
								<span class="btn btn-default" style="border-radius: 50%">Paid</span>
							</c:when>
							<c:otherwise>
								<span class="btn btn-default" style="border-radius: 50%">Open</span>
								<span class="btn btn-primary" style="border-radius: 50%">Paid</span>
							</c:otherwise>
						</c:choose>
						</div>
					
					</div>


					<div class="panel-body">
						<input  hidden value="${invoice.id}" id="invoiceid">
						<form action="create" method="post" name="invoiceform"
							onsubmit="updateinvoice(event)">

							<div class="row">
								<div class="col col-md-12">
									<h2> ${invoice.invoiceNumber}</h2>
								</div>
							</div>

							<div class="row">
								<div class="col col-md-2">
									<p>Customer</p>
								</div>
								<div class="col col-md-3">
									<select class="form-control" required name="customerid">

										
											<option value="${invoice.customer.cid}" name='customer_cid'>${invoice.customer.name}</option>
										
									</select>
								</div>
								<div class="col col-md-1"></div>


								<div class="col col-md-2">
									<p>Invoice Date</p>
								</div>
								<div class="col col-md-3">
									<input type="text" id="invoiceDate" class="form-control"
										required value="${invoice.invoiceDate}" disabled>
								</div>
							</div>

							<br>

							<div class="row">
								<div class="col col-md-2">
									<p>Payment Terms</p>
								</div>
								<div class="col col-md-3">
									<select class="form-control" required
										name="payment_term">

										<option value="15 Days">${invoice.payment_term}</option>
										 
									</select>
								</div>
								<div class="col col-md-1"></div>


								<div class="col col-md-2">
									<p>Salesperson</p>
								</div>
								<div class="col col-md-3">
									<select  class="form-control" required
										name="salesperson">
										<option value="Administraor"> ${invoice.salesperson} </option>
										
									</select>
								</div>
							</div>

							<br>
							<ul class="nav nav-tabs" id="myTabs">
								<li class="nav-item active"><a class="nav-link active"
									id="home-tab" data-toggle="tab" href="#productslist" role="tab"
									aria-controls="home" aria-selected="true">Invoice Lines </a></li>

							</ul>

							<div class="tab-content" id="myTabContent">
								<div class="tab-pane fade show in" id="productslist"
									role="tabpanel" aria-labelledby="home-tab">

									<table class="table table-bordered table-striped">
										<thead>
											<tr>
												<th >Product</th>
												<th >Description</th>
												<th >Quantity</th>
												<th >Unit Price</th>
												<th >Taxes</th>
												<th >Amount</th>
											</tr>

										</thead>
										
										<tbody id="productlisttabbody">
										   <c:choose>
										    
										    <c:when test="${invoice.status=='Open'}">
											<c:forEach items="${invoice.productList}" var="product">
											<c:set var="untaxedamount"
												value="${untaxedamount + (product.products.price*product.quantity)}"></c:set>
											<c:set var="taxes"
												value="${taxes+product.total-(product.products.price*product.quantity)}"></c:set>
											<tr>
 
												 <td>
												 	<select class='form-control' onchange='addDetails(this)' required name='psid'><option value='0'></option>
														<c:forEach items="${prodsList}" var="prods">
														<c:choose>
															<c:when test="${prods.psid==product.products.psid}">
																<option value="${prods.psid}" selected>${prods.productname}</option>
															</c:when>
															<c:otherwise>
																<option value="${prods.psid}">${prods.productname}</option>
															</c:otherwise>
														</c:choose>
														</c:forEach>
													</select>
												</td>
												
												<td>${product.products.description}</td>
												
  

												<td> <input type='number' class='form-control'  min='1' max="${product.products.quantity}" onkeydown='preventInput(event)' onchange='calculateAmount(this)' value="${product.quantity}" required name='quantity'></td>
												
												
												<td>${product.products.price}</td>
												<td>${product.products.tax}</td>
												<td>${product.total}</td>
											</tr>
										</c:forEach>
											
											<tr>
												<td colspan="6"><a onclick="addAProduct()"
													style="cursor: pointer">Add an Item</a></td>

											</tr>
											</c:when>
											
											<c:otherwise>
												<tr>
													<td colspan="6">The invoice is paid ! Not Editable</td>
												</tr>
											</c:otherwise>
											
											</c:choose>
										</tbody>

									</table>

								</div>

							</div>
							<input type="submit" id="submitbutton" hidden>

						</form>

						<!-- Form End -->



						<div class='row'>

							<div class="col col-md-6"></div>
							<div class="col col-md-6" style="text-align: right">
								<div class="row">
									<div class="col col-sm-8">Untaxed Amount :</div>
									<div class="col col-sm-4">
										$<span id="totaluntaxedamounttopay">${untaxedamount}</span>
									</div>
								</div>
								<div class="row">
									<div class="col col-sm-8">Tax :</div>
									<div class="col col-sm-4">
										$<span id="totaltaxtopay">${taxes}</span>
									</div>
								</div>
								<hr>
								<div class="row" style="font-weight: bold">
									<div class="col col-sm-8">Total :</div>
									<div class="col col-sm-4">
										$<span id="totalamounttopay">${untaxedamount+taxes}</span>
									</div>
								</div>
							</div>

						</div>

					</div>



				</div>

			</div>



			<!-- Edit div start -->
			<div id="editbody">
				<div class="container">

					<div class="col col-md-4" >
						<button class="btn btn-primary" 
							onclick="editInvoice()">Edit</button>
						<a class="btn btn-default" href="create" >Create</a>
					</div>
					

				</div>
				<br>
				<div class="panel panel-warning">
					<div class="panel-heading" >						
						
						<!-- Button trigger modal -->
						
						   <c:choose>
						   <c:when test="${ invoice.status=='Open'}">
							<button type="button" class="btn btn-primary" data-toggle="modal" data-target="#exampleModal">
							  Register Payment
							</button>
							
							<!-- Modal -->
							<div style="color: black" class="modal" id="exampleModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
							  <div class="modal-dialog" role="document">
							    <div class="modal-content">
							      <div class="modal-header"> 
							        <h5 class="modal-title" id="exampleModalLabel">Register Payment / ${ invoice.invoiceNumber } </h5>
							        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
							          <span aria-hidden="true">&times;</span>
							        </button>
							      </div>
							      <div class="modal-body">
							         	<div class="row">
							         		
									         <div class="col col-md-6">
							         			<div class="row">
							         				<div class="col col-sm-6">
							         					<span>Payment Journal</span>
							         				</div>
							         				<div class="col col-sm-6">
							         					<select name="method">
												         	<option value="cash">Cash</option>
												         	<option value="Bank">Bank</option>
												         </select>
							         				</div>
							         			</div>
							         		</div>
							         		
							         		<div class="col col-md-6">
							         			<div class="row">
							         				<div class="col col-sm-6">
							         					<span>Payment Date</span>
							         				</div>
							         				<div class="col col-sm-6">
							         				
									         				 <jsp:useBean id="now" class="java.util.Date" />
															 <fmt:formatDate var="thisdate" value="${now}" pattern="dd-m-yyyy" />
															 
							         					<span> ${ thisdate } </span>
							         				</div>
							         			</div>
							         		</div>
									         
									         
							         	</div>
							         	
							         	<div class="row">
							         		<div class="col col-md-6">
							         			<div class="row">
							         				<div class="col col-sm-6">
							         					<span>Payment Amount</span>
							         				</div>
							         				<div class="col col-sm-6">
							         					<span> ${invoice.totalBill} </span>
							         				</div>
							         			</div>
							         		</div>
							         		
							         		<div class="col col-md-6">
							         			<div class="row">
							         				<div class="col col-sm-6">
							         					<span>Memo</span>
							         				</div>
							         				<div class="col col-sm-6">
							         					<span> ${invoice.invoiceNumber}</span>
							         				</div>
							         			</div>
							         		</div>
							         	</div>
							      </div>
							      <div class="modal-footer">
							        <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
							        <button type="button" class="btn btn-primary" onclick="validatePayment(${invoice.id})">Validate</button>
							      </div>
							    </div>
							  </div>
							</div>
							</c:when>
							<c:otherwise>
								<span >Paid Invoice</span>
							</c:otherwise>
							
							
						</c:choose>
						
						
						
						
						
						<div style="float: right">
						<c:choose>
							<c:when test="${invoice.status=='Open'}">
								<span class="btn btn-primary" style="border-radius: 50%">Open</span>
								<span class="btn btn-default" style="border-radius: 50%">Paid</span>
							</c:when>
							<c:otherwise>
								<span class="btn btn-default" style="border-radius: 50%">Open</span>
								<span class="btn btn-primary" style="border-radius: 50%">Paid</span>
							</c:otherwise>
						</c:choose>
						</div>
						
					</div>
					<div class="panel-body">
						<div class="row">
							<div class="col col-md-8">
								<div class="row">

									<div class="col col-sm-4">
										<span>Customer </span>

									</div>
									<div class="col col-sm-8" style="border-left: 1px solid black">
										<p>${invoice.customer.name}</p>
										<p>
											<span>${invoice.customer.address.zip},</span>
											${invoice.customer.address.city}
										</p>
										<p>${invoice.customer.address.state}</p>
										<p>${invoice.customer.address.phone}</p>

									</div>
								</div>

								<div class="row">
									<div class="col col-sm-4">
										<span>Payment Terms</span>
									</div>
									<div class="col col-sm-8" style="border-left: 1px solid black">
										<p>${invoice.payment_term}</p>
									</div>
								</div>


							</div>


							<div class="col col-md-4">
								<div class="row">
									<div class="col col-sm-6">
										<span>Invoice Date</span>
									</div>
									<div class="col col-sm-6" style="border-left: 1px solid black">
										<p>${invoice.invoiceDate}</p>
									</div>

								</div>

								<div class="row">
									<div class="col col-sm-6">
										<span>Salesperson</span>
									</div>
									<div class="col col-sm-6" style="border-left: 1px solid black">
										<p>${invoice.salesperson}</p>
									</div>
								</div>
							</div>
						</div>

						<br>

						<ul class="nav nav-tabs" id="myTabse">
							<li class="nav-item active"><a class="nav-link active"
								id="home-tabe" data-toggle="tab" href="#productslist" role="tab"
								aria-controls="home" aria-selected="true">Invoice Lines </a></li>

						</ul>

						<div class="tab-content" id="myTabContente">
							<div class="tab-pane fade show in" id="productsliste"
								role="tabpanel" aria-labelledby="home-tabe">

								<table class="table table-bordered table-striped">
									<thead>
										<tr>
											<th >Product</th>
											<th >Description</th>
											<th >Quantity</th>
											<th >Unit Price</th>
											<th >Taxes</th>
											<th >Amount</th>
										</tr>

									</thead>
									<tbody >
										<c:set var="untaxedamount" value="0"></c:set>
										<c:set var="taxes" value="0"></c:set>

										<c:forEach items="${invoice.productList}" var="product">
											<c:set var="untaxedamount"
												value="${untaxedamount + (product.products.price*product.quantity)}"></c:set>
											<c:set var="taxes"
												value="${taxes+product.total-(product.products.price*product.quantity)}"></c:set>
											<tr>
												<td>${product.products.productname}</td>
												<td>${product.products.description}</td>
												<td>${product.quantity}</td>
												<td>${product.products.price}</td>
												<td>${product.products.tax}</td>
												<td>${product.total}</td>
											</tr>
										</c:forEach>

									</tbody>

								</table>

							</div>

						</div>

						<div class='row'>

							<div class="col col-md-6"></div>
							<div class="col col-md-6" style="text-align: right">
								<div class="row">
									<div class="col col-sm-8">Untaxed Amount :</div>
									<div class="col col-sm-4" id="untaxedamount">
										<fmt:formatNumber type="number" maxFractionDigits="2"
											value="${untaxedamount}" />
									</div>
								</div>
								<div class="row">
									<div class="col col-sm-8">Tax :</div>
									<div class="col col-sm-4" id="tax">
										<fmt:formatNumber type="number" maxFractionDigits="2"
											value="${taxes}" />
									</div>
								</div>
								<hr>
								<div class="row" style="font-weight: bold">
									<div class="col col-sm-8">Total :</div>
									<div class="col col-sm-4" id="total">
										<fmt:formatNumber type="number" maxFractionDigits="2"
											value="${untaxedamount+taxes}" />
									</div>
								</div>
							</div>

						</div>

					</div>
				</div>
			</div>

		</div>



	</div>
	<!--/.main-->

	<script src="http://code.jquery.com/jquery-3.3.1.min.js"
		integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
		crossorigin="anonymous"></script>
		
	<script src="<c:url value="/resources/static/js/main.js"/>"></script>
	<script src="<c:url value="/resources/static/js/bootstrap.min.js"/>"></script>
	 
	<script>
		window.onload = function() {

			var chart1 = document.getElementById("line-chart").getContext("2d");
			window.myLine = new Chart(chart1).Line(lineChartData, {
				responsive : true,
				scaleLineColor : "rgba(0,0,0,.2)",
				scaleGridLineColor : "rgba(0,0,0,.05)",
				scaleFontColor : "#c5c7cc"
			});
		};
	</script>

</body>
</html>