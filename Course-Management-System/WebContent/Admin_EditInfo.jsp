<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="java.sql.Statement"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.util.Calendar"%>
<%
	// Validate USER
	String sUserID = null;
	String sUserType = null;
	String sFirstname = null;
	String sLastname = null;
	String sUserName = null;
	String sPassword = null;
	String sMajor = null;

	sUserID = (String) session.getAttribute("sUserID");
	sUserType = (String) session.getAttribute("sUserType");
	sFirstname = (String) session.getAttribute("sFirstname");
	sLastname = (String) session.getAttribute("sLastname");
	sUserName = (String) session.getAttribute("sUserName");
	sPassword = (String) session.getAttribute("sPassword");
	sMajor = (String) session.getAttribute("sMajor");

	if (sUserID == null) {
		response.sendRedirect("Main_Login.jsp");
	}
%>
<%
	// Prepare for connect DB
%>
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

	Statement stmt = null;
	Connection connect = null;
	String url = readurl;

	Class.forName(readdriver);
	connect = DriverManager.getConnection(url, readuser, readpass);
%>
<%
	// End Prepare for connect DB
%>
<%
	String firstname = request.getParameter("firstname");
	String lastname = request.getParameter("lastname");
	String major = request.getParameter("major");
	String username = request.getParameter("username");
	String newPass = request.getParameter("newPass");
	String userID = request.getParameter("userID");
	int intuserID = (int)Integer.parseInt(userID);
	
%>
<%

	try {
		Class.forName("com.mysql.jdbc.Driver");
		stmt = connect.createStatement();

		String sql = "UPDATE `user` SET `password` = '"+newPass+"', `firstname` = '"+firstname+"', `lastname` = '"+lastname+"', `major` = '"+major+"' WHERE `userID` = "+intuserID+";";
		stmt.execute(sql);
		System.out.println("Update Compleate.");
		
		String redirectURL = "Main_Logout.jsp";
		response.sendRedirect(redirectURL);
	} catch (Exception e) {
		// TODO Auto-generated catch block
		out.println(e.getMessage());
		e.printStackTrace();
	}

	try {
		if (stmt != null) {
			stmt.close();
			connect.close();
		}
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		out.println(e.getMessage());
		e.printStackTrace();
	}
%>