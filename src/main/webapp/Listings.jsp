<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%-- <%@ page import="java.io.*,java.util.*,java.sql.*" 
import="com.cs336.pkg.*"
%> --%>
<%@ page import="java.io.*,java.util.*,java.sql.*,java.math.BigDecimal, com.cs336.pkg.*" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Listings</title>
</head>
<body>
	 <div style="text-align: center">
        <h1>Listings</h1>
        
        <h2>Create a Listing!</h2>
        <table align="center">
            <tr>
                <td><a href="createListings.jsp">Go to create...</a></td>
            </tr>
        </table>
        
         <h2>Your Listings</h2>
        <table align="center" border="1">
            <tr>
                <th>Make</th>
                <th>Model</th>
                <th>Color</th>
                <th>Year</th>
                <th>Initial Price</th>
                <th>Min Sale Price</th>
                <th>Closing Date/Time</th>
            </tr>
            <%
                Connection con = null;
                PreparedStatement ps = null;
                ResultSet rs = null;
                try {
                    ApplicationDB db = new ApplicationDB();
                    con = db.getConnection();
                    String query = "SELECT make, model, color, year, initial_price, min_sale, date_time FROM listings";
                    ps = con.prepareStatement(query);
                    rs = ps.executeQuery();
                    while (rs.next()) {
                        BigDecimal initialPrice = rs.getBigDecimal("initial_price");
                        BigDecimal minSale = rs.getBigDecimal("min_sale");
            %>
                        <tr>
                            <td><%= rs.getString("make") %></td>
                            <td><%= rs.getString("model") %></td>
                            <td><%= rs.getString("color") %></td>
                            <td><%= rs.getInt("year") %></td>
                            <td><%= initialPrice != null ? initialPrice.toPlainString() : "N/A" %></td>
                            <td><%= minSale != null ? minSale.toPlainString() : "N/A" %></td>
                            <td><%= rs.getTimestamp("date_time") != null ? rs.getTimestamp("date_time").toString() : "N/A" %></td>
                        </tr>
                        <%
                    }
                } catch (SQLException e) {
                    out.println("Error retrieving listings: " + e.getMessage());
                } finally {
                    try { if (rs != null) rs.close(); } catch (Exception e) {}
                    try { if (ps != null) ps.close(); } catch (Exception e) {}
                    try { if (con != null) con.close(); } catch (Exception e) {}
                }
            %>
        </table>
    </div>
</body>
</html>
