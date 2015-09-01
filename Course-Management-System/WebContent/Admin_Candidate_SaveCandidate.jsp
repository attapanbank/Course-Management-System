
<%
	String coursecode[] = request.getParameterValues("coursecode");
	String coursecode2[] = request.getParameterValues("coursecode2");
	String deletefake[] = request.getParameterValues("deletetest");

	String year = request.getParameter("checkyear");
	String term = request.getParameter("checkterm");

	System.out.println(year);
	System.out.println(term);
	
	if(deletefake !=null){
		int fake = 0;
		for (String s : deletefake) {
			fake++;
		}
		String strdelete[] = new String[fake];
		int fake2 = 0;
		for (String s : deletefake) {
			strdelete[fake2] = s;
			System.out.println("delete "+strdelete[fake2]);
			fake2++;
		}
		
	}
	
	// In courseplan
	int length = 0;
	for (String s : coursecode) {
		length++;
	}

	String strcoursecode[] = new String[length];

	int count = 0;
	for (String s : coursecode) {
		strcoursecode[count] = s;
		count++;
	}

	for (int i = 0; i < strcoursecode.length; i++) {
		System.out.println(strcoursecode[i]);
	}
	// End In courseplan

	// In Duplicate
	if (coursecode2 != null) {
		int length2 = 0;
		for (String s : coursecode2) {
			length2++;
		}

		String strcoursecode2[] = new String[length2];

		int count2 = 0;
		for (String s : coursecode2) {
			strcoursecode2[count2] = s;
			count2++;
		}

		for (int i = 0; i < strcoursecode2.length; i++) {
			System.out.println("Duplicate " + strcoursecode2[i]);
		}
	}
	//End In Duplicate
	
	response.sendRedirect("Admin_Candidate.jsp");
%>