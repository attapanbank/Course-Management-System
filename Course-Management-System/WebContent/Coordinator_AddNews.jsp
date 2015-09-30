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
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>

<body>
	<%
		try {
			Class.forName("com.mysql.jdbc.Driver");

			stmt = connect.createStatement();

			String sql = "select * from studyplan inner join course on (studyplan.courseCode=course.courseCode)where studyplan.courseCode not in (select courseplan.courseCode from courseplan)union all select * from courseplan inner join course on (courseplan.courseCode=course.courseCode)where coursePlan.courseCode not in (select studyplan.courseCode from studyplan)";
			ResultSet rec = stmt.executeQuery(sql);

			String newsDetail = null;
			if (rec != null) {
				while ((rec != null) && (rec.next())) {
					stmt = connect.createStatement();
					sql = "INSERT INTO `news` (`user`, `group`, `courseCode`, `courseName`, `major`) VALUES ('admin', 'admin', '"
							+ rec.getString("courseCode")+"', '"+rec.getString("courseName")+"', '"+rec.getString("major")+"');";
					stmt.execute(sql);
					stmt.close();
				}
			} else {
				newsDetail = "All course matching.";
			}

			System.out.println("Update Complete.");
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
				connect.close();
			}
		} catch (SQLException e) {
			// TODO Auto-generated catch block
			out.println(e.getMessage());
			e.printStackTrace();
		}
	%>
</body>
</html>