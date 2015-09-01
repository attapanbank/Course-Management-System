<%@ page contentType="text/html; charset=utf-8" language="java"
	import="java.sql.*" errorPage=""%>

<%@page import="java.io.InputStream"%>
<%@page import="java.util.Properties"%>

<%
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

	Class.forName(readdriver);
	con = DriverManager.getConnection(url, readuser, readpass);

	String userID = request.getParameter("userid");

	System.out.println(userID);

	stmt = con.createStatement();
	String QueryString = "Delete from user where userID = '" + userID
			+ "'";

	stmt.executeUpdate(QueryString);

	request.getRequestDispatcher("/Admin_User.jsp").forward(request,
			response);
%>