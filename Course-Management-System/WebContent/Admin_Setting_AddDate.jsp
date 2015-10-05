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
	String dateterm1_1 = request.getParameter("dateterm1_1");
	String dateterm1_2 = request.getParameter("dateterm1_2");
	String dateterm2_1 = request.getParameter("dateterm2_1");
	String dateterm2_2 = request.getParameter("dateterm2_2");

	/* System.out.println(dateterm1_1);
	System.out.println(dateterm1_2);
	System.out.println(dateterm2_1);
	System.out.println(dateterm2_2); */

	String[] term1_1 = dateterm1_1.split("-", 3);
	String yterm1_1 = term1_1[0];
	String mterm1_1 = term1_1[1];
	String dterm1_1 = term1_1[2];

	String[] term1_2 = dateterm1_2.split("-", 3);
	String yterm1_2 = term1_2[0];
	String mterm1_2 = term1_2[1];
	String dterm1_2 = term1_2[2];

	String[] term2_1 = dateterm2_1.split("-", 3);
	String yterm2_1 = term2_1[0];
	String mterm2_1 = term2_1[1];
	String dterm2_1 = term2_1[2];

	String[] term2_2 = dateterm2_2.split("-", 3);
	String yterm2_2 = term2_2[0];
	String mterm2_2 = term2_2[1];
	String dterm2_2 = term2_2[2];

	/* System.out.println(yterm2_1);
	System.out.println(mterm2_1);
	System.out.println(dterm2_1); */

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
		String QueryString = "SELECT dateterm1_1 FROM setsemesterdate WHERE setsemesterdate_ID = '1'";
		ResultSet rs = stmt.executeQuery(QueryString);
		//System.out.println("Select Success.");
		if (rs.next()) {
			String QueryUpdate = "UPDATE setsemesterdate SET dateterm1_1 ='"
					+ dateterm1_1
					+ "', dateterm1_2 = '"
					+ dateterm1_2
					+ "', dateterm2_1 = '"
					+ dateterm2_1
					+ "', dateterm2_2 = '" + dateterm2_2 + "'";
			stmt.executeUpdate(QueryUpdate);
			//System.out.println("Update Success.");
		} else {
			String QueryInsert = "INSERT INTO setsemesterdate (setsemesterdate_ID, dateterm1_1, dateterm1_2, dateterm2_1, dateterm2_2) VALUES('"
					+ 1
					+ "','"
					+ dateterm1_1
					+ "','"
					+ dateterm1_2
					+ "','" + dateterm2_1 + "','" + dateterm2_2 + "')";
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

	response.sendRedirect("Admin_Setting.jsp");
	/*request.getRequestDispatcher(
	 "/Admin_Setting.jsp)
	 .forward(request, response);*/
%>

