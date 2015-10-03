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
	Connection con = null;
	String url = readurl;

	Class.forName(readdriver);
	con = DriverManager.getConnection(url, readuser, readpass);
%>
<%
	// End Prepare for connect DB
%>


<%
	// Create by Fatez

	Object strUserID = session.getAttribute("sUserID");
	if (strUserID == null) // Check Login
	{
		response.sendRedirect("LoginCMS.jsp");
	}

	Connection connect = null;
	Statement s = null;

	try {
		Class.forName("com.mysql.jdbc.Driver");

		s = connect.createStatement();

		String sql = "SELECT * FROM  user WHERE userID = '"
				+ strUserID.toString() + "' ";

		String sUsername = request.getParameter("txtUsername");

		String userType = null;
		String firstname = null;
		String lastname = null;

		String userAdminType = "Admin";
		String userTeacherType = "Teacher";
		String userTAType = "Teacher Assistance";
		String userCoType = "Coordinator";

		ResultSet rec = s.executeQuery(sql);
		while (rec.next()) {

			userType = rec.getString("usertype");
			firstname = rec.getString("firstname");
			lastname = rec.getString("lastname");

			session.setAttribute("sFirstname", firstname);
			session.setAttribute("sLastname", lastname);
			session.setAttribute("sUserType", userType);

			// check type of user to auther user
			if (userType.equals(userAdminType)) {
				out.print("<META HTTP-EQUIV=\"Refresh\" CONTENT=\"0;URL=Admin_News.jsp\">");
			} else if (userType.equals(userTeacherType)) {
				out.print("<META HTTP-EQUIV=\"Refresh\" CONTENT=\"0;URL=Teacher_News.jsp\">");

			} else if (userType.equals(userTAType)) {
				out.print("<META HTTP-EQUIV=\"Refresh\" CONTENT=\"0;URL=Teacher_Assistance_News.jsp\">");

			} else if (userType.equals(userCoType)) {
				out.print("<META HTTP-EQUIV=\"Refresh\" CONTENT=\"0;URL=Coordinator.jsp\">");

			} else {
				out.print("Type of user not have roles");
			}
		}

	} catch (Exception e) {
		// TODO Auto-generated catch block
		out.println(e.getMessage());
		e.printStackTrace();
	}

	try {
		if (s != null) {
			s.close();
			connect.close();
		}
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		out.println(e.getMessage());
		e.printStackTrace();
	}
%>
