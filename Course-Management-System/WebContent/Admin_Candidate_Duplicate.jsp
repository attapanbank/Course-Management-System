<%@ page contentType="text/html; charset=utf-8" language="java"
	import="java.sql.*" errorPage=""%>

<%@page import="java.io.InputStream"%>
<%@page import="java.util.Properties"%>

<%
	String courseplanid[] = request.getParameterValues("surveyid");

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

	for (String s : courseplanid) {
		try {
			Class.forName(readdriver);
			con = DriverManager.getConnection(url, readuser, readpass);
			stmt = con.createStatement();
			String QueryString = "INSERT INTO notcandidate (year, semester, courseCode, major, numberofstudent) SELECT year, semester, courseCode, major, numberofstudent FROM courseplan WHERE courseplanID = '"
					+ s + "'";
			stmt.executeUpdate(QueryString);
		} catch (ClassNotFoundException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}

	response.sendRedirect("Admin_Candidate.jsp");
%>