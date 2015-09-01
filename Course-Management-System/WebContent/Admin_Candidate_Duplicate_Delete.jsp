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
	
	String notcandidateid = request.getParameter("deleteid");
	
	stmt = con.createStatement();
	String QueryString = "Delete from notcandidate where notcandidate_ID = '"
			+ notcandidateid + "'";
	
	stmt.executeUpdate(QueryString);

	response.sendRedirect("Admin_Candidate.jsp");
	
%>