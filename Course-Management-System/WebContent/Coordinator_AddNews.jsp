<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="java.sql.Statement"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.util.Calendar"%>
<%@ page import="java.util.Date"%>
<%@ page import="java.text.DateFormat"%>
<%@ page import="java.text.SimpleDateFormat"%>
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
	// Prepare for connect DB
%>
<%@page import="java.io.InputStream"%>
<%@page import="java.util.Properties"%>
<%
	InputStream stream = application.getResourceAsStream("/fileUpload/db.properties");
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
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>Insert title here</title>
</head>

<body>
	<%
		try {
			Class.forName("com.mysql.jdbc.Driver");

			stmt = connect.createStatement();

			//get year and semester from database
			int curYear = 0;
			int curYearOnBE = 0;
			int curSemester = 0;

			String sqlYear = "SELECT * FROM cmsit.setsemesterdate;";
			ResultSet recYear = stmt.executeQuery(sqlYear);
			if ((recYear != null) && (recYear.next())) {
				Date today = new Date();
				DateFormat df = new SimpleDateFormat("yyyy-mm-dd");
				Date startDate = df.parse(recYear.getString("dateterm1_1"));
				Date endDate = df.parse(recYear.getString("dateterm1_2"));

				// specify year
				Calendar cal = Calendar.getInstance();
				cal.setTime(startDate);
				curYear = cal.get(Calendar.YEAR);

				if (today.after(startDate) || today.before(endDate)) { // specify semester
					curSemester = 1;
				} else {
					curSemester = 2;
				}

			}
			curYearOnBE = curYear + 543;
			//System.out.print("year : " + curYearOnBE);
			//System.out.println(" semester : " + curSemester);

			// specify year on specific academic year
			// 1 st year
			int yearOnBE1 = (curYear) + 543;
			String yearOnBEStr1 = Integer.toString(yearOnBE1);
			//System.out.println(yearOnBEStr1);
			//2 nd year
			int yearOnBE2 = (curYear) + 543 - 1;
			String yearOnBEStr2 = Integer.toString(yearOnBE2);
			//System.out.println(yearOnBEStr2);
			//3 rd year
			int yearOnBE3 = (curYear) + 543 - 2;
			String yearOnBEStr3 = Integer.toString(yearOnBE3);
			//System.out.println(yearOnBEStr3);
			//4 th year
			int yearOnBE4 = (curYear) + 543 - 3;
			String yearOnBEStr4 = Integer.toString(yearOnBE4);
			//System.out.println(yearOnBEStr4);

			// round 1 
			String sql = "select * from studyplan inner join course on (studyplan.courseCode=course.courseCode)where studyplan.courseCode not in (select courseplan.courseCode from courseplan) AND academicYear >= '"+yearOnBE4+"' AND academicYear <= '"+yearOnBE1+"' AND studyYear like '"+curYearOnBE+"' AND studySemester like '"+curSemester+"' group by studyplan.courseCode";
			ResultSet rec = stmt.executeQuery(sql);

			String newsDetail = null;
			if (rec != null) {
				while ((rec != null) && (rec.next())) {
					stmt = connect.createStatement();
					sql = "INSERT INTO `news` (`user`, `group`, `courseCode`, `courseName`, `major`) VALUES ('admin', 'admin', '"
							+ rec.getString("courseCode") + "', '" + rec.getString("courseName") + "', '"
							+ rec.getString("major") + "');";
					stmt.execute(sql);
				}
			} else {
				newsDetail = "All course matching.";
			} 
			
			// round 2
			String sql2 = "select * from courseplan inner join course on (courseplan.courseCode=course.courseCode)where coursePlan.courseCode not in (select studyplan.courseCode from studyplan) group by coursePlan.courseCode";
			ResultSet rec2 = stmt.executeQuery(sql2);

			String newsDetail2 = null;
			if (rec2 != null) {
				while ((rec2 != null) && (rec2.next())) {
					stmt = connect.createStatement();
					sql2 = "INSERT INTO `news` (`user`, `group`, `courseCode`, `courseName`, `major`) VALUES ('admin', 'admin', '"
							+ rec2.getString("courseCode") + "', '" + rec2.getString("courseName") + "', '"
							+ rec2.getString("major") + "');";
					stmt.execute(sql2);
					stmt.close();
				}
			} else {
				newsDetail2 = "All course matching.";
			}

			System.out.println("Update Complete.");
			String redirectURL = "Coordinator.jsp";
			response.sendRedirect(redirectURL);
			//out.println(newsDetail);
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
</body>
</html>