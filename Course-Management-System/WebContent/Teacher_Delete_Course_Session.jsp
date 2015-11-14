<%@ page contentType="text/html; charset=utf-8" language="java" import="java.sql.*" errorPage="" %>
<%@page import="java.io.InputStream"%>
<%@page import="java.util.Properties"%>
<%



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
	Object strUserID = session.getAttribute("sUserID");
	String coursesurveyID = request.getParameter("coursesurveyID");

	stmt = con.createStatement();
	String QueryString = "delete from course_survey where coursesurveyID = '"+coursesurveyID+"'";
	
	stmt.executeUpdate(QueryString);
	
	
	
	stmt = con.createStatement();
	String checkType = "SELECT * FROM cms.user where userID = '"+strUserID+"' ; ";
	ResultSet rsCheck = stmt.executeQuery(checkType);
	String userType = null ;
	while(rsCheck.next()){
		userType = rsCheck.getString("usertype");
		if(userType.equals("Teacher")){
			out.print("<META HTTP-EQUIV=\"Refresh\" CONTENT=\"0;URL=Teacher_Course.jsp\">");
		}else{
			out.print("<META HTTP-EQUIV=\"Refresh\" CONTENT=\"0;URL=Teacher_Assistance_Course.jsp\">");
		}
		
		
	}
	
	
con.close();
%>