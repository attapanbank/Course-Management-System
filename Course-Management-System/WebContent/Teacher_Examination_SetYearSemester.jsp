<%
	String year = request.getParameter("examinationyear");
	String term = request.getParameter("examinationterm");

	//System.out.println(year);
	//System.out.println(term);

	session.setAttribute("ExaminationYear", year);
	session.setAttribute("ExaminationTerm", term);

	request.getRequestDispatcher("/Teacher_Exam.jsp").forward(
			request, response);
%>