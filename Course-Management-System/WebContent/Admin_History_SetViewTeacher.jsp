<%@ page contentType="text/html; charset=utf-8" language="java"
	import="java.sql.*" errorPage=""%>

<%
	String teachertype = request.getParameter("teachertype");

	if (teachertype.equalsIgnoreCase("queryall")) {
		request.setAttribute("GetTeacherMajor",
				"SELECT * FROM user ORDER BY usertype");
	} else if (teachertype.equalsIgnoreCase("queryit")) {
		request.setAttribute("GetTeacherMajor",
				"SELECT * FROM user WHERE major = 'Information Technology'");
	} else if (teachertype.equalsIgnoreCase("querycs")) {
		request.setAttribute("GetTeacherMajor",
				"SELECT * FROM user WHERE major = 'Computer Science'");
	} else if (teachertype.equalsIgnoreCase("queryse")) {
		request.setAttribute("GetTeacherMajor",
				"SELECT * FROM user WHERE major = 'Software Engineering'");
	} else if (teachertype.equalsIgnoreCase("querymta")) {
		request.setAttribute("GetTeacherMajor",
				"SELECT * FROM user WHERE major = 'Multimedia Technology and Animation'");
	} else if (teachertype.equalsIgnoreCase("queryce")) {
		request.setAttribute("GetTeacherMajor",
				"SELECT * FROM user WHERE major = 'Computer Engineering'");
	} else if (teachertype.equalsIgnoreCase("queryice")) {
		request.setAttribute("GetTeacherMajor",
				"SELECT * FROM user WHERE major = 'Information and Communication Engineering'");
	}

	// response.sendRedirect("Admin_User.jsp");
	request.getRequestDispatcher("/Admin_History.jsp").forward(request,
			response);
%>