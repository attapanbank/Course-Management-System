<%@ page contentType="text/html; charset=utf-8" language="java"
	import="java.sql.*" errorPage=""%>

<%
	String year = request.getParameter("examsurveyyear");
	String term = request.getParameter("examsurveyterm");

	//System.out.println(year);
	//System.out.println(term);
	
	session.setAttribute("ExamSurveyYear", year);
	session.setAttribute("ExamSurveyTerm", term);
	
	request.getRequestDispatcher("/Admin_Examination.jsp").forward(
			request, response);
%>