
<%
	String year = request.getParameter("notcandidateyear");
	String term = request.getParameter("notcandidateterm");

	//System.out.println(year);
	//System.out.println(term);

	session.setAttribute("NotCandidateYear", year);
	session.setAttribute("NotCandidateTerm", term);

	request.getRequestDispatcher("/Admin_Candidate.jsp").forward(
			request, response);
%>