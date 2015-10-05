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
	request.setCharacterEncoding("UTF-8");

	String username = request.getParameter("username");
	String password = request.getParameter("password");
	String confirmpassword = request.getParameter("confirmpassword");
	String firstname = request.getParameter("firstname");
	String lastname = request.getParameter("lastname");
	String selectusertype = request.getParameter("selectusertype");
	String selectmajor = request.getParameter("selectmajor");

	System.out.println(username);
	System.out.println(password);
	System.out.println(confirmpassword);
	System.out.println(firstname);
	System.out.println(lastname);
	System.out.println(selectusertype);
	System.out.println(selectmajor);

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

		String QueryUsername = "Select username from user where username = '"
				+ username + "'";
		ResultSet rs = stmt.executeQuery(QueryUsername);

		if (rs.isBeforeFirst()) {

			rs.next();
			String DBuser = rs.getString(1);
			System.out.println("Check username from DB " + DBuser);

			if (DBuser.equalsIgnoreCase(username)) {
				System.out.println("This username is already taken.");
				request.setAttribute("Error username",
						"This username is already taken.");
				request.getRequestDispatcher("/Admin_User_AddForm.jsp")
						.forward(request, response);
			}

		} else {
			System.out.println("This username is never use before.");
			String QueryString = "Insert into user (username, password, firstname, lastname, major, usertype) values ('"
					+ username
					+ "','"
					+ password
					+ "','"
					+ firstname
					+ "','"
					+ lastname
					+ "','"
					+ selectmajor
					+ "','"
					+ selectusertype + "')";
			stmt.executeUpdate(QueryString);
			System.out.println("Insert Success.");

			response.sendRedirect("Admin_User.jsp");
			/*request.getRequestDispatcher("/Admin_User.jsp").forward(
					request, response);*/
		}

	} catch (ClassNotFoundException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	} catch (SQLException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
	}
%>