<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="java.sql.Statement"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.DriverManager"%>
<%
	// Prepare for connect DB
%>
<%@page import="java.io.InputStream"%>
<%@page import="java.util.Properties"%>
<%
	InputStream stream = application
			.getResourceAsStream("/fileUpload/db.properties");
	Properties props = new Properties();
	props.load(stream);

	String readurl = props.getProperty("url");
	String readdriver = props.getProperty("driver");
	String readuser = props.getProperty("user");
	String readpass = props.getProperty("password");

	Statement stmt = null;
	Connection connect = null;
	String url = readurl;

	Class.forName(readdriver);
	connect = DriverManager.getConnection(url, readuser, readpass);
%>
<%
	// End Prepare for connect DB
%>
<%
	// Create by Fatez

	Object strUserID = session.getAttribute("sUserID");
	if (strUserID == null) // Check Login
	{
		response.sendRedirect("Main_Login.jsp");
	}

	try {
		Class.forName("com.mysql.jdbc.Driver");

		stmt = connect.createStatement();

		String sql = "SELECT * FROM  user WHERE userID = '"
				+ strUserID.toString() + "' ";

		String sUsername = request.getParameter("txtUsername");

		String userID = null;
		String userType = null;
		String firstname = null;
		String lastname = null;
		String userName = null;
		String password = null;
		String major = null;

		String userAdminType = "Admin";
		String userTeacherType = "Teacher";
		String userTAType = "Teacher Assistance";
		String userCoType = "Coordinator";

		ResultSet rec = stmt.executeQuery(sql);
		while (rec.next()) {

			userID = rec.getString("userID");
			userType = rec.getString("usertype");
			firstname = rec.getString("firstname");
			lastname = rec.getString("lastname");
			major = rec.getString("major");
			userName = rec.getString("username");
			password = rec.getString("password");
			
			session.setAttribute("sUserID", userID);
			session.setAttribute("sFirstname", firstname);
			session.setAttribute("sLastname", lastname);
			session.setAttribute("sUserType", userType);
			session.setAttribute("sMajor", major);
			session.setAttribute("sUserName", userName);
			session.setAttribute("sPassword", password);
			

			// check type of user to auther user
			if (userType.equals(userAdminType)) {
				out.print("<META HTTP-EQUIV=\"Refresh\" CONTENT=\"0;URL=Admin_News.jsp\">");
				System.out.println("User loged in as ADMIN");
			} else if (userType.equals(userTeacherType)) {
				out.print("<META HTTP-EQUIV=\"Refresh\" CONTENT=\"0;URL=Teacher_News.jsp\">");
				System.out.println("User loged in as TEACHER");
			} else if (userType.equals(userTAType)) {
				out.print("<META HTTP-EQUIV=\"Refresh\" CONTENT=\"0;URL=Teacher_Assistance_News.jsp\">");
				System.out.println("User loged in as TA");
			} else if (userType.equals(userCoType)) {
				out.print("<META HTTP-EQUIV=\"Refresh\" CONTENT=\"0;URL=Coordinator.jsp\">");
				System.out.println("User loged in as COORDINATOR");
			} else {
				out.print("Type of user not have roles");
				System.out.println("User loged in as NONE TYPE");
			}
		}

	} catch (Exception e) {
		// TODO Auto-generated catch block
		out.println(e.getMessage());
		e.printStackTrace();
	}

	try {
		if (stmt != null) {
			stmt.close();
			connect.close();
		}
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		out.println(e.getMessage());
		e.printStackTrace();
	}
%>
