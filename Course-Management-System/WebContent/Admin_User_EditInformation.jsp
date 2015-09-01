<%@ page contentType="text/html; charset=utf-8" language="java"
	import="java.sql.*" errorPage=""%>

<%@page import="java.io.InputStream"%>
<%@page import="java.util.Properties"%>

<%
	String userID = request.getParameter("userID");
	String selectusertype = request.getParameter("selectusertype");

	//System.out.println(userID);
	//System.out.println(selectusertype);

	InputStream stream = application
			.getResourceAsStream("/fileUpload/db.properties");
	Properties props = new Properties();
	props.load(stream);

	String readurl = props.getProperty("url");
	String readdriver = props.getProperty("driver");
	String readuser = props.getProperty("user");
	String readpass = props.getProperty("password");

	Statement stmt;
	Connection con;
	String url = readurl;

	try {
		Class.forName(readdriver);
		con = DriverManager.getConnection(url, readuser, readpass);
		stmt = con.createStatement();
		String QueryString = "Update user Set usertype='"
				+ selectusertype + "' where userID = '" + userID + "'";
		stmt.executeUpdate(QueryString);
		System.out.println("Update Success.");
	} catch (ClassNotFoundException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}

	response.sendRedirect("Admin_User.jsp");
	/*request.getRequestDispatcher("/Admin_CoursePlan.jsp?year="+year+"&term="+term).forward(
	 request, response);*/
%>