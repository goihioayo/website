<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>ShoppingCart</title>
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
		%>
	<%
	Cart shoppingCart = (Cart)session.getAttribute("shoppingCart");
	List<ProductSetup> products = shoppingCart.getProductList();
	List<CategorySetup> categories = CatModification.listCat();
	%>
	
	
	<h3>Shopping Cart</h3>
	<table border="1">
		<tr>
			<th width="20%"><B>Product Name</B></th>
			<th width="20%"><B>Price</B></th>
			<th width="20%"><B>Quantity</B></th>
			<th width="20%"><B>Amount Price</B>
		</tr>
		<%
			int totalPrice = 0;
            // Iterate over the categories
            for(int i=0; i<products.size(); i++) {
            	String proName = products.get(i).getProName();
            	int quantity = products.get(i).getQuantity();
            	int proPrice = products.get(i).getProPrice();
            	totalPrice += proPrice*quantity;
        %>
        <tr>
				<td><%=proName%></td>
				<td><%=proPrice%></td>
				<td><%=quantity%></td>
				<td><%=quantity*proPrice%></td>
		</tr>
	<%
			}
	%>
		<tr>
			<td></td>
			<td></td>
			<td><B>Total Price:</B></td>
			<td><%=totalPrice%></td>
		</tr>	
	</table>
	<br>
	<form method="POST" action="confirmation">
		Credit Card Number: 
		<input type="text" name="creditCard"><br>
		<input type="hidden" name="action" value="purchase">
		<br>
		<input type="submit" value="Purchase">
	</form>
	<%
	}
	%>
</body>