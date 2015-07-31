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

<body>
	<%
		Connection connect = null;
		Statement s = null;

		try {
			Class.forName("com.mysql.jdbc.Driver");

			connect = DriverManager
					.getConnection("jdbc:mysql://localhost:3306/CMS"
							+ "?user=root&password=toor");

			s = connect.createStatement();

			String sql = "select * from test.studyplan inner join test.course on (test.studyplan.courseCode=test.course.courseCode)where test.studyplan.courseCode not in (select test.courseplan.courseCode from test.courseplan)union all select * from test.courseplan inner join test.course on (test.courseplan.courseCode=test.course.courseCode)where test.coursePlan.courseCode not in (select test.studyplan.courseCode from test.studyplan)";
			ResultSet rec = s.executeQuery(sql);

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
			s.execute(sql);
			String redirectURL = "Coordinator.jsp";
			response.sendRedirect(redirectURL);
			//out.println(newsDetail);
		} catch (Exception e) {
			// TODO Auto-generated catch block
			out.println(e.getMessage());
			e.printStackTrace();
		}

		try {
			if (s != null) {
				s.close();
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