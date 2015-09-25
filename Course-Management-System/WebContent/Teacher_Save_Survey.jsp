<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="java.sql.*"%>
	<%@page import="java.io.InputStream"%>
<%@page import="java.util.Properties"%>

<%
	
try{
	Statement stmt;
	Connection con;
	InputStream stream = application
			.getResourceAsStream("/fileUpload/db.properties");
			Properties props = new Properties();
			props.load(stream);
	String url = props.getProperty("driver");
	String dbUrl = props.getProperty("url");
	String dbUser = props.getProperty("user");
	String dbPassword = props.getProperty("password");
	con = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
	stmt = con.createStatement();

	Object strUserID = session.getAttribute("sUserID");
	String year = String.valueOf(session.getAttribute("sYear"));
	String semester = String.valueOf(session.getAttribute("sSemester"));

	String sFirstname = String.valueOf(session
			.getAttribute("sFirstname"));
	String cos = request.getParameter("courseSelect");
	String cosCode = null;
	String cosCredit = null;
	String cosCodeHave = null;
	
	// Select course form table course
	String QueryString_selectCourse = "SELECT * FROM cms.course WHERE courseName = '"
			+ cos + "';";

	ResultSet rsSelectCourse = stmt
			.executeQuery(QueryString_selectCourse);

	
	// find Couse code and credit in table course
	if (cos != null) {
		while (rsSelectCourse.next()) {

			cosCode = rsSelectCourse.getString("courseCode");
			cosCredit = rsSelectCourse.getString("Credit");
		}
	}

	
	
	// check data same and sava
	
	String queryString = "SELECT * FROM cms.course_survey WHERE courseCode ='"+cosCode+"' AND userID = '"+ strUserID+"' ";
	ResultSet rs = stmt.executeQuery(queryString);
	while (rs.next()) {

		cosCodeHave = rs.getString("courseCode");
		out.print(cosCodeHave);
		
	}

		if (cosCode.equals(cosCodeHave)) {
			String QueryString = "UPDATE course_survey SET(userID,courseName,courseCode,year,semester) VALUES('"
					+ strUserID
					+ "','"
					+ cos
					+ "','"
					+ cosCode
					+ "','"
					+ year
					+ "','" + semester + "') ";
			
		}else{
			
			String QueryString = "INSERT INTO course_survey(userID,courseName,courseCode,year,semester) VALUES('"
					+ strUserID
					+ "','"
					+ cos
					+ "','"
					+ cosCode
					+ "','"
					+ year
					+ "','" + semester + "') ";

			stmt.executeUpdate(QueryString);
		}
	

	
	

	out.print("<META HTTP-EQUIV=\"Refresh\" CONTENT=\"0;URL=Teacher_Course.jsp\">");
}catch (Exception e) {
	out.println(e);
	
}
%>
