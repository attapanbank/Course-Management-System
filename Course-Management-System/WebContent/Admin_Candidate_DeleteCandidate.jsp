<%@ page contentType="text/html; charset=utf-8" language="java"
	import="java.sql.*" errorPage=""%>

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

<!-- // จำเป็นต้องปลด safe update in mysql workbench ก่อน โดย SET SQL_SAFE_UPDATES = 0;
http://stackoverflow.com/questions/11448068/mysql-error-code-1175-during-update-in-mysql-workbench
http://www.mkyong.com/mysql/cant-delete-records-in-mysql-workbench/ -->

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

	String deletesectionid = request.getParameter("del");

	stmt = con.createStatement();
	String QueryString = "Delete from section where sectionID = '"
			+ deletesectionid + "'";
	stmt.executeUpdate(QueryString);
	String QueryString2 = "Delete from candidate where sectionID = '"
			+ deletesectionid + "'";
	stmt.executeUpdate(QueryString2);

	response.sendRedirect("Admin_Candidate.jsp");
%>