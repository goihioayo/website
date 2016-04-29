<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Home</title>
</head>
<body>
	<%@ page
			import="shopApp.*"
			import="java.sql.*"
	%>
	<% 
	String userRole = (String)session.getAttribute("userRole");
	String userName = (String)session.getAttribute("userName");
	Cart shoppingCart = new Cart();
	session.setAttribute("shoppingCart", shoppingCart);
	%>
	
	
	<%
	if(userRole == null) {
		out.println("<h3>No user logged in</h3>");
	}
	else if(userRole.equals("customer")) {
	%>
		<p>Hello <%=userName %></p>
      	<jsp:include page="/customerHome"/>
    <%
	}
	else if(userRole.equals("owner")){
	%>
		<p>Hello <%=userName %></p>
		<jsp:include page="/ownerHome"/>
	<%
	}
    %>
	
	
	
</body>
</html>