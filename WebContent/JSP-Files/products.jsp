<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>categories</title>
</head>
<%@page import="java.util.*" import="java.sql.*" import="shopApp.*"%>
<%
	String userRole = (String)session.getAttribute("userRole");
	String userName = (String)session.getAttribute("userName");
	String actionResult = null;
%>

<body>
	<%
	if(userRole == null) {
		out.println("<h3>No user logged in</h3>");
	}
	else if(userRole.equals("customer")) {
	%>
		<p style="color: red">This page is available to owners only</p>
    <%
	}
	else if(userRole.equals("owner")){
	%>
		<p>Hello <%=userName %></p>
		<jsp:include page="/ownerHome"/>
		
	<%
	List<ProductSetup> products = null;
	String action = request.getParameter("action");
	
	
	String catFilter = (String)request.getParameter("catFilter");
	String searchFilter = (String)request.getParameter("searchFilter");
	if(searchFilter == null) {
		searchFilter = "";
	}

	List<CategorySetup> categories = CatModification.listCat();
	%>

	<%-- -------- UPDATE Code -------- --%>
	<%
    // Check if an update is requested
    if (action != null && action.equals("update")) {
    	int proID = Integer.parseInt(request.getParameter("proID"));
    	String proName = request.getParameter("proName");
    	String proSKU = request.getParameter("proSKU");
    	String proPrice = request.getParameter("proPrice");
    	String proCatName = request.getParameter("proCatName");
    	actionResult = ProductModification.update(proID, proName, proCatName, proSKU, proPrice);
    }
	%>
	<%-- -------- INSERT Code -------- --%>
	<%
	if (action != null && action.equals("insert")) {
		
		//int proID = Integer.parseInt(request.getParameter("proID"));
    	String proName = request.getParameter("proName");
    	String proSKU = request.getParameter("proSKU");
    	String proPrice = request.getParameter("proPrice");
    	String proCatName = request.getParameter("proCatName");
    	actionResult = ProductModification.insert(proName, proCatName, proSKU, proPrice);
		
	}
    %>
    
    <%-- -------- DELETE Code -------- --%>
	<%
	if (action != null && action.equals("delete")) {
		int proID = Integer.parseInt(request.getParameter("proID"));
		actionResult = ProductModification.delete(proID);
	}
    %>
  


	<h3>Product Browsing</h3>
	<% if(actionResult!=null) { %>
	<h5 style="color:red;"><%=actionResult%></h5>
	<% } %>
	<form action="products" method="POST">
		<input type="hidden" name="action" value="searchFilter" />
		<input type="hidden" name="catFilter" value="<%=catFilter%>" />
		<p>
			Product Name: <input type="text" name="searchFilter" value="<%=searchFilter%>"> <input
				type="submit" value="Search">
		</p>
	</form>
	<br>


	<table>
		<tr>
			<td valign="top">

				<h4>Categories List</h4>
				<ol>
					<li>
						<form action="products" method="POST">
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
						<form action="products" method="POST">
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
						<th width="20%"><B>SKU</B></th>
						<th width="10%"><B>Price</B></th>
						<th width="20%"><B>Category Name</B></th>
					</tr>

					<tr>
						<form action="products" method="POST">
							<input type="hidden" name="action" value="insert" />
							<input type="hidden" name="catFilter" value="<%=catFilter%>" />
							<input type="hidden" name="searchFilter" value="<%=searchFilter%>" />
							<td><input type="text" name="proName" value="" size="15"></td>
							<td><input type="text" name="proSKU" value="" size="15"></td>
							<td><input type="text" name="proPrice" value="" size="15"></td>
							<td><select name="proCatName">
									<%
										for (int i = 0; i < categories.size(); i++) {
												String catName = categories.get(i).getCatName();
												int catID = categories.get(i).getCatID();
									%>

									<option value="<%=catName%>"><%=catName%></option>
									<%
										}
									%>
							</select></td>
							<td><input type="submit" value="Insert" /></td>
						</form>
					</tr>

					<%-- -------- Iteration Code -------- --%>
					<%
						products = ProductModification.listPro(catFilter, searchFilter);
							// Iterate over the categories
							for (int i = 0; i < products.size(); i++) {
								int proID = products.get(i).getProID();
								String proName = products.get(i).getProName();
								String proSKU = products.get(i).getSKU();
								int proPrice = products.get(i).getProPrice();
								int proCatID = products.get(i).getProCatID();
								String proCatName = products.get(i).getProCatName();
					%>

					<tr>
						<form action="products" method="POST">
							<input type="hidden" name="action" value="update" /> 
							<input type="hidden" name="searchFilter" value="<%=searchFilter%>" />
							<input type="hidden" name="catFilter" value="<%=catFilter%>" />
							<input

								type="hidden" name="proID" value="<%=proID%>" />
							<%-- Get the name --%>
							<td><input value="<%=proName%>" name="proName" size="15" /></td>

							<%-- Get the SKU --%>
							<td><input value="<%=proSKU%>" name="proSKU" size="15" /></td>
							<%-- Get the price --%>
							<td><input value="<%=proPrice%>" name="proPrice" size="15" /></td>
							<td><select name="proCatName">
									<%
										for (int j = 0; j < categories.size(); j++) {
													String catName = categories.get(j).getCatName();
													int catID = categories.get(j).getCatID();
													if (catName.equals(proCatName)) {
									%>
									<option selected="selected" value="<%=catName%>"><%=catName%></option>
									<%
										} else {
									%>
									<option value="<%=catName%>"><%=catName%></option>
									<%
										}
									%>
									<%
										}
									%>
							</select></td>

							<%-- update Button --%>
							<td><input type="submit" value="Update"></td>
						</form>

						<%-- delete Button --%>
						<form action="products" method="POST">
							<input type="hidden" name="action" value="delete" /> 
							<input type="hidden" name="catFilter" value="<%=catFilter%>" />
							<input type="hidden" name="searchFilter" value="<%=searchFilter%>" /><input
								type="hidden" value="<%=proID%>" name="proID" />
							<%-- Button --%>
							<td><input type="submit" value="Delete" /></td>
						</form>

					</tr>
					<%
						}
					%>
				</table> <%
	}
	%>
			</td>
		</tr>
	</table>
</body>