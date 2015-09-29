<%@page language="java" session="true" %>
<%
	String academicYear = request.getParameter("academicyear");
	String major = request.getParameter("major");
	
	session.setAttribute("academicyear", academicYear);
	session.setAttribute("major", major);
	
	System.out.println("Set Session complete");

	session.setAttribute("stateupload", "ready");
	
	String stateupload = "empty";
	stateupload = (String)session.getAttribute("stateupload");
	System.out.println(stateupload+academicYear+major);
	request.getRequestDispatcher("/Coordinator_StudyPlan.jsp").forward(
			request, response);
%>