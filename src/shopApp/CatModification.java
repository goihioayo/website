package shopApp;

import javax.servlet.http.HttpServletRequest;

import java.util.*;
import java.sql.*;



public class CatModification {
	public static List<CategorySetup> listCat() {
		Connection connect = null;
		PreparedStatement pstmt = null;
		ResultSet ret = null;
		List<CategorySetup> categories = new ArrayList<CategorySetup>();
		try {
			
			connect = Usage.connection();
			pstmt = connect.prepareStatement("SELECT *" +
					"FROM categories ORDER BY catID ASC;" 
					);
			/*
			pstmt = connect.prepareStatement("SELECT COUNT(*) as count " +
					"FROM categories a " + 
					"LEFT OUTER JOIN products b " +
					"ON a.catID=b.proCatID " +
					"GROUP BY a.catID;");
					*/
			ret = pstmt.executeQuery();
			
			while (ret.next()) {
				Integer id = ret.getInt(1);
				String name = ret.getString(2);
				String descrip = ret.getString(3);
				//Integer cnt = ret.getInt(4);
				Integer cnt = 0;
				categories.add(new CategorySetup(id, name, descrip, cnt));
			}
			return categories;
		}
		catch (Exception e) {
			System.err.println("SQL select Error");
			System.err.println(e.getMessage());
			return new ArrayList<CategorySetup>();
		}
		finally {
			try {
				ret.close();
				pstmt.close();
				connect.close();
			}
			catch (SQLException e) {
				e.printStackTrace();
			}
		}
	}
	
	public static boolean canDelete(int id) {
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			
			conn = Usage.connection();
			pstmt = conn.prepareStatement("SELECT COUNT(*) as count " +
					"FROM products " + "WHERE proCatID = ?;" );
            pstmt.setInt(1, id);
            ResultSet rs= pstmt.executeQuery();
			if(rs.next()) {
				if(rs.getInt("count")==0) {
					return true;
				}
			}
		} catch (Exception e) {
            System.err.println("can Delete error" + e.getMessage());
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
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) { } // Ignore
                conn = null;
            }
        }
		return false;
	}
	
	
	public static String update(int id, String name, String descript) {
		if(name.isEmpty() || descript.isEmpty()) {
			return "update fails";
		}
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			
			conn = Usage.connection();
			conn.setAutoCommit(false);
			pstmt = conn.prepareStatement("UPDATE categories SET catName =?, catDescript=?"
                            + "WHERE catID = ?;");
			
            pstmt.setString(1, name);
            pstmt.setString(2, descript);
            pstmt.setInt(3, id);
            int rowCount = pstmt.executeUpdate();
			conn.commit();
            conn.setAutoCommit(true);
		} catch (Exception e) {
            System.err.println("update error" + e.getMessage());
            return "update fails";
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
		return "update successfully";
	}
	
	public static String delete(int id) {
		if(!canDelete(id)) {
			return "Delete fails";
		}
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			
			conn = Usage.connection();
			conn.setAutoCommit(false);
			pstmt = conn.prepareStatement("DELETE FROM categories WHERE catID = ?;");
			pstmt.setInt(1, id);
			int rowCount = pstmt.executeUpdate();
			conn.commit();
            conn.setAutoCommit(true);
		} catch (Exception e) {
			System.err.println("Delete error" + e.getMessage());
            return "Delete fails";
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
	
	public static String insert(String name, String descript) {
		if(name.isEmpty() || descript.isEmpty()) {
			return "Insert fails";
		}
		Connection conn = null;
		PreparedStatement pstmt = null;
		try {
			
			conn = Usage.connection();
			conn.setAutoCommit(false);
			pstmt = conn.prepareStatement("INSERT INTO categories (catName, catDescript)"
					+ "VALUES (?, ?);");
			pstmt.setString(1, name);
            pstmt.setString(2, descript);
            int rowCount = pstmt.executeUpdate();
			conn.commit();
            conn.setAutoCommit(true);
		} catch (Exception e) {
            System.err.println("insert error " + e.getMessage());
            return "insert fails";
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
		return "Insert successfully";
	}
}
		
		
			
			
			
			