<%@ page import="java.io.*,java.util.*,java.sql.*" 
import="com.cs336.pkg.*"
%>
<%
	//Database connection
	ApplicationDB db = new ApplicationDB();
	Connection con = db.getConnection();
	
	//Create the sql statement 
	
	Statement stmt = con.createStatement();
	
	String userid = request.getParameter("username");
	
	String pwd = request.getParameter("password");
	
	ResultSet rs = stmt.executeQuery("select * from users where username='" + userid + "' and password='" + pwd + "'");
	
	if (rs.next()) {
		session.setAttribute("user", userid); // the username will be stored in the session
		out.println("welcome " + userid);
		out.println("<a href='logout.jsp'>Log out</a>");
		response.sendRedirect("CustomerRepHome.jsp");
	} else {
		out.println("Invalid password <a href='CustomerRepLogin.jsp'>try again</a>");
	}
	
	stmt.close();
	rs.close();
	con.close();
%>  