<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Login</title>
</head>
<body>
	<%@ page
			import="shopApp.*"
			import="java.sql.*"
	%>
	<% 
	if(request.getMethod().equals("POST")) {
		Connection conn = null;
		PreparedStatement pstmt = null;
	    ResultSet rs = null;
	    
	   	String userRole = null;
		try{
				
			String userName = request.getParameter("userName");
			conn = Usage.connection();
			// Create the statement
	       	pstmt = conn.prepareStatement("SELECT * FROM users WHERE userName='" + userName +"';");

	        // Use the created statement to SELECT
	        // the student attributes FROM the Student table.
	        rs = pstmt.executeQuery();
	        if(rs.next()) {
	        	session.setAttribute("userName", userName);
	        	userRole = rs.getString("userRole");
	        	session.setAttribute("userRole", userRole);
	        	response.sendRedirect("home");
	 %>		
	      		
	    <% 
	        }
	        else {  	
	    %>
	    		<p style="color:red">The provided name <%=userName %> is not known</p>
	    		<p style="color:red">Please complete the "name" textbox again</p>
	    <%
	    	}
		} catch (SQLException e) {
	    	out.println(e.getMessage());
				out.println("<p>Your login failed</p>");
			
	    } catch (Exception e) {
			out.println(e.getMessage());
			out.println("<p>Your login failed</p>");
	    }
		finally {
	    	if (rs != null) {
	    		try {
	                rs.close();
	            } catch (SQLException e) { } // Ignore
	            rs = null;
	        }
	    	if (pstmt != null) {
	            try {
	                pstmt.close();
	            } catch (SQLException e) { } // Ignore
	            pstmt = null;
	        }
	        if (conn != null) {
	            try {
	                conn.close();
	            } catch (SQLException e) { } // Ignore
	            conn = null;
	        }
	    }
	}
    %>
	<form method="POST" action="login">
		Username: 
		<input type="text" name="userName"><br>
		<input type="submit" value="Login">
	</form>
	<p>Do not have an account? <a href="signup">Signup here</a></p>
</body>
</html>