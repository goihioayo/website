<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Product Browsing</title>
</head>
<%@page import="java.util.*" import="java.sql.*" import="shopApp.*"%>
<%  
	String userRole = (String)session.getAttribute("userRole");
	String userName = (String)session.getAttribute("userName");
	Cart shoppingCart = (Cart)session.getAttribute("shoppingCart");
  	List<CategorySetup> categories = CatModification.listCat();
	String action = request.getParameter("action");
	List<ProductSetup> products = null;
	String result = null;

	
	
	String catFilter = (String)request.getParameter("catFilter");
	String searchFilter = (String)request.getParameter("searchFilter");
	if(searchFilter == null) {
		searchFilter = "";
	}

%>
<body>
	<%
	if(userRole == null) {
		out.println("<h3>No user logged in</h3>");
	}
	else 
	{
		if(userRole.equals("customer")) {
	
	%>
		<p>Hello <%=userName %></p>
      	<jsp:include page="/customerHome"/>
    <%
	}
		else
		{
	%>
		<p>Hello <%=userName %></p>
		<jsp:include page="/ownerHome"/>
	<%
	}
    %>
	<%-- -------- Purchase Code -------- --%>
	<%
    if (action != null && action.equals("buy")) {
    	String proNameAdd = request.getParameter("proNameAdd");
    	int proPrice = Integer.parseInt(request.getParameter("proPriceAdd"));
    	try{
    		int quantity = Integer.parseInt(request.getParameter("quantity"));
    		if(quantity == 0)
        	{
        		result = "Please enter correct quantity";
        	}
        	else
        	{
        		List<ProductSetup> productList = shoppingCart.getProductList();
        		boolean exist = false;
        		for(int i=0; i<productList.size(); i++) {
        			if(productList.get(i).getProName().equals(proNameAdd))
        			{
        				productList.get(i).setQuantity(productList.get(i).getQuantity() + 1);
        				exist = true;
        			}	
        		}
        		if(exist == false)
        			shoppingCart.add(proNameAdd, proPrice, quantity);
        		result = "Added to Shopping Cart!";
        	}
    	}
    	catch(Exception e)
    	{
    		result = "Please enter correct quantity";
    	}
    }
	%>
	

		
	<h3>Product Browsing</h3>
	<% if(result!=null) { %>
	<h5 style="color:red;"><%=result%></h5>
	<% } %>
	
	<form action="productBrowsing" method="POST">
		<input type="hidden" name="action" value="searchFilter" />
		<input type="hidden" name="catFilter" value="<%=catFilter%>" />
		<p>
			Product Name: <input type="text" name="searchFilter" value="<%=searchFilter%>"> <input
				type="submit" value="Search">
		</p>
	</form>
	<table>
		<tr>
			<td valign="top">

				<h4>Categories List</h4>
				<ol>
					<li>
						<form action="productBrowsing" method="POST">
							<input type="hidden" name="action" value="catFilter" /> <input
								type="hidden" name="catFilter" value="-1"> 
								<input type="hidden" name="searchFilter" value="<%=searchFilter%>" /><input
								type="submit" value="All Products">
						</form>
					</li>
					<%
						categories = CatModification.listCat();

							// Iterate over the categories
							for (int i = 0; i < categories.size(); i++) {
								String catName = categories.get(i).getCatName();
								String catDescript = categories.get(i).getCatDescrip();
								int catID = categories.get(i).getCatID();
					%>
					<li>
						<form action="productBrowsing" method="POST">
							<input type="hidden" name="action" value="catFilter" />
							<input type="hidden" name="catFilter" value="<%=catID%>">
							<input type="hidden" name="searchFilter" value="<%=searchFilter%>" />
							<input type="submit" value="<%=catName%>">
						</form>
					</li>
					<%
						}
					%>
				</ol>
			</td>
			<td>
	<table border="1">
		<tr>
			<th width="20%"><B>Product Name</B></th>
			<th width="20%"><B>Category Name</B></th>
			<th width="20%"><B>SKU</B></th>
			<th width="20%"><B>Price</B></th>
		</tr>
		<%
			products = ProductModification.listPro(catFilter,searchFilter);
            // Iterate over the categories
            for(int i=0; i<products.size(); i++) {
            int proID = products.get(i).getProID();
            String proName = products.get(i).getProName();
            int proCatName = products.get(i).getProCatID();
            String sku = products.get(i).getSKU();
            int proPrice = products.get(i).getProPrice();
        %>
        <tr>
			<form action="productOrder" method="POST">
				<%-- Get the name --%>
				<td><%=proName%><input type="hidden" value="<%=proName%>" name="proName" size="15" /></td>
				<%-- Get the cat name --%>
				<td><input type="hidden" name="proCatName">
							<%
								for (int j = 0; j < categories.size(); j++) {
											String catName = categories.get(j).getCatName();
											int catID = categories.get(j).getCatID();
											if (catID == proCatName) {
							%>
							<value="<%=catName%>"><%=catName%>
							<%
									} 
								}
							%>
				</input></td>
				
				<%-- Get the sku --%>
				<td><%=sku%><input type="hidden" value="<%=sku%>" name="sku" size="15" /></td>
				<%-- Get the price --%>
				<td><%=proPrice%><input type="hidden" value="<%=proPrice%>" name="proPrice" size="15" /></td>
				<%-- Button --%>
				<td><input type="submit" value="Add to Shopping Cart"></td>
			</form>
		</tr>
		<%
			}
		%>
		</td>
		</tr>
	</table>
	<%
	}
    %>
		</table>
	</body>
</html>
        