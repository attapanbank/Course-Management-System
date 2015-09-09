<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="java.sql.Statement"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.util.Calendar"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>

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
	Connection con = null;
	String url = readurl;

	Class.forName(readdriver);
	con = DriverManager.getConnection(url, readuser, readpass);
%>
<%
	// End Prepare for connect DB
%>
<body>
	<%
		try {
			Class.forName("com.mysql.jdbc.Driver");
			stmt = con.createStatement();
			String sql = "select * from test.studyplan inner join test.course on (test.studyplan.courseCode=test.course.courseCode)where test.studyplan.courseCode not in (select test.courseplan.courseCode from test.courseplan)union all select * from test.courseplan inner join test.course on (test.courseplan.courseCode=test.course.courseCode)where test.coursePlan.courseCode not in (select test.studyplan.courseCode from test.studyplan)";
			ResultSet rec = stmt.executeQuery(sql);

			String newsDetail = "The follow Courses is Missmatch:  ";
			if (rec != null) {
				while ((rec != null) && (rec.next())) {
					newsDetail += rec.getString("courseCode") + " ("
							+ rec.getString("courseName") + ") ";
				}
			} else {
				newsDetail = "All course matching.";
			}

			sql = "INSERT INTO `test`.`news` (`user`, `group`, `news`) VALUES ('admin', 'admin', '"
					+ newsDetail + "');";
			stmt.execute(sql);
			String redirectURL = "Coordinator.jsp";
			response.sendRedirect(redirectURL);
			//out.println(newsDetail);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			out.println(e.getMessage());
			e.printStackTrace();
		}

		try {
			if (stmt != null) {
				stmt.close();
				con.close();
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			out.println(e.getMessage());
			e.printStackTrace();
		}
	%>
</body>
</html>