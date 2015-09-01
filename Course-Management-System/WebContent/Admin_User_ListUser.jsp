
<%
	String querytype = request.getParameter("querytype");

	//System.out.println(querytype);

	if (querytype.equalsIgnoreCase("queryall")) {
		request.setAttribute("GetQuery",
				"SELECT * FROM user ORDER BY usertype");
	} else if (querytype.equalsIgnoreCase("queryadmin")) {
		request.setAttribute("GetQuery",
				"SELECT * FROM user WHERE usertype = 'Admin' ORDER BY usertype");
	} else if (querytype.equalsIgnoreCase("queryteacher")) {
		request.setAttribute("GetQuery",
				"SELECT * FROM user WHERE usertype = 'Teacher' ORDER BY usertype");
	} else if (querytype.equalsIgnoreCase("queryta")) {
		request.setAttribute("GetQuery",
				"SELECT * FROM user WHERE usertype = 'Teaching Assistance' ORDER BY usertype");
	} else if (querytype.equalsIgnoreCase("querymajorco")) {
		request.setAttribute("GetQuery",
				"SELECT * FROM user WHERE usertype = 'Major Coordinator' ORDER BY usertype");
	}

	// response.sendRedirect("Admin_User.jsp");
	request.getRequestDispatcher("/Admin_User.jsp").forward(request,
			response);
%>