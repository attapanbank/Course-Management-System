<%@ page contentType="text/html; charset=utf-8" language="java"
	import="java.sql.*" errorPage=""%>

<%
	String coursetype = request.getParameter("querycourse");

	if (coursetype.equalsIgnoreCase("queryall")) {
		request.setAttribute("GetCourseMajor",
				"SELECT * FROM course ORDER BY courseCode");
	} else if (coursetype.equalsIgnoreCase("queryit")) {
		request.setAttribute("GetCourseMajor",
				"SELECT * FROM course WHERE courseCode LIKE '1301%' ORDER BY courseCode");
	} else if (coursetype.equalsIgnoreCase("querycs")) {
		request.setAttribute("GetCourseMajor",
				"SELECT * FROM course WHERE courseCode LIKE '1302%' ORDER BY courseCode");
	} else if (coursetype.equalsIgnoreCase("queryse")) {
		request.setAttribute("GetCourseMajor",
				"SELECT * FROM course WHERE courseCode LIKE '1305%' ORDER BY courseCode");
	} else if (coursetype.equalsIgnoreCase("querymta")) {
		request.setAttribute("GetCourseMajor",
				"SELECT * FROM course WHERE courseCode LIKE '1306%' ORDER BY courseCode");
	} else if (coursetype.equalsIgnoreCase("queryce")) {
		request.setAttribute("GetCourseMajor",
				"SELECT * FROM course WHERE courseCode LIKE '1501%' ORDER BY courseCode");
	} else if (coursetype.equalsIgnoreCase("queryice")) {
		request.setAttribute("GetCourseMajor",
				"SELECT * FROM course WHERE courseCode LIKE '1502%' ORDER BY courseCode");
	}

	// response.sendRedirect("Admin_User.jsp");
	request.getRequestDispatcher("/Admin_History.jsp").forward(request,
			response);
%>