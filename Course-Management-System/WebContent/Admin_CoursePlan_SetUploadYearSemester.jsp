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
	String year = request.getParameter("uploadcourseplanyear");
	String term = request.getParameter("uploadcourseplanterm");

	//System.out.println(year);
	//System.out.println(term);

	session.setAttribute("UploadCoursePlanYear", year);
	session.setAttribute("UploadCoursePlanTerm", term);

	response.sendRedirect("Admin_CoursePlan.jsp");
	/* request.getRequestDispatcher("/Admin_CoursePlan.jsp").forward(
			request, response); */
%>