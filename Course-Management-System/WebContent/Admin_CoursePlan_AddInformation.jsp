<%@ page contentType="text/html; charset=utf-8" language="java"
	import="java.sql.*" errorPage=""%>

<%@page import="java.io.InputStream"%>
<%@page import="java.util.Properties"%>

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
	String year = request.getParameter("year");
	String term = request.getParameter("term");
	String major = request.getParameter("major");
	String numberofstudent = request.getParameter("numberofstudent");
	String selectcourse = request.getParameter("selectcourse");

	//we use this part to split the course code and course name in the same string
	String[] parts = selectcourse.split("\\s+", 2);

	String coursecode = parts[0];
	String coursename = parts[1];

	System.out.println(year);
	System.out.println(term);
	System.out.println(major);
	System.out.println(numberofstudent);
	System.out.println(coursecode);
	System.out.println(coursename);
	
	InputStream stream = application
	.getResourceAsStream("/fileUpload/db.properties");
	Properties props = new Properties();
	props.load(stream);
	
	String readurl = props.getProperty("url");
	String readdriver = props.getProperty("driver");
	String readuser = props.getProperty("user");
	String readpass = props.getProperty("password");

	Statement stmt;
	Connection con;
	String url = readurl;

	try {
		Class.forName(readdriver);
		con = DriverManager.getConnection(url, readuser, readpass);
		stmt = con.createStatement();
		String QueryString = "INSERT INTO courseplan (year, semester, courseCode, major, numberofstudent) values ('"
		+ year
		+ "','"
		+ term
		+ "','"
		+ coursecode
		+ "','"
		+ major + "','" + numberofstudent + "')";
		stmt.executeUpdate(QueryString);
		System.out.println("Insert Success.");
	} catch (ClassNotFoundException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}

	response.sendRedirect("Admin_CoursePlan.jsp");
	/*request.getRequestDispatcher(
	 "/Admin_CoursePlan.jsp?year=" + year + "&term=" + term)
	 .forward(request, response);*/
%>