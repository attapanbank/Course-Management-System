<%@ page contentType="text/html; charset=utf-8" language="java"
	import="java.sql.*" errorPage=""%>

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