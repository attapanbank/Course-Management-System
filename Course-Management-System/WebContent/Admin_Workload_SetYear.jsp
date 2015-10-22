<%
	String year = request.getParameter("workloadyear");
	String term = request.getParameter("workloadterm");

	//System.out.println(year);
	//System.out.println(term);

	session.setAttribute("WorkloadYear", year);
	session.setAttribute("WorkloadTerm", term);

	request.getRequestDispatcher("/Admin_Candidate.jsp").forward(
			request, response);
%>