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
	List<CategorySetup> categories = null;
	String action = request.getParameter("action");
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
	


	<h3>Categories</h3>
	
	<%-- -------- UPDATE Code -------- --%>
	<%
    // Check if an update is requested
    if (action != null && action.equals("update")) {
    	String catName = request.getParameter("catName");
    	String catDescript = request.getParameter("catDescript");
    	int catID = Integer.parseInt(request.getParameter("catID"));
    	actionResult = CatModification.update(catID, catName, catDescript);
    }
	%>
	<%-- -------- INSERT Code -------- --%>
	<%
	if (action != null && action.equals("insert")) {
    	String catName = request.getParameter("catName");
    	String catDescript = request.getParameter("catDescript");
    	actionResult = CatModification.insert(catName, catDescript);
	}
    %>
    
    <%-- -------- DELETE Code -------- --%>
	<%
	if (action != null && action.equals("delete")) {
		int catID = Integer.parseInt(request.getParameter("catID"));
    	actionResult = CatModification.delete(catID);
	}
    %>
	<% if(actionResult!=null) { %>
	<h5 style="color:red;"><%=actionResult%></h5>
	<% } %>
	<table border="1">
		<tr>
			<th>Name</th>
			<th>Description</th>
		</tr>

		<tr>
			<form action="categories" method="POST">
				<input type="hidden" name="action" value="insert" />
				<th><input type="text" name="catName" value="" size="30"></th>
				<th><textarea name="catDescript" rows="4" cols="50"></textarea></th>
				<th><input type="submit" value="Insert" /></th>
			</form>
		</tr>

		<%-- -------- Iteration Code -------- --%>
		<%
			categories = CatModification.listCat();
                // Iterate over the categories
            for(int i=0; i<categories.size(); i++) {
            	String catName = categories.get(i).getCatName();
            	String catDescript = categories.get(i).getCatDescrip();
            	int catID = categories.get(i).getCatID();
            %>

		<tr>
			<form action="categories" method="POST">
				<input type="hidden" name="action" value="update" /> <input
					type="hidden" name="catID" value="<%=catID %>" />

				<%-- Get the name --%>
				<td><input value="<%=catName%>" name="catName" size="30" /></td>

				<%-- Get the description --%>
				<td><textarea name="catDescript" rows="4" cols="50"><%=catDescript%></textarea></td>
				<%-- Button --%>
				<td><input type="submit" value="Update"></td>
			</form>
			<% if(CatModification.canDelete(catID)) { %>
			<form action="categories" method="POST">
				<input type="hidden" name="action" value="delete" /> <input
					type="hidden" value="<%=catID%>" name="catID" />
				<%-- Button --%>
				
				<td><input type="submit" value="Delete" /></td>
			</form>
			<% } %>
		</tr>
		<%
          		}
       		%>
	</table>
	<% } %>
</body>
</html>