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

	Class.forName(readdriver);
	con = DriverManager.getConnection(url, readuser, readpass);

	int totalcount = Integer.parseInt(request
			.getParameter("totalcount"));
	System.out.println("Total " + totalcount);
	int totalcount2 = Integer.parseInt(request
			.getParameter("totalcount2"));
	System.out.println("Total2 " + totalcount2);
	String deletefake[] = request.getParameterValues("deletefake");

	String year = request.getParameter("checkyear");
	String term = request.getParameter("checkterm");

	System.out.println("Year " + year);
	System.out.println("Term " + term);

	// In courseplan	
	String strcoursecode[] = new String[totalcount];
	String strmajor[] = new String[totalcount];
	String strnumstudent[] = new String[totalcount];
	String strlect[] = new String[totalcount];
	String strlab[] = new String[totalcount];

	for (int i = 0; i < totalcount; i++) {
		strcoursecode[i] = request.getParameter("coursecode_" + i);
		strmajor[i] = request.getParameter("major_" + i);
		strnumstudent[i] = request.getParameter("numstudent_" + i);
		strlect[i] = request.getParameter("lect_" + i);
		strlab[i] = request.getParameter("lab_" + i);
	}

	for (int i = 0; i < totalcount; i++) {
		/* System.out.println("coursecode " + strcoursecode[i]);
		System.out.println("major " + strmajor[i]);
		System.out.println("numstu " + strnumstudent[i]); */

		if (null != strcoursecode[i]) {

			if (!(strlect[i].equals("") && strlab[i].equals(""))) {
				int countlectuserid = 0;
				int countlabuserid = 0;
				String lectuserid[] = new String[10];
				String labuserid[] = new String[10];
				// Get Lect Teacher and Lab Teacher
				String selectlect[] = request
						.getParameterValues("selectlect_" + i);
				String selectlab[] = request
						.getParameterValues("selectlab_" + i);
				if (selectlect != null && !strlect[i].equals("")) {
					int countlect = 0;
					for (String s : selectlect) {
						selectlect[countlect] = s;
						String[] parts = selectlect[countlect].split(
								"\\s+", 2);
						String lectfirstname = parts[0];
						String lectlastname = parts[1];
						stmt = con.createStatement();
						String QueryLectUserID = "SELECT userID FROM user WHERE firstname = '"
								+ lectfirstname
								+ "' AND lastname = '"
								+ lectlastname + "'";
						ResultSet rs = stmt
								.executeQuery(QueryLectUserID);
						if (rs.next()) {
							lectuserid[countlectuserid] = rs
									.getString("user.userID");
							countlectuserid++;
						}
					}
				}
				if (selectlab != null && !strlab[i].equals("")) {
					int countlab = 0;
					for (String s : selectlab) {
						selectlab[countlab] = s;
						String[] parts = selectlab[countlab].split(
								"\\s+", 2);
						String labfirstname = parts[0];
						String lablastname = parts[1];
						stmt = con.createStatement();
						String QueryLabUserID = "SELECT userID FROM user WHERE firstname = '"
								+ labfirstname
								+ "' AND lastname = '"
								+ lablastname + "'";
						ResultSet rs = stmt
								.executeQuery(QueryLabUserID);
						if (rs.next()) {
							labuserid[countlabuserid] = rs
									.getString("user.userID");
							countlabuserid++;
						}
					}
				}

				// Check not empty and Insert
				if (!(strcoursecode[i].equals("")
						|| strmajor[i].equals("") || strnumstudent[i]
							.equals(""))) {

					// Check coursecode in database same or not
					stmt = con.createStatement();
					String QueryCheckcourse = "SELECT * FROM currentcourse WHERE courseCode ='"
							+ strcoursecode[i]
							+ "' AND year = '"
							+ year + "' AND semester = '" + term + "'";
					ResultSet rscheck = stmt
							.executeQuery(QueryCheckcourse);
					// if same
					if (rscheck.next()) {
						String QuerySelect = "SELECT * FROM currentcourse WHERE courseCode ='"
								+ strcoursecode[i] + "' AND year = '"+year+"' AND semester = '"+term+"'";
						ResultSet rs = stmt.executeQuery(QuerySelect);
						String currentcourseid = "";
						if (rs.next()) {
							currentcourseid = rs
									.getString("currentcourseID");
						}
						String QueryInsert2 = "INSERT INTO section (currentcourseID, sectionlect, sectionlab, major, numberofstudent) values ('"
								+ currentcourseid
								+ "', '"
								+ strlect[i]
								+ "','"
								+ strlab[i]
								+ "','"
								+ strmajor[i]
								+ "' ,'"
								+ strnumstudent[i] + "')";
						stmt.executeUpdate(QueryInsert2);
						String QuerySelect2 = "SELECT * FROM section WHERE currentcourseID ='"
								+ currentcourseid + "' ORDER BY sectionID desc";
						ResultSet rs2 = stmt.executeQuery(QuerySelect2);
						String sectionid = "";
						if (rs2.next()) {
							sectionid = rs2
									.getString("section.sectionID");
						}
						for (int lec = 0; lec < countlectuserid; lec++) {
							String QueryInsertlect = "INSERT INTO candidate (sectionID, userID, teachtype) values ('"
									+ sectionid
									+ "','"
									+ lectuserid[lec] + "', 'Lect')";
							stmt.executeUpdate(QueryInsertlect);
						}
						for (int lab = 0; lab < countlabuserid; lab++) {
							String QueryInsertlab = "INSERT INTO candidate (sectionID, userID, teachtype) values ('"
									+ sectionid
									+ "','"
									+ labuserid[lab] + "', 'Lab')";
							stmt.executeUpdate(QueryInsertlab);
						}
					} else {

						String QueryInsert = "INSERT INTO currentcourse (year, semester, courseCode) values ('"
								+ year
								+ "','"
								+ term
								+ "','"
								+ strcoursecode[i] + "')";
						stmt.executeUpdate(QueryInsert);
						String QuerySelect = "SELECT * FROM currentcourse WHERE courseCode ='"
								+ strcoursecode[i] + "' AND year = '"+year+"' AND semester = '"+term+"'"; //bug wait for vm testing
						ResultSet rs = stmt.executeQuery(QuerySelect);
						String currentcourseid = "";
						if (rs.next()) {
							currentcourseid = rs
									.getString("currentcourseID");
						}
						String QueryInsert2 = "INSERT INTO section (currentcourseID, sectionlect, sectionlab, major, numberofstudent) values ('"
								+ currentcourseid
								+ "', '"
								+ strlect[i]
								+ "','"
								+ strlab[i]
								+ "','"
								+ strmajor[i]
								+ "' ,'"
								+ strnumstudent[i] + "')";
						stmt.executeUpdate(QueryInsert2);
						String QuerySelect2 = "SELECT * FROM section WHERE currentcourseID ='"
								+ currentcourseid + "' ORDER BY sectionID desc";
						ResultSet rs2 = stmt.executeQuery(QuerySelect2);
						String sectionid = "";
						if (rs2.next()) {
							sectionid = rs2
									.getString("section.sectionID");
						}
						for (int lec = 0; lec < countlectuserid; lec++) {
							String QueryInsertlect = "INSERT INTO candidate (sectionID, userID, teachtype) values ('"
									+ sectionid
									+ "','"
									+ lectuserid[lec] + "', 'Lect')";
							stmt.executeUpdate(QueryInsertlect);
						}
						for (int lab = 0; lab < countlabuserid; lab++) {
							String QueryInsertlab = "INSERT INTO candidate (sectionID, userID, teachtype) values ('"
									+ sectionid
									+ "','"
									+ labuserid[lab] + "', 'Lab')";
							stmt.executeUpdate(QueryInsertlab);
						}
					}
				}
			}

		}
	}
	// End In courseplan

	// In Duplicate
	String strcoursecode2[] = new String[totalcount2];
	String strmajor2[] = new String[totalcount2];
	String strnumstudent2[] = new String[totalcount2];
	String strlect2[] = new String[totalcount2];
	String strlab2[] = new String[totalcount2];

	for (int i = 0; i < totalcount2; i++) {
		strcoursecode2[i] = request.getParameter("coursecode2_" + i);
		strmajor2[i] = request.getParameter("major2_" + i);
		strnumstudent2[i] = request.getParameter("numstudent2_" + i);
		strlect2[i] = request.getParameter("lect2_" + i);
		strlab2[i] = request.getParameter("lab2_" + i);
	}

	for (int i = 0; i < totalcount2; i++) {
		/* System.out.println("coursecode " + strcoursecode2[i]);
		System.out.println("major " + strmajor2[i]);
		System.out.println("numstu " + strnumstudent2[i]); */

		if (null != strcoursecode2[i]) {

			if (!(strlect2[i].equals("") && strlab2[i].equals(""))) {
				
				if (deletefake != null) {
					int fake = 0;
					for (String s : deletefake) {
						fake++;
					}
					String strdelete[] = new String[fake];
					int fake2 = 0;
					for (String s : deletefake) {
						strdelete[fake2] = s;
						System.out.println("delete " + strdelete[fake2]);
						stmt = con.createStatement();
						String QueryDelete = "Delete from notcandidate where notcandidateID = '"
								+ strdelete[fake2] + "'";
						stmt.executeUpdate(QueryDelete);
						fake2++;
					}

				}
				
				int countlectuserid2 = 0;
				int countlabuserid2 = 0;
				String lectuserid2[] = new String[10];
				String labuserid2[] = new String[10];
				// Get Lect Teacher and Lab Teacher
				String selectlect2[] = request
						.getParameterValues("selectlect2_" + i);
				String selectlab2[] = request
						.getParameterValues("selectlab2_" + i);
				if (selectlect2 != null && !strlect2[i].equals("")) {
					int countlect2 = 0;
					for (String s : selectlect2) {
						selectlect2[countlect2] = s;
						String[] parts = selectlect2[countlect2].split(
								"\\s+", 2);
						String lectfirstname2 = parts[0];
						String lectlastname2 = parts[1];
						stmt = con.createStatement();
						String QueryLectUserID = "SELECT userID FROM user WHERE firstname = '"
								+ lectfirstname2
								+ "' AND lastname = '"
								+ lectlastname2 + "'";
						ResultSet rsfake = stmt
								.executeQuery(QueryLectUserID);
						if (rsfake.next()) {
							lectuserid2[countlectuserid2] = rsfake
									.getString("user.userID");
							countlectuserid2++;
						}
					}
				}
				if (selectlab2 != null && !strlab2[i].equals("")) {
					int countlab2 = 0;
					for (String s : selectlab2) {
						selectlab2[countlab2] = s;
						String[] parts = selectlab2[countlab2].split(
								"\\s+", 2);
						String labfirstname2 = parts[0];
						String lablastname2 = parts[1];
						stmt = con.createStatement();
						String QueryLabUserID = "SELECT userID FROM user WHERE firstname = '"
								+ labfirstname2
								+ "' AND lastname = '"
								+ lablastname2 + "'";
						ResultSet rsfake = stmt
								.executeQuery(QueryLabUserID);
						if (rsfake.next()) {
							labuserid2[countlabuserid2] = rsfake
									.getString("user.userID");
							countlabuserid2++;
						}
					}
				}

				// Check not empty and Insert
				if (!(strcoursecode2[i].equals("")
						|| strmajor2[i].equals("") || strnumstudent2[i]
							.equals(""))) {

					stmt = con.createStatement();
					String QueryCheckcoursefake = "SELECT * FROM currentcourse WHERE courseCode ='"
							+ strcoursecode2[i]
							+ "' AND year = '"
							+ year + "' AND semester = '" + term + "'";
					ResultSet rscheckfake = stmt
							.executeQuery(QueryCheckcoursefake);
					if (rscheckfake.next()) {
						String QuerySelectfake = "SELECT * FROM currentcourse WHERE courseCode ='"
								+ strcoursecode2[i] + "' AND year = '"+year+"' AND semester = '"+term+"'";
						ResultSet rsfake = stmt
								.executeQuery(QuerySelectfake);
						String currentcourseid2 = "";
						if (rsfake.next()) {
							currentcourseid2 = rsfake
									.getString("currentcourseID");
						}
						String QueryInsertfake2 = "INSERT INTO section (currentcourseID, sectionlect, sectionlab, major, numberofstudent) values ('"
								+ currentcourseid2
								+ "', '"
								+ strlect2[i]
								+ "','"
								+ strlab2[i]
								+ "','"
								+ strmajor2[i]
								+ "' ,'"
								+ strnumstudent2[i] + "')";
						stmt.executeUpdate(QueryInsertfake2);
						String QuerySelectfake2 = "SELECT * FROM section WHERE currentcourseID ='"
								+ currentcourseid2 + "' ORDER BY sectionID desc";
						ResultSet rsfake2 = stmt
								.executeQuery(QuerySelectfake2);
						String sectionid2 = "";
						if (rsfake2.next()) {
							sectionid2 = rsfake2
									.getString("section.sectionID");
						}
						for (int lec = 0; lec < countlectuserid2; lec++) {
							String QueryInsertlectfake = "INSERT INTO candidate (sectionID, userID, teachtype) values ('"
									+ sectionid2
									+ "','"
									+ lectuserid2[lec] + "', 'Lect')";
							stmt.executeUpdate(QueryInsertlectfake);
						}
						for (int lab = 0; lab < countlabuserid2; lab++) {
							String QueryInsertlabfake = "INSERT INTO candidate (sectionID, userID, teachtype) values ('"
									+ sectionid2
									+ "','"
									+ labuserid2[lab] + "', 'Lab')";
							stmt.executeUpdate(QueryInsertlabfake);
						}
					} else {

						String QueryInsertfake = "INSERT INTO currentcourse (year, semester, courseCode) values ('"
								+ year
								+ "','"
								+ term
								+ "','"
								+ strcoursecode2[i] + "')";
						stmt.executeUpdate(QueryInsertfake);
						String QuerySelectfake = "SELECT * FROM currentcourse WHERE courseCode ='"
								+ strcoursecode2[i] + "' AND year = '"+year+"' AND semester = '"+term+"'"; // bug wait for test
						ResultSet rsfake = stmt
								.executeQuery(QuerySelectfake);
						String currentcourseid2 = "";
						if (rsfake.next()) {
							currentcourseid2 = rsfake
									.getString("currentcourseID");
						}
						String QueryInsertfake2 = "INSERT INTO section (currentcourseID, sectionlect, sectionlab, major, numberofstudent) values ('"
								+ currentcourseid2
								+ "', '"
								+ strlect2[i]
								+ "','"
								+ strlab2[i]
								+ "','"
								+ strmajor2[i]
								+ "' ,'"
								+ strnumstudent2[i] + "')";
						stmt.executeUpdate(QueryInsertfake2);
						String QuerySelectfake2 = "SELECT * FROM section WHERE currentcourseID ='"
								+ currentcourseid2 + "' ORDER BY sectionID desc";
						ResultSet rsfake2 = stmt
								.executeQuery(QuerySelectfake2);
						String sectionid2 = "";
						if (rsfake2.next()) {
							sectionid2 = rsfake2
									.getString("section.sectionID");
						}
						for (int lec = 0; lec < countlectuserid2; lec++) {
							String QueryInsertlectfake = "INSERT INTO candidate (sectionID, userID, teachtype) values ('"
									+ sectionid2
									+ "','"
									+ lectuserid2[lec] + "', 'Lect')";
							stmt.executeUpdate(QueryInsertlectfake);
						}
						for (int lab = 0; lab < countlabuserid2; lab++) {
							String QueryInsertlabfake = "INSERT INTO candidate (sectionID, userID, teachtype) values ('"
									+ sectionid2
									+ "','"
									+ labuserid2[lab] + "', 'Lab')";
							stmt.executeUpdate(QueryInsertlabfake);
						}
					}
				}
			}

		}
	}
	//End In Duplicate

	response.sendRedirect("Admin_Candidate.jsp");
%>