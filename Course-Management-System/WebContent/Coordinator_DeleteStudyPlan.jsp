<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="java.sql.Statement"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.util.Calendar"%>
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
	String studyplanId = request.getParameter("studyplanId");
	String academicYear = request.getParameter("acayear");
	int intacademicYear = (int) Integer.parseInt(academicYear);
	String major = request.getParameter("major");
%>
<%
	try {
		Class.forName("com.mysql.jdbc.Driver");

		stmt = connect.createStatement();

		String sql = "DELETE FROM `studyplan` WHERE `studyPlanID`='"
				+ studyplanId + "';";
		stmt.execute(sql);

		String redirectURL = "Coordinator_ListStudyPlan.jsp?year="
				+ academicYear + "&major=" + major;
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