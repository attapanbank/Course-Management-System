<%
	String year = request.getParameter("Ateachercourseyear");
	String term = request.getParameter("Ateachercourseterm");

	//System.out.println(year);
	//System.out.println(term);

	session.setAttribute("ATeacherCourseYear", year);
	session.setAttribute("ATeacherCourseTerm", term);

	request.getRequestDispatcher("/Teacher_Course.jsp").forward(
			request, response);
%>