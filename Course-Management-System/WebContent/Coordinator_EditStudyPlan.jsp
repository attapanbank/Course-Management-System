<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="java.sql.Statement"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.util.Calendar"%>
<%
	String studyplanId = request.getParameter("studyplanId");
	String year = request.getParameter("year");
	String semester = request.getParameter("semester");
	String courseCode = request.getParameter("courseCode");
%>
<%
	Connection connect = null;
	Statement s = null;

	try {
		Class.forName("com.mysql.jdbc.Driver");

		connect = DriverManager
				.getConnection("jdbc:mysql://localhost:3306/CMS"
						+ "?user=root&password=toor");

		s = connect.createStatement();

		String sql = "UPDATE test.studyplan SET year='"+year+"',semester='"+semester+"',courseCode='"+courseCode+"' WHERE studyPlanID='"+studyplanId+"';";
		s.execute(sql);
		
		out.println("OK");
%>
<%
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