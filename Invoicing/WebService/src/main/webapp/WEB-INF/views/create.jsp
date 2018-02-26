<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib  uri="http://www.springframework.org/tags" prefix="spring"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form"%>


<%@ page isELIgnored="false"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Invoicing | Create Invoice</title>
<link href="<c:url value="/resources/static/css/bootstrap.min.css"/>"
	rel="stylesheet">
<link href="<c:url value="/resources/static/css/font-awesome.min.css"/>"
	rel="stylesheet">

<link href="<c:url value="/resources/static/css/styles.css"/>"
	rel="stylesheet">


<link
	href="https://fonts.googleapis.com/css?family=Montserrat:300,300i,400,400i,500,500i,600,600i,700,700i"
	rel="stylesheet">




<script type="text/javascript">


function createnewinvoice(ev){
	
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
	 
	 var cname = $('#cname').val();
	 var invoiceDate = $('#invoiceDate').val();
	 var paymentTerm = $('#paymentTerm').val();
	 var salesPerson = $('#salesPerson').val();
	
	 
 
	    var xhttp = new XMLHttpRequest();
	    xhttp.onreadystatechange = function() {
	      if (this.readyState == 4 && this.status == 200) {
	       document.getElementById("discardinvoice").click();
	      }
	       
	    };
	    xhttp.open("POST", "create?date="+invoiceDate+"&cname="+cname+"&paymentTerm="+paymentTerm+"&salesPerson="+salesPerson+"&prods="+prods);
	    xhttp.send();
	    
	 
}



</script>





</head>




<body>
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
			<li class="active">Customer Invoices / New</li>
		</ol>

		<div class="panel panel-container" id="mainbody">

			<div class="container">

				<div class="col col-md-4" id="actions">
					<button class="btn btn-primary" id="saveinvoice" onclick='submitform()'>Save</button>
					<a href="index" class="btn btn-default" id="discardinvoice" >Discard</a>
				</div>


			</div>



			<div class="panel panel-default">
				<div class="panel-heading"></div>


				<div class="panel-body">

					<form action="create" method="post" name="invoiceform" onsubmit="createnewinvoice(event)">

						<div class="row">
							<div class="col col-md-12">
								<h2>Open Invoice</h2>
							</div>
						</div>

						<div class="row">
							<div class="col col-md-2">
								<p>Customer</p>
							</div>
							<div class="col col-md-3">
								<select class="form-control" required
									name="customerid" id='cname'>

									<c:forEach items="${customerList}" var="customer">
										<option value="${customer.cid}" name='customer_cid' >${customer.name}</option>
									</c:forEach>
								</select>
							</div>
							<div class="col col-md-1"></div>


							<div class="col col-md-2">
								<p>Invoice Date</p>
							</div>
							<div class="col col-md-3">
								<input type="date" id="invoiceDate" class="form-control"
									required>
							</div>
						</div>

						<br>

						<div class="row">
							<div class="col col-md-2">
								<p>Payment Terms</p>
							</div>
							<div class="col col-md-3">
								<select id="paymentTerm" class="form-control" required
									name="payment_term">

									<option value="15 Days">15 Days</option>
									<option value="30% Advance End of Following Month">30% Advance End of Following Month</option>
									<option value="30 Net Days">30 Net Days</option>
									<option value="End of Following Month">End of Following Month</option>
									<option value="Immediate Payment">Immediate Payment</option>
								</select>
							</div>
							<div class="col col-md-1"></div>


							<div class="col col-md-2">
								<p>Salesperson</p>
							</div>
							<div class="col col-md-3">
								<select id="salesPerson" class="form-control" required
									name="salesperson">
									<option value="Administraor">Administraor</option>
									<option value="Demo Portal User">Demo Portal User</option>
									<option value="Demo User">Demo User</option>
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
											<th id="productname">Product</th>
											<th id="description">Description</th>
											<th id="quantity">Quantity</th>
											<th id="unitprice">Unit Price</th>
											<th id="taxes">Taxes</th>
											<th id="amount">Amount</th>
										</tr>

									</thead>
									<tbody id="productlisttabbody">
										<tr>
											<td colspan="6"><a onclick="addAProduct()"
												style="cursor: pointer">Add an Item</a></td>

										</tr>
									</tbody>

								</table>

							</div>

						</div>
						<input type="submit" id="submitbutton" hidden >
						 
					</form>
					
					<!-- Form End -->
					
					

					<div class='row'>

						<div class="col col-md-6"></div>
						<div class="col col-md-6" style="text-align: right">
							<div class="row">
								<div class="col col-sm-8">Untaxed Amount :</div>
								<div class="col col-sm-4" >$<span id="totaluntaxedamounttopay">0</span></div>
							</div>
							<div class="row">
								<div class="col col-sm-8">Tax :</div>
								<div class="col col-sm-4" >$<span id="totaltaxtopay">0</span></div>
							</div>
							<hr>
							<div class="row" style="font-weight: bold">
								<div class="col col-sm-8">Total :</div>
								<div class="col col-sm-4" >$<span id="totalamounttopay">0</span></div>
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
	<script src="<c:url value="/resources/static/js/bootstrap.min.js"/>"></script>
    
    <script src="<c:url value="/resources/static/js/main.js"/>"></script>
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