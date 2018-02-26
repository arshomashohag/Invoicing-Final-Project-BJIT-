<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/sql" prefix="sql"%>
<%@ page isELIgnored="false"%>


<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>Invoicing | Home</title>
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
	
	
	
	
	<script type="text/javascript">
	function paginate(inc){
		
		var pn = parseInt($("#pagenumber").html());
		var tp = parseInt($("#totalPage").html());
		var flag=0;
		
		if(inc==(-1) ){
			if(pn>1){
				pn=pn-1;
				flag=1;
			}
		}
		else{
			if(pn<tp){
				pn=pn+1;
				flag=1;
			}
		}
		
		 
		if(flag==1){

			var xhttp = new XMLHttpRequest();
			  xhttp.onreadystatechange = function() {
			    if (this.readyState == 4 && this.status == 200) {
			      document.getElementById("invoicelist").innerHTML = this.response;
			      $("#pagenumber").html( parseInt($("#pagenumber").html())+inc);
			    }
			  };
			  xhttp.open("POST", "index?pn="+pn);
			  xhttp.send();
			
		}
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

				<a class="navbar-brand" href="#"><span>Invoicing</span></a>

			</div>
		</div>
		<!-- /.container-fluid -->
	</nav>



	<div id="sidebar-collapse" class="col-sm-3 col-lg-2 sidebar">
		<div class="profile-sidebar">
			<div class="profile-usertitle">

				<a href="#" class="profile-usertitle-name">Customer Invoices</a>

			</div>
			<div class="clear"></div>
		</div>

	</div>
	<!--/.sidebar-->

	<div class="col-sm-8 col-sm-offset-3 col-lg-10 col-lg-offset-2 main">

		<ol class="breadcrumb">
			<li class="active">Customer Invoices</li>
		</ol>

		<div class="panel panel-container" id="mainbody">

			<div class="container">

				<div class="col col-md-4" id="actions">
					<a href="create" class="btn btn-primary" id="createbutton">Create</a>
				</div>
				<div id="pagination"></div>

			</div>

			 

				<div class="panel panel-default">
					 
						<div class="panel-heading" style="float:right;">
					 
							<span id="pagenumber">1</span><span> / </span><span id="totalPage">${totalPage}</span>
							<button class="btn btn-default" onclick="paginate(-1)"><i class="glyphicon glyphicon-menu-left" ></i></button>
							<button class="btn btn-default" onclick="paginate(1)"><i class="glyphicon glyphicon-menu-right" ></i></button>
					 
						</div>
 


					<div class="panel-body">

						<table class="table table-bordered table-responsive">
							<thead>
								<tr>
									<th id="customername">Customer</th>
									<th id="date">Invoice Date</th>
									<th id="number">Number</th>
									<th id="salesperson">Salesperson</th>
									<th id="duedate">Due Date</th>
									<th id="sourcedoc">Source Document</th>
									<th id="total">Total</th>
									<th id="due">Amount Due</th>
									<th id="status">Status</th>
								</tr>
							</thead>

							<tbody id="invoicelist">
								<c:forEach items="${invoiceList}" var="invoice">
									<tr id="${invoice.id}">
										<td><a  href="details?id=${invoice.id}">${invoice.customer.name}</a></td>
										<td>${invoice.invoiceDate}</td>
										<td>${invoice.invoiceNumber}</td>
										<td>${invoice.salesperson}</td>
										<td>${invoice.dueDate}</td>
										<td>${invoice.srcDocument}</td>
										<td>${invoice.totalBill}</td>
										<td>${invoice.dueAmount}</td>
										<td>${invoice.status}</td>

									</tr>
								</c:forEach>
							</tbody>
						</table>

					</div>
				</div>

 
		</div>



	</div>
	<!--/.main-->

	 <script src="http://code.jquery.com/jquery-3.3.1.min.js"
		integrity="sha256-FgpCb/KJQlLNfOu91ta32o/NMZxltwRo8QtmkMRdAu8="
		crossorigin="anonymous"></script>
	<script src="<c:url value="/resources/static/js/bootstrap.min.js"/>"></script>
	<script src="<c:url value="/resources/static/js/chart.min.js"/>"></script>
	<script src="<c:url value="/resources/static/js/chart-data.js"/>"></script>
	<script src="<c:url value="/resources/static/js/easypiechart.js"/>"></script>
	<script
		src="<c:url value="/resources/static/js/easypiechart-data.js"/>"></script>
	<script
		src="<c:url value="/resources/static/js/bootstrap-datepicker.js"/>"></script>
	<script src="<c:url value="/resources/static/js/custom.js"/>"></script>
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