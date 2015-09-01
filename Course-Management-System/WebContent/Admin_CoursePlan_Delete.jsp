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

	String coursePlanID = request.getParameter("coursePlanID");
	String year = request.getParameter("year");
	String term = request.getParameter("term");

	/* 	System.out.println(coursePlanID);
	 System.out.println(year);
	 System.out.println(term); */

	stmt = con.createStatement();
	String QueryString = "Delete from courseplan where coursePlanID = '"
			+ coursePlanID + "'";

	stmt.executeUpdate(QueryString);

	response.sendRedirect("Admin_CoursePlan.jsp");
	/* request.getRequestDispatcher("/Admin_CoursePlan.jsp?year="+year+"&term="+term).forward(
			request, response); */
%>