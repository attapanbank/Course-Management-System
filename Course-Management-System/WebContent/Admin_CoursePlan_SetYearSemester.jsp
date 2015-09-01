
<%
	String year = request.getParameter("courseplanyear");
	String term = request.getParameter("courseplanterm");

	//System.out.println(year);
	//System.out.println(term);

	session.setAttribute("CoursePlanYear", year);
	session.setAttribute("CoursePlanTerm", term);

	request.getRequestDispatcher("/Admin_CoursePlan.jsp").forward(
			request, response);
%>