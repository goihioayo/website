<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>productOrder</title>
</head>
<%@page import="java.util.*" import="java.sql.*" import="shopApp.*"%>
<%
	String userRole = (String)session.getAttribute("userRole");
	String userName = (String)session.getAttribute("userName");
	
%>


<body>
	
	<%
	
	if(userRole == null) {
		out.println("<h3>No user logged in</h3>");
	}
	else {
		if(userRole.equals("customer")) {
		%>
			<p>Hello <%=userName %></p>
			<jsp:include page="/customerHome"/>
		<%
		}
		
		if(userRole.equals("owner")){
		%>
			<p>Hello <%=userName %></p>
			<jsp:include page="/ownerHome"/>
		<%
		}
		
		
			
		String proNameAdd = request.getParameter("proName");
		String proPriceAdd = request.getParameter("proPrice");
		if(proNameAdd == null || proPriceAdd == null) {
			out.println("<h3>The request is invalid</h3>");
		}
		else {
			Cart shoppingCart = (Cart)session.getAttribute("shoppingCart");
			List<ProductSetup> products = shoppingCart.getProductList();
			List<CategorySetup> categories = CatModification.listCat();
	%>
	<table border="1">
	<tr>
			<th width="20%"><B>Product Name</B></th>
			<th width="20%"><B>Price</B></th>
			<th width="20%"><B>Quantity</B></th>
	</tr>
	<tr>
		<form action="productBrowsing" method="POST">
			<input type="hidden" name="action" value="buy" />
			<td><%=proNameAdd%><input type="hidden" name="proNameAdd" value="<%=proNameAdd%>"></td>
			<td><%=proPriceAdd%><input type="hidden" name="proPriceAdd" value="<%=proPriceAdd%>"></td>
			<td><input type="text" name="quantity" size="15"></td>
			<td><input type="submit" value="Buy" /></td>
		</form>
	</tr>
	</table>
	
	
	
	
	<h3>Shopping Cart</h3>
	<table border="1">
		<tr>
			<th width="20%"><B>Product Name</B></th>
			<th width="20%"><B>Price</B></th>
			<th width="20%"><B>Quantity</B></th>
		</tr>
		<%
            // Iterate over the categories
            for(int i=0; i<products.size(); i++) {
            	String proName = products.get(i).getProName();
            	int quantity = products.get(i).getQuantity();
            	int proPrice = products.get(i).getProPrice();
        %>
        <tr>
				<td><%=proName%></td>
				<td><%=proPrice%></td>
				<td><%=quantity%></td>
		</tr>
	<%
			}
	%>
		
	</table>
	<%
		}
	%>
	<%
	}
	%>
</body>