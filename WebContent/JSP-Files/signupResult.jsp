<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>Insert title here</title>
</head>
<body>
	

	<%@ page import="java.sql.*"%>
	<%-- -------- Open Connection Code -------- --%>
	<%
            Connection conn = null;
            PreparedStatement pstmt = null;
            
            try {
                // Registering Postgresql JDBC driver with the DriverManager
                Class.forName("org.postgresql.Driver");
                String SQLusername = "postgres";
                String SQLpassword = "postgres";
                // Open a connection to the database using DriverManager
                conn = DriverManager.getConnection(
                    "jdbc:postgresql://localhost:5432/test", SQLusername, SQLpassword
                    );
    %>

	<%-- -------- CREATE NEW USER Code -------- --%>
	<%
                    // Begin transaction
                    conn.setAutoCommit(false);
                    // Create the prepared statement and use it to
                    // INSERT student values INTO the students table.
                    pstmt = conn.prepareStatement("INSERT INTO users (userName, userRole, userAge, userState) VALUES (?, ?, ?, ?)");
                    String name = request.getParameter("userName").trim();
                  	//check if name is empty
                    if(name.isEmpty()) {
                    	throw new Exception();
                    }
            		String role = request.getParameter("userRole");
            		Integer age = Integer.parseInt(request.getParameter("userAge"));
            		String state = request.getParameter("userState");
            		
                   
                    pstmt.setString(1, name);
                    pstmt.setString(2, role);
                    pstmt.setInt(3, age);
                    pstmt.setString(4, state);
                    pstmt.executeUpdate();

                    // Commit transaction
                    conn.commit();
                    conn.setAutoCommit(true);
                	
    %>
    <p>You have sucessfully signed up</p>
    <a href="login">Please Login Here</a>
    <% 
            		conn.close();
   					pstmt.close();
            
            } catch (SQLException e) {
            	//out.println(e.getMessage());
   				out.println("<p>Your signup failed</p>");
   			
            }
            catch (Exception e) {
        		//out.println(e.getMessage());
        		out.println("<p>Your signup failed</p>");
        		
        	}
            finally {
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
   	%>
   
</body>
</html>