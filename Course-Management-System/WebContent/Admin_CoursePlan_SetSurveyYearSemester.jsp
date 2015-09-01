<%@ page contentType="text/html; charset=utf-8" language="java"
	import="java.sql.*" errorPage=""%>

<%
	String year = request.getParameter("courseplansurveyyear");
	String term = request.getParameter("courseplansurveyterm");

	//System.out.println(year);
	//System.out.println(term);
	
	session.setAttribute("CoursePlanSurveyYear", year);
	session.setAttribute("CoursePlanSurveyTerm", term);
	
	response.sendRedirect("Admin_CoursePlan.jsp");
	/* request.getRequestDispatcher("/Admin_CoursePlan.jsp").forward(
			request, response); */
%>