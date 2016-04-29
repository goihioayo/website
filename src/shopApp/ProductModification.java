package shopApp;

import java.sql.*;
import java.util.*;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

public class ProductModification {
	public static List<ProductSetup> listPro(String catFilter, String searchFilter) {
		List<ProductSetup> products = new ArrayList<ProductSetup>();
		Connection connect = null;
		Statement stmt = null;
		ResultSet ret = null;
		String cat = "";
		String search = "";
		String filter = null;
		try {
			if(catFilter != null && !catFilter.equals("-1")) {
				Integer cp = Integer.parseInt(catFilter);
				if(cp != null)
					cat = "proCatID = " + cp;
			}
		}
		catch (Exception e) {
			System.out.println("No category Filter");
		}
		try {
			if(searchFilter != null && !(searchFilter.isEmpty()) )
				search = "proName LIKE '%" + searchFilter + "%'";
		} 
		catch (Exception e) {
			System.out.println("No search Filter");
		}
		if( cat.isEmpty() ) {
			if( search.isEmpty() )
				filter = "";
			else
				filter = " WHERE " + search;
		}
		else {
			if( search.isEmpty() ) 
				filter = " WHERE " + cat;
			else
				filter = " WHERE " + cat + " AND " + search;				
		}
		
		try {
			connect = Usage.connection();
			stmt = connect.createStatement();
			ret = stmt.executeQuery(
				"WITH tmp AS (" +
				"SELECT * " +
				"FROM products" + filter + 
				") SELECT a.proID, a.proName, b.catName, b.catID, a.SKU, a.proPrice " +
				"FROM tmp a JOIN categories b " +
				"ON a.proCatID = b.catID " +
				"ORDER BY a.proID ASC;"
			);
			while( ret.next() ) {
				Integer tmpID = ret.getInt(1);
				String tmpName = ret.getString(2);
				String tmpCatName = ret.getString(3);
				int tmpCatID = ret.getInt(4);
				String tmpSKU = ret.getString(5);
				Integer tmpPrice = ret.getInt(6);
				products.add(new ProductSetup(tmpID, tmpName, tmpCatName, tmpCatID, tmpSKU, tmpPrice));
			}
			return products;
		}
		catch (Exception e) {
			System.out.println("SQL Error");
			System.err.println(e.getMessage());
			return new ArrayList<ProductSetup>();
		}
		finally {
			try {
				stmt.close();
				connect.close();
			}
			catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	public static String update(int proID, String proName, String proCatName, String proSKU, String proPrice) {
		if(proName.isEmpty() || proSKU.isEmpty() || proCatName.isEmpty()) {
			return "update fails";
		}
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			int price = Integer.parseInt(proPrice);
			if(price<0) {
				return "update fails";
			}
			conn = Usage.connection();
			conn.setAutoCommit(false);
			pstmt = conn.prepareStatement("UPDATE products SET proName=?, proCatID =?, "
							+ "SKU =?, proPrice =? "
                            + "WHERE proID = ?;");
			
            pstmt.setString(1, proName);
            pstmt.setInt(2, getCatID(proCatName));
            pstmt.setString(3, proSKU);
            pstmt.setInt(4, price);
            pstmt.setInt(5, proID);
            int rowCount = pstmt.executeUpdate();
			conn.commit();
            conn.setAutoCommit(true);
		} catch (Exception e) {
            System.err.println("update error " + e.getMessage());
            return Usage.failure("Sorry, update fails.");
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
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) { } // Ignore
                conn = null;
            }
        }
		return Usage.success("Congratulations, update successfully.");
	}
	
	public static String delete(int id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			
			conn = Usage.connection();
			conn.setAutoCommit(false);
			pstmt = conn.prepareStatement("DELETE FROM products WHERE proID = ?;");
			pstmt.setInt(1, id);
			int rowCount = pstmt.executeUpdate();
			conn.commit();
            conn.setAutoCommit(true);
		} catch (Exception e) {
			System.err.println("Delete error" + e.getMessage());
            return "Sorry, delete fails.";
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
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) { } // Ignore
                conn = null;
            }
        }
		return "Delete successfully";
	}
	
	public static String insert(String proName, String proCatName, String proSKU, String proPrice) {
		if(proName.isEmpty() || proSKU.isEmpty() || proCatName.isEmpty()) {
			return "insert fails";
		}
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			int price = Integer.parseInt(proPrice);
			if(price<0) {
				return "insert fails";
			}
			conn = Usage.connection();
			conn.setAutoCommit(false);
			
			pstmt = conn.prepareStatement("INSERT INTO products (proName, proCatID, SKU, proPrice) "
					+ "VALUES (?, ?, ?, ?);");
			pstmt.setString(1, proName);
			pstmt.setInt(2, getCatID(proCatName));
            pstmt.setString(3, proSKU);
            pstmt.setInt(4, price);
            int rowCount = pstmt.executeUpdate();
			conn.commit();
            conn.setAutoCommit(true);
		} catch (Exception e) {
            System.err.println("insert error " + e.getMessage());
            return "Sorry, insert fails.";
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
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) { } // Ignore
                conn = null;
            }
        }
		return Usage.success("Congratulations, insert successfully!");
	}
	
	private static int getCatID (String catName) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs= null;
		int catID = -1;
		try {
			
			conn = Usage.connection();
			pstmt = conn.prepareStatement("SELECT catID FROM categories WHERE catName = '" + catName +"';");
			rs = pstmt.executeQuery();
			if(rs.next()) {
				catID = rs.getInt(1);
			}
			else {
				catID = -1;
			}
		}
		catch (Exception e) {
			System.err.println("SQL select Error");
			System.err.println(e.getMessage());
		}
		finally {
			try {
				rs.close();
				pstmt.close();
				conn.close();
			}
			catch (SQLException e) {
				e.printStackTrace();
			}
		}
		System.err.println("catID="+catID);
		return catID;
	}
}