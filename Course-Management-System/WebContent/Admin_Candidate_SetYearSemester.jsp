<%
	// Validate USER
	String sUserID = null;
	String sUserType = null;
	String sFirstname = null;
	String sLastname = null;
	String sUserName = null;
	String sPassword = null;
	String sMajor = null;
	sUserID = (String) session.getAttribute("sUserID");
	sUserType = (String) session.getAttribute("sUserType");
	sFirstname = (String) session.getAttribute("sFirstname");
	sLastname = (String) session.getAttribute("sLastname");
	sUserName = (String) session.getAttribute("sUserName");
	sPassword = (String) session.getAttribute("sPassword");
	sMajor = (String) session.getAttribute("sMajor");
	if (sUserID == null) {
		response.sendRedirect("Main_Login.jsp");
	}
%>

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