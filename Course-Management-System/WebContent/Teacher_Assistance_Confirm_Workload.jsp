<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="java.sql.*"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.util.Properties"%>
<%
	Object strUserID = session.getAttribute("sUserID");
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

	try {
		Statement stmt;
		Connection con;
		InputStream stream = application
				.getResourceAsStream("/fileUpload/db.properties");
		Properties props = new Properties();
		props.load(stream);
		String url = props.getProperty("driver");
		String dbUrl = props.getProperty("url");
		String dbUser = props.getProperty("user");
		String dbPassword = props.getProperty("password");
		con = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
		

		String userID = request.getParameter("userID");
		String year = request.getParameter("year");
		String term = request.getParameter("term");
		String status = request.getParameter("status");
		String comment = null;

		stmt = con.createStatement();
		String qCheck = "SELECT * FROM workload where userID = '"
				+ sUserID + "' and year ='"+year+"'and semester = '"+term+"'";
		ResultSet rs = stmt.executeQuery(qCheck);
		String idCheck = null;
		String yearCheck = null;
		String termCheck = null;
		String wlID = null;
		while (rs.next()) {
			
			idCheck = rs.getString("userID");
			yearCheck = rs.getString("year");
			termCheck = rs.getString("semester");
			wlID = rs.getString("workloadID");	}
		
		if (strUserID.equals(idCheck)) {
			int i = stmt.executeUpdate("UPDATE workload SET year ='"
					+ year + "',semester ='" + term + "',status = '"
					+ status + "',comment = '" + comment
					+ "',userID = '" + userID + "' where workloadID = '"+wlID+"'");

		}else{

		String QueryString = "INSERT INTO workload(year,semester,status,comment,userID) VALUES('"
				+ year
				+ "','"
				+ term
				+ "','"
				+ status
				+ "','"
				+ comment
				+ "','"
				+ userID
				+ "') ";
		stmt.executeUpdate(QueryString);
		}

		out.print("<META HTTP-EQUIV=\"Refresh\" CONTENT=\"0;URL=Teacher_Assistance_Workload.jsp\">");
	} catch (Exception e) {
		out.println(e);

	}
%>