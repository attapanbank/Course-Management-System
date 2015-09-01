<%@ page contentType="text/html; charset=utf-8" language="java"
	import="java.sql.*" errorPage=""%>

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