<%@page import="com.mysql.jdbc.PreparedStatement"%>
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
	String fromacademicyear = request.getParameter("fromacademicyear");
	int intfromacademicyear = (int)Integer.parseInt(fromacademicyear);
	String frommajor = request.getParameter("frommajor");
	//int intfrommajor = (int)Integer.parseInt(frommajor);
	String toacademicyear = request.getParameter("toacademicyear");
	int inttoacademicyear = (int)Integer.parseInt(toacademicyear);
	String tomajor = request.getParameter("tomajor");
	//int inttomajor = (int)Integer.parseInt(tomajor);
	
%>
<%

	PreparedStatement pstm =null;
	try {
		Class.forName("com.mysql.jdbc.Driver");
		stmt = connect.createStatement();

		String sql = "SELECT * FROM studyplan inner join course on (studyPlan.courseCode=course.courseCode) Where academicyear like '"+ intfromacademicyear + "' and major like '" + frommajor + "';";
		ResultSet rec = stmt.executeQuery(sql);
		if (rec != null) {
			while ((rec != null) && (rec.next())) {
				stmt = connect.createStatement();
				sql = " INSERT INTO `cmsit`.`studyplan` (`academicYear`,`studyYear`, `studySemester`, `courseCode`, `major`) VALUES ('"
						+ inttoacademicyear
						+ "', '"
						+ rec.getInt("studyYear")
						+ "', '"
						+ rec.getInt("studySemester")
						+ "', '"
						+ rec.getInt("courseCode")
						+ "', '"
						+ tomajor + "'); ";
				pstm = (PreparedStatement) connect.prepareStatement(sql);
				pstm.execute();
				stmt.close();
			}
		}
		System.out.println("Update Compleate.");
		
		String redirectURL = "Coordinator_ListStudyPlan.jsp?year="+toacademicyear+"&major="+tomajor;
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