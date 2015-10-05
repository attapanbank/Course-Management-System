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
	String checkbox = request.getParameter("checkboxsurvey");
	String surveyyear = request.getParameter("surveyyear");
	String surveyterm = request.getParameter("surveyterm");
	String checksurveyID = request.getParameter("checksurveyID");

	//System.out.println(checkbox);
	//System.out.println(surveyyear);
	//System.out.println(surveyterm);
	System.out.println(checksurveyID);

	String checkboxvalue = "";

	// Checkbox from previous page select ON = on, OFF = null
	if (checkbox == null) {
		checkboxvalue = "OFF";
	} else {
		checkboxvalue = "ON";
	}

	//System.out.println(checkboxvalue);

	InputStream stream = application
			.getResourceAsStream("/fileUpload/db.properties");
	Properties props = new Properties();
	props.load(stream);

	String readurl = props.getProperty("url");
	String readdriver = props.getProperty("driver");
	String readuser = props.getProperty("user");
	String readpass = props.getProperty("password");

	//ถ้ามีข้อมูลปีกับเทอมอยู่แล้วให้update ถ้าไม่มีให้insert
	Statement stmt;
	Connection con;
	String url = readurl;

	try {
		Class.forName(readdriver);
		con = DriverManager.getConnection(url, readuser, readpass);
		stmt = con.createStatement();
		String QueryString = "SELECT checksurvey FROM examination_checksurvey WHERE year = "
				+ surveyyear + " AND semester = " + surveyterm;
		ResultSet rs = stmt.executeQuery(QueryString);
		//System.out.println("Select Success.");
		if (rs.next()) {
			String QueryUpdate = "UPDATE examination_checksurvey SET checksurvey = '"
					+ checkboxvalue
					+ "' WHERE examination_checksurveyID = "
					+ checksurveyID;
			stmt.executeUpdate(QueryUpdate);
			//System.out.println("Update Success.");
		} else {
			String QueryInsert = "INSERT INTO examination_checksurvey (year, semester, checksurvey) VALUES('"
					+ surveyyear
					+ "','"
					+ surveyterm
					+ "','"
					+ checkboxvalue + "')";
			stmt.executeUpdate(QueryInsert);
			//System.out.println("Insert Success.");
		}
	} catch (ClassNotFoundException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}

	response.sendRedirect("Admin_Examination.jsp");
%>