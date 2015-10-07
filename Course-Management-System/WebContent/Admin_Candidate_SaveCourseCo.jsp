<%@ page language="java" contentType="text/html; charset=utf-8"
	import="java.sql.*" pageEncoding="utf-8"%>

<%@page import="java.io.InputStream"%>
<%@page import="java.util.Properties"%>

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

	String teacherid = request.getParameter("teacherid");
	String coursecode = request.getParameter("coursecode");
	String year = request.getParameter("year");
	String term = request.getParameter("term");
%>

<%
	String currentcourseid = "";
	stmt = con.createStatement();
	String QuerySelect = "SELECT * FROM currentcourse WHERE courseCode = '"
			+ coursecode
			+ "' AND year = '"
			+ year
			+ "' AND semester = '" + term + "'";
	ResultSet rsselect = stmt.executeQuery(QuerySelect);
	if (rsselect.next()) {
		currentcourseid = rsselect
				.getString("currentcourse.currentcourseID");
	}

	String QueryInsert = "UPDATE currentcourse SET courseco_userID = '"
			+ teacherid + "' WHERE currentcourseID = '"
			+ currentcourseid + "'";
	stmt.executeUpdate(QueryInsert);

	response.sendRedirect("Admin_Candidate_ViewCourseCo.jsp?year="
			+ year + "&term=" + term + "&coursecode=" + coursecode);
%>
