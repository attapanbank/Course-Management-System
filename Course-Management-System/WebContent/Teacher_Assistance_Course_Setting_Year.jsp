<%
	String year = request.getParameter("teachercourseyear");
	String term = request.getParameter("teachercourseterm");

	//System.out.println(year);
	//System.out.println(term);

	session.setAttribute("TeacherCourseYear", year);
	session.setAttribute("TeacherCourseTerm", term);

	request.getRequestDispatcher("/Teacher_Assistance_Course.jsp").forward(
			request, response);
%>