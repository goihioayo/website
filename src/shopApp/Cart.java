package shopApp;

import java.sql.*;
import java.util.*;

public class Cart {
	List<ProductSetup> productList;
	
	public Cart() {
		productList = new ArrayList<>();
	}
	
	public void add (ProductSetup product) {
		productList.add(product);
	}
	
	public List<ProductSetup> getProductList() {
		return productList;
	}
	
	public boolean add(String proName, int proPrice, int proQuantity) {
		ProductSetup newProduct = new ProductSetup(proName, proPrice, proQuantity);
		productList.add(newProduct);
		return true;
	}
	
	public void clear() {
		productList = new ArrayList<>();
	}
	
	public boolean updateTable(String userName){
		Connection connect = null;
		Statement stmt1 = null;
		Statement stmt2 = null;
		PreparedStatement pstmt = null;
		ResultSet ret1 = null;
		ResultSet ret2 = null;
		try {
			connect = Usage.connection();
			
			Calendar calendar = Calendar.getInstance();
			java.util.Date now = calendar.getTime();
			java.sql.Timestamp currentTimestamp = new java.sql.Timestamp(now.getTime());	
		for(int i=0; i<productList.size(); i++)
		{
			stmt1 = connect.createStatement();
			stmt2 = connect.createStatement();
			pstmt = connect.prepareStatement("INSERT INTO orders (proID, proQuantity, userID, proPrice, orderTime) VALUES (?, ?, ?, ?, ?);");
			String proName = productList.get(i).getProName();
			int proID = 0;
			int userID = 0;
		
			
				connect.setAutoCommit(false);
				ret1 = stmt1.executeQuery(
						"SELECT proID " +
						"FROM products " + 
						"WHERE proName LIKE '%" + proName + "%';"
				);
				
				while( ret1.next() ) {
					proID = ret1.getInt(1);
				}
				ret2 = stmt2.executeQuery(
						"SELECT userID " +
						"FROM users " + 
						"WHERE userName LIKE '%" + userName + "%';"
				);
				while( ret2.next() ) {
					userID = ret2.getInt(1);
				}	
				
				
				pstmt.setInt(1, proID);
                pstmt.setInt(2, productList.get(i).getQuantity());
                pstmt.setInt(3, userID);
                pstmt.setInt(4, productList.get(i).getProPrice());
                pstmt.setTimestamp(5, currentTimestamp);
                pstmt.executeUpdate();
                stmt1.close();
                stmt2.close();
                pstmt.close();
              
                connect.commit();
                connect.setAutoCommit(true);
		}

			}
			catch (Exception e) {
	            return false;
	        }
	        finally {
	            // Release resources in a finally block in reverse-order of
	            // their creation
	            if (pstmt != null) {
	                try {
	                    pstmt.close();
	                } catch (SQLException e) { } // Ignore
	                pstmt = null;
	            }
	            if (stmt1 != null) {
	                try {
	                    stmt1.close();
	                } catch (SQLException e) { } // Ignore
	                stmt1 = null;
	            }
	            if (stmt2 != null) {
	                try {
	                    stmt2.close();
	                } catch (SQLException e) { } // Ignore
	                stmt2 = null;
	            }
	            if (connect != null) {
	                try {
	                    connect.close();
	                } catch (SQLException e) { } // Ignore
	                connect = null;
	            }
	        }
		
		return true;
	}
	
}
