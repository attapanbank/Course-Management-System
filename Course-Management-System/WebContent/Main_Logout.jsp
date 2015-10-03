
<%
	session.setAttribute("sUserID", null);
	session.setAttribute("sFirstname", null);
	session.setAttribute("sLastname", null);
	session.setAttribute("sUserType", null);
	session.setAttribute("sMajor", null);
	session.setAttribute("sUserName", null);
	session.setAttribute("sPassword", null);
	response.sendRedirect("Main_Login.jsp");
%>