<%@ page language="java" contentType="text/html; charset=utf-8"
	import="java.sql.*" pageEncoding="utf-8"%>

<%@page import="java.io.InputStream"%>
<%@page import="java.util.Properties"%>

<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page import="java.io.*,java.util.Locale"%>
<%@page import="java.util.ArrayList" %>


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

	stmt = con.createStatement();
	//check length of teacher
	String Queryteacher = "SELECT * FROM user WHERE usertype = 'Teacher'";
	ResultSet rsteacher = stmt.executeQuery(Queryteacher);
	rsteacher.last();
	int countteacher = rsteacher.getRow();
	//System.out.println(countteacher);
	//end check length of teacher
	//query name of teacher
	String[] arrayTeacher = new String[countteacher];
	String Queryteacher2 = "SELECT * FROM user WHERE usertype = 'Teacher'";
	ResultSet rsteacher2 = stmt.executeQuery(Queryteacher2);
	int countteacher2 = 0;
	while (rsteacher2.next()) {
		arrayTeacher[countteacher2] = rsteacher2
				.getString("user.firstname")
				+ " "
				+ rsteacher2.getString("user.lastname");
		countteacher2++;
	}
	//end query name of teacher
	//check length of ta
	String Queryta = "SELECT * FROM user WHERE usertype = 'Teaching Assistance'";
	ResultSet rsta = stmt.executeQuery(Queryta);
	rsta.last();
	int countta = rsta.getRow();
	//System.out.println(countta);
	//end check length of ta
	//query name of ta
	String[] arrayTa = new String[countta];
	String Queryta2 = "SELECT * FROM user WHERE usertype = 'Teaching Assistance'";
	ResultSet rsta2 = stmt.executeQuery(Queryta2);
	int countta2 = 0;
	while (rsta2.next()) {
		arrayTa[countta2] = rsta2.getString("user.firstname") + " "
				+ rsta2.getString("user.lastname");
		countta2++;
	}
	//end query name of ta
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html lang="en">
<head>
<!--
        ===
        This comment should NOT be removed.

        Charisma v2.0.0

        Copyright 2012-2014 Muhammad Usman
        Licensed under the Apache License v2.0
        http://www.apache.org/licenses/LICENSE-2.0

        http://usman.it
        http://twitter.com/halalit_usman
        ===
    -->
<meta charset="utf-8">
<title>Candidate</title>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description"
	content="Charisma, a fully featured, responsive, HTML5, Bootstrap admin template.">
<meta name="author" content="Muhammad Usman">

<!-- The styles -->
<link id="bs-css" href="css/bootstrap-cerulean.min.css" rel="stylesheet">
<link href="css/charisma-app.css" rel="stylesheet">
<link href="bower_components/fullcalendar/dist/fullcalendar.css"
	rel="stylesheet">
<link href="bower_components/fullcalendar/dist/fullcalendar.print.css"
	rel="stylesheet" media="print">
<link href="bower_components/chosen/chosen.min.css" rel="stylesheet">
<link href="bower_components/colorbox/example3/colorbox.css"
	rel="stylesheet">
<link href="bower_components/responsive-tables/responsive-tables.css"
	rel="stylesheet">
<link
	href="bower_components/bootstrap-tour/build/css/bootstrap-tour.min.css"
	rel="stylesheet">
<link href="css/jquery.noty.css" rel="stylesheet">
<link href="css/noty_theme_default.css" rel="stylesheet">
<link href="css/elfinder.min.css" rel="stylesheet">
<link href="css/elfinder.theme.css" rel="stylesheet">
<link href="css/jquery.iphone.toggle.css" rel="stylesheet">
<link href="css/uploadify.css" rel="stylesheet">
<link href="css/animate.min.css" rel="stylesheet">
<link href="css/custom.css" rel="stylesheet">

<script src="dist/sweetalert-dev.js"></script>
<link rel="stylesheet" href="dist/sweetalert.css">

<!-- jQuery -->
<script src="bower_components/jquery/jquery.min.js"></script>

<!-- The HTML5 shim, for IE6-8 support of HTML5 elements -->
<!--[if lt IE 9]>
    <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->

<!-- The fav icon -->
<link rel="shortcut icon" href="img/favicon.ico">

</head>

<body>
	<!-- topbar starts -->
	<div class="navbar navbar-default" role="navigation">
		<div class="navbar-inner">
			<button type="button" class="navbar-toggle pull-left animated flip">
				<span class="sr-only">Toggle navigation</span> <span
					class="icon-bar"></span> <span class="icon-bar"></span> <span
					class="icon-bar"></span>
			</button>
			<a class="navbar-brand" href="Admin_News.jsp"> <span>IT:CMS</span></a>
			<!-- user dropdown starts -->
			<div class="btn-group pull-right">
				<button class="btn btn-default dropdown-toggle"
					data-toggle="dropdown">
					<i class="glyphicon glyphicon-user"></i><span
						class="hidden-sm hidden-xs"> admin</span> <span class="caret"></span>
				</button>
				<ul class="dropdown-menu">
					<li><a href="Admin_FormUserInfo.jsp">Profile</a></li>
					<li class="divider"></li>
					<li><a href="Main_Logout.jsp">Logout</a></li>
				</ul>
			</div>
			<!-- user dropdown ends -->

			<!-- theme selector starts -->

			<!-- theme selector ends -->

		</div>
	</div>
	<!-- topbar ends -->
	<div class="ch-container">
		<div class="row">

			<!-- left menu starts -->
			<div class="col-sm-2 col-lg-2">
				<div class="sidebar-nav">
					<div class="nav-canvas">
						<div class="nav-sm nav nav-stacked"></div>
						<ul style="" class="nav nav-pills nav-stacked main-menu">
							<li class="nav-header">Main</li>
							<li><a class="ajax-link" href="Admin_News.jsp"><i
									class="glyphicon glyphicon-home"></i><span> News</span></a></li>
							<li class="nav-header hidden-md">Management</li>
							<li class="active"><a class="ajax-link"
								href="Admin_Candidate.jsp"><i
									class="glyphicon glyphicon-align-justify"></i><span>
										Candidate</span></a></li>
							<li><a class="ajax-link" href="Admin_CoursePlan.jsp"><i
									class="glyphicon glyphicon-align-justify"></i><span>
										Course Plan</span></a></li>
							<li><a class="ajax-link" href="Admin_Examination.jsp"><i
									class="glyphicon glyphicon-align-justify"></i><span>
										Examination</span></a></li>
							<li><a class="ajax-link" href="Admin_User.jsp"><i
									class="glyphicon glyphicon-align-justify"></i><span>
										User</span></a></li>
							<li><a class="ajax-link" href="Admin_History.jsp"><i
									class="glyphicon glyphicon-align-justify"></i><span>
										History</span></a></li>
							<li><a class="ajax-link" href="Admin_Report.jsp"><i
									class="glyphicon glyphicon-align-justify"></i><span>
										Report</span></a></li>
							<li><a class="ajax-link" href="Admin_Setting.jsp"><i
									class="glyphicon glyphicon-align-justify"></i><span>
										Setting</span></a></li>
						</ul>
					</div>
				</div>
			</div>
			<!--/span-->
			<!-- left menu ends -->

			<div id="content" class="col-lg-10 col-sm-10">
				<!-- content starts -->
				<div>
					<ul class="breadcrumb">
						<li><a href="Admin_News.jsp">Home</a></li>
						<li><a href="Admin_Candidate.jsp">Candidate</a></li>
					</ul>
				</div>
				
				
			<div class="row">
					<div class="box col-md-12">
						<div class="row">
							<div class="box col-md-12">
								<div class="box-inner">
									<div class="box-header well" data-original-title="">
										<h2>
											<i class="glyphicon glyphicon-list-alt"></i>&nbsp;&nbsp;Workload
										</h2>
										<div class="box-icon">
											<a href="#settingforworkload"
												class="btn btn-setting btn-round btn-default"
												data-toggle="modal"><i class="glyphicon glyphicon-cog"></i></a>
											<a href="#" class="btn btn-minimize btn-round btn-default"><i
												class="glyphicon glyphicon-chevron-down"></i></a> <a href="#"
												class="btn btn-close btn-round btn-default"><i
												class="glyphicon glyphicon-remove"></i></a>
										</div>
									</div>
									
									<% 
									
									stmt = con.createStatement();
									String qUser = "SELECT * FROM user where usertype = 'Teaching Assistance' or usertype = 'Teacher';";
									ResultSet rsUser = stmt.executeQuery(qUser);
									
									
									
									%>
									
									<div class="box-content" style="display: none;">
										<table
											class="table table-striped table-bordered bootstrap-datatable datatable responsive">
											<thead>
												<tr>
													<th width="500px">Lecture</th>
													<th>Hours / Week</th>
													<th>Workload / Week</th>
													<th>Status</th>
													<th>Comment</th>
													<th>Actions</th>
												</tr>
											</thead>
											
											<% 					
											String Astrdateterm1_1 = "";
											String Astrdateterm1_2 = "";
											String Astrdateterm2_1 = "";
											String Astrdateterm2_2 = "";

											String Aacademicyear = null;
											String Aacademicterm = null;

											if (null == (String) session.getAttribute("WorkloadYear")) {

												Date td = new Date();
												String strtd = new String("");
												SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
												SimpleDateFormat format2 = new SimpleDateFormat("yyyy-MM-dd",
														new Locale("th"));
												strtd = format.format(td);
												Date today = format.parse(strtd);
												//System.out.println(today);

												/* String[] datetd = strtd.split("-", 3);
												int ydatetd = Integer.parseInt(datetd[0]);
												int mdatetd = Integer.parseInt(datetd[1]);
												int ddatetd = Integer.parseInt(datetd[2]); */

												stmt = con.createStatement();
												String QueryString = "SELECT * FROM setsemesterdate WHERE setsemesterdate_ID = '1'";
												ResultSet rs = stmt.executeQuery(QueryString);
												if (rs.next()) {
													Astrdateterm1_1 = rs.getString("dateterm1_1");
													Astrdateterm1_2 = rs.getString("dateterm1_2");
													Astrdateterm2_1 = rs.getString("dateterm2_1");
													Astrdateterm2_2 = rs.getString("dateterm2_2");

													Date dateterm1_1 = format2.parse(Astrdateterm1_1);
													Date dateterm1_2 = format2.parse(Astrdateterm1_2);
													Date dateterm2_1 = format2.parse(Astrdateterm2_1);
													Date dateterm2_2 = format2.parse(Astrdateterm2_2);

													String[] term1_1 = Astrdateterm1_1.split("-", 3);
													int yterm1_1 = 543 + Integer.parseInt(term1_1[0]);
													int mterm1_1 = Integer.parseInt(term1_1[1]);
													int dterm1_1 = Integer.parseInt(term1_1[2]);

													int intacademicyear = yterm1_1;
													Aacademicyear = Integer.toString(intacademicyear);

													/* System.out.println(dateterm1_1);
													System.out.println(dateterm1_2);
													System.out.println(dateterm2_1);
													System.out.println(dateterm2_2); */

													if ((today.before(dateterm1_2) || today.equals(dateterm1_2))
															&& (today.after(dateterm1_1) || today
																	.equals(dateterm1_1))) {
														Aacademicterm = "1";
													} else if ((today.before(dateterm2_2) || today
															.equals(dateterm2_2))
															&& (today.after(dateterm2_1) || today
																	.equals(dateterm2_1))) {
														Aacademicterm = "2";
													} else {
														Aacademicyear = "";
														Aacademicterm = "";
														System.out.println("None");
													}
												}

												session.setAttribute("academicyear", Aacademicyear);
												session.setAttribute("academicterm", Aacademicterm);
										%>
										<p>
											<b><i>Year : <%=Aacademicyear%> Term : <%=Aacademicterm%>
											</i></b>
										</p>

										<%
											} else {
										%>

										<p>
											<b><i>Year : <%=(String) session.getAttribute("WorkloadYear")%>
													Term : <%=(String) session.getAttribute("WorkloadTerm")%></i></b>
										</p>

										<%
											}
										%>
										<%
											
										
											String Syear = "";
											String Sterm = "";
											if (null == (String) session.getAttribute("WorkloadYear")) {
												Syear = (String) session.getAttribute("academicyear");
												Sterm = (String) session.getAttribute("academicterm");
											} else if (null != (String) session.getAttribute("WorkloadYear")) {
												Syear = (String) session.getAttribute("WorkloadYear");
												Sterm = (String) session.getAttribute("WorkloadTerm");
											} else {
												Syear = null;
												Sterm = null;
											}
										%>
											
											<%
											
											while(rsUser.next()){ 
											String userID = rsUser.getString("userID");
											
											%>
											<tbody>
												<tr>
													<td><%out.print(rsUser.getString("user.firstname")+" "+ rsUser.getString("user.lastname")); %></td>
													<td><%stmt = con.createStatement();
													String courseFinal = "SELECT * FROM section inner join candidate inner join currentcourse inner join course where userID = '"
															+ userID
															+ "' and currentcourse.courseCode = course.courseCode and section.currentcourseID = currentcourse.currentcourseID and currentcourse.year = '"+Syear+"' and currentcourse.semester = '"+Sterm+"'  and  section.sectionID = candidate.sectionID  group by currentcourse.courseCode;";
													ResultSet rsFinal = stmt.executeQuery(courseFinal); 
													
													
													
													ArrayList<Integer> listHourAll = new ArrayList<Integer>();
													ArrayList<Double> listResult = new ArrayList<Double>();
													
													if (userID != null) {
														while (rsFinal.next()) {
															
															int of_lec = 0;
															int of_lecturers = 0;
															int of_lab = 0;
															int of_lablecturers = 0;
															double wlLect = 0;
															double wlLab = 0;
															
															int hourAll = 0 ;
															double result =0;
															
															String courseCode = rsFinal.getString("course.courseCode");
															String courseName = rsFinal.getString("course.courseName");
															String credit = null;
															credit = rsFinal.getString("course.Credit");
															System.out.print(credit);
															String[] parts = credit.split("[\\s()]", 4);

															System.out.println(credit);
															String creditSplit = parts[0];
															String splitnext = parts[2];

															String[] partstwo = splitnext.split("-", 3);
															String lect = partstwo[0];
															String lab = partstwo[1];
															String self = partstwo[2];

															int lect_of_hour = Integer.parseInt(lect);
															int lab_of_hour = Integer.parseInt(lab);
															
															// หาจำนวน section lect ที่ สอนในวิชานั้น
															if(courseName.equalsIgnoreCase("Senior Project 2") 
																	|| courseName.equalsIgnoreCase("Co-operative Education") 
																	|| courseName.equalsIgnoreCase("Senior Project 1")){
																
															}else{
															if (lect_of_hour == 0) {
															
																//out.print(lect_of_hour);
															} else {

																
																
																
																stmt = con.createStatement();
																String qOfLec = "SELECT * FROM section inner join candidate inner join currentcourse inner join course where userID = '"
																		+ userID
																		+ "' and currentcourse.courseCode = course.courseCode and section.currentcourseID = currentcourse.currentcourseID and currentcourse.year = '"
																		+ Syear
																		+ "' and currentcourse.semester = '"
																		+ Sterm
																		+ "' and  section.sectionID = candidate.sectionID and candidate.teachtype = 'Lect' and currentcourse.courseCode = '"
																		+ courseCode
																		+ "'  group by section.sectionlect   ";
																ResultSet rsOfLec = stmt.executeQuery(qOfLec);
																rsOfLec.last();
																of_lec = rsOfLec.getRow();
																System.out.print(of_lec);
																//of_lec = rsOfLec.getInt("rowcount");
																//out.print(of_lec);
																

															}
															}
															
															// หาจำนวน อ. ท่ีสอนใน Lect นั้น
															stmt = con.createStatement();
															String qOfLectures = "SELECT * FROM section inner join candidate inner join currentcourse inner join course where currentcourse.courseCode = course.courseCode and section.currentcourseID = currentcourse.currentcourseID and currentcourse.year = '"
																	+ Syear
																	+ "' and currentcourse.semester = '"
																	+ Sterm
																	+ "' and  section.sectionID = candidate.sectionID and candidate.teachtype = 'Lect' and currentcourse.courseCode = '"
																	+ courseCode
																	+ "' and candidate.userID = '"
																	+ userID
																	+ "' group by candidate.userID ";
															ResultSet rsOfLectures = stmt.executeQuery(qOfLectures);

															rsOfLectures.last();
															of_lecturers = rsOfLectures.getRow();
															//out.print(of_lecturers);
															
															
															if(courseName.equalsIgnoreCase("Senior Project 2") 
																	|| courseName.equalsIgnoreCase("Co-operative Education") 
																	|| courseName.equalsIgnoreCase("Senior Project 1")){
																
																
															}else{
															
															if (lab_of_hour == 0) {
																//out.print(lab_of_hour);
															} else {

																stmt = con.createStatement();
																String qOfLec = "SELECT COUNT(*) AS rowcount FROM section inner join candidate inner join currentcourse inner join course where userID = '"
																		+ userID
																		+ "' and currentcourse.courseCode = course.courseCode and section.currentcourseID = currentcourse.currentcourseID and currentcourse.year = '"
																		+ Syear
																		+ "' and currentcourse.semester = '"
																		+ Sterm
																		+ "' and  section.sectionID = candidate.sectionID and candidate.teachtype = 'Lab' and currentcourse.courseCode = '"
																		+ courseCode + "'  ";
																ResultSet rsOfLec = stmt.executeQuery(qOfLec);

																rsOfLec.next();
																of_lab = rsOfLec.getInt("rowcount");
																//out.print(of_lab);

																

															}
															}
															stmt = con.createStatement();
															String qcheckType = "select * from user where userID = '"
																	+ userID + "' ";
															String userType = null;
															ResultSet rsCheckType = stmt.executeQuery(qcheckType);
															while (rsCheckType.next()) {
																userType = rsCheckType.getString("usertype");
															}

															if (userType.equals("Teacher")) {
																// หาจำนวน อ. ท่ีสอนใน Lab นั้น
																stmt = con.createStatement();
																String qOfLecturesLab = "SELECT * FROM section inner join candidate inner join currentcourse inner join course inner join user where currentcourse.courseCode = course.courseCode and section.currentcourseID = currentcourse.currentcourseID and currentcourse.year = '"
																		+ Syear
																		+ "' and currentcourse.semester = '"
																		+ Sterm
																		+ "' and  section.sectionID = candidate.sectionID  and candidate.teachtype = 'Lab' and currentcourse.courseCode = '"
																		+ courseCode
																		+ "' and user.usertype = 'Teacher' and candidate.userID = '"
																		+ userID + "' group by candidate.userID;  ";
																ResultSet rsOfLec = stmt.executeQuery(qOfLecturesLab);
																rsOfLec.last();
																of_lablecturers = rsOfLec.getRow();
																while (rsOfLec.next()) {
																	String a = rsOfLec
																			.getString("currentcourse.courseCode");

																}

																//out.print(of_lablecturers);

															} else if (userType.equals("Teaching Assistance")) {
																// หาจำนวน อ. ท่ีสอนใน Lab นั้น
																stmt = con.createStatement();
																String qOfLecturesLab = "SELECT * FROM section inner join candidate inner join currentcourse inner join course inner join user where currentcourse.courseCode = course.courseCode and section.currentcourseID = currentcourse.currentcourseID and currentcourse.year = '"
																		+ Syear
																		+ "' and currentcourse.semester = '"
																		+ Sterm
																		+ "' and  section.sectionID = candidate.sectionID  and candidate.teachtype = 'Lab' and currentcourse.courseCode = '"
																		+ courseCode
																		+ "' and user.usertype = 'Teaching Assistance' and candidate.userID = '"
																		+ userID + "'  group by candidate.userID;  ";
																ResultSet rsOfLec = stmt.executeQuery(qOfLecturesLab);
																rsOfLec.last();
																of_lablecturers = rsOfLec.getRow();
																while (rsOfLec.next()) {
																	String a = rsOfLec
																			.getString("currentcourse.courseCode");

																}

																//out.print(of_lablecturers);

															}
															
															if(courseName.equalsIgnoreCase("Senior Project 2") 
																	|| courseName.equalsIgnoreCase("Co-operative Education") 
																	|| courseName.equalsIgnoreCase("Senior Project 1")){
																
																hourAll = 0 ;
																listHourAll.add(hourAll);
															
															}else{
															
															
																int of_lec_all_hour = 0;
																int of_lab_all_hour = 0;
																of_lec_all_hour = lect_of_hour * of_lec;
																of_lab_all_hour = lab_of_hour * of_lab;

																hourAll = of_lec_all_hour + of_lab_all_hour;
																listHourAll.add(hourAll);
																			
																
															}
																
																
														}
														}
													
													int totalHour  = 0 ;
													double totalResult = 0 ;
													
													for(int i = 0; i<listHourAll.size(); i++)
													  {
														  
														totalHour = totalHour + listHourAll.get(i);
														
														
														  }
													 out.print(totalHour);
													
													%></td>
													<td>
													<%stmt = con.createStatement();
													String courseFinal2 = "SELECT * FROM cms.section inner join candidate inner join currentcourse inner join course where userID = '"
															+ sUserID
															+ "' and currentcourse.courseCode = course.courseCode and section.currentcourseID = currentcourse.currentcourseID and currentcourse.year = '"+Syear+"' and currentcourse.semester = '"+Sterm+"'  and  section.sectionID = candidate.sectionID and candidate.teachtype = 'Lect' group by currentcourse.courseCode;";
													ResultSet rsFinal2 = stmt.executeQuery(courseFinal);
													
													
													
													
													ArrayList<Double> listResult2 = new ArrayList<Double>();
													
													if (userID != null) {
														while (rsFinal2.next()) {
															
															int of_lec = 0;
															int of_lecturers = 0;
															int of_lab = 0;
															int of_lablecturers = 0;
															double wlLect = 0;
															double wlLab = 0;
															
															int hourAll = 0 ;
															double result =0;
															
															String courseCode = rsFinal2.getString("course.courseCode");
															String courseName = rsFinal2.getString("course.courseName");
															String credit = null;
															credit = rsFinal2.getString("course.Credit");
															System.out.print(credit);
															String[] parts = credit.split("[\\s()]", 4);

															System.out.println(credit);
															String creditSplit = parts[0];
															String splitnext = parts[2];

															String[] partstwo = splitnext.split("-", 3);
															String lect = partstwo[0];
															String lab = partstwo[1];
															String self = partstwo[2];

															int lect_of_hour = Integer.parseInt(lect);
															int lab_of_hour = Integer.parseInt(lab);
															
															// หาจำนวน section lect ที่ สอนในวิชานั้น
															if(courseName.equalsIgnoreCase("Senior Project 2") 
																	|| courseName.equalsIgnoreCase("Co-operative Education") 
																	|| courseName.equalsIgnoreCase("Senior Project 1")){
																
															}else{
															if (lect_of_hour == 0) {
															
																//out.print(lect_of_hour);
															} else {

																
																
																
																stmt = con.createStatement();
																String qOfLec = "SELECT * FROM section inner join candidate inner join currentcourse inner join course where userID = '"
																		+ userID
																		+ "' and currentcourse.courseCode = course.courseCode and section.currentcourseID = currentcourse.currentcourseID and currentcourse.year = '"
																		+ Syear
																		+ "' and currentcourse.semester = '"
																		+ Sterm
																		+ "' and  section.sectionID = candidate.sectionID and candidate.teachtype = 'Lect' and currentcourse.courseCode = '"
																		+ courseCode
																		+ "'  group by section.sectionlect   ";
																ResultSet rsOfLec = stmt.executeQuery(qOfLec);
																rsOfLec.last();
																of_lec = rsOfLec.getRow();
																System.out.print(of_lec);
																//of_lec = rsOfLec.getInt("rowcount");
																//out.print(of_lec);
																

															}
															}
															
															// หาจำนวน อ. ท่ีสอนใน Lect นั้น
															stmt = con.createStatement();
															String qOfLectures = "SELECT * FROM section inner join candidate inner join currentcourse inner join course where currentcourse.courseCode = course.courseCode and section.currentcourseID = currentcourse.currentcourseID and currentcourse.year = '"
																	+ Syear
																	+ "' and currentcourse.semester = '"
																	+ Sterm
																	+ "' and  section.sectionID = candidate.sectionID and candidate.teachtype = 'Lect' and currentcourse.courseCode = '"
																	+ courseCode
																	+ "' and candidate.userID = '"
																	+ userID
																	+ "' group by candidate.userID ";
															ResultSet rsOfLectures = stmt.executeQuery(qOfLectures);

															rsOfLectures.last();
															of_lecturers = rsOfLectures.getRow();
															//out.print(of_lecturers);
															
															
															if(courseName.equalsIgnoreCase("Senior Project 2") 
																	|| courseName.equalsIgnoreCase("Co-operative Education") 
																	|| courseName.equalsIgnoreCase("Senior Project 1")){
																
																
															}else{
															
															if (lab_of_hour == 0) {
																//out.print(lab_of_hour);
															} else {

																stmt = con.createStatement();
																String qOfLec = "SELECT COUNT(*) AS rowcount FROM section inner join candidate inner join currentcourse inner join course where userID = '"
																		+ userID
																		+ "' and currentcourse.courseCode = course.courseCode and section.currentcourseID = currentcourse.currentcourseID and currentcourse.year = '"
																		+ Syear
																		+ "' and currentcourse.semester = '"
																		+ Sterm
																		+ "' and  section.sectionID = candidate.sectionID and candidate.teachtype = 'Lab' and currentcourse.courseCode = '"
																		+ courseCode + "'  ";
																ResultSet rsOfLec = stmt.executeQuery(qOfLec);

																rsOfLec.next();
																of_lab = rsOfLec.getInt("rowcount");
																//out.print(of_lab);

																

															}
															}
															stmt = con.createStatement();
															String qcheckType = "select * from user where userID = '"
																	+ userID + "' ";
															String userType = null;
															ResultSet rsCheckType = stmt.executeQuery(qcheckType);
															while (rsCheckType.next()) {
																userType = rsCheckType.getString("usertype");
															}

															if (userType.equals("Teacher")) {
																// หาจำนวน อ. ท่ีสอนใน Lab นั้น
																stmt = con.createStatement();
																String qOfLecturesLab = "SELECT * FROM section inner join candidate inner join currentcourse inner join course inner join user where currentcourse.courseCode = course.courseCode and section.currentcourseID = currentcourse.currentcourseID and currentcourse.year = '"
																		+ Syear
																		+ "' and currentcourse.semester = '"
																		+ Sterm
																		+ "' and  section.sectionID = candidate.sectionID  and candidate.teachtype = 'Lab' and currentcourse.courseCode = '"
																		+ courseCode
																		+ "' and user.usertype = 'Teacher' and candidate.userID = '"
																		+ userID + "' group by candidate.userID;  ";
																ResultSet rsOfLec = stmt.executeQuery(qOfLecturesLab);
																rsOfLec.last();
																of_lablecturers = rsOfLec.getRow();
																while (rsOfLec.next()) {
																	String a = rsOfLec
																			.getString("currentcourse.courseCode");

																}

																//out.print(of_lablecturers);

															} else if (userType.equals("Teaching Assistance")) {
																// หาจำนวน อ. ท่ีสอนใน Lab นั้น
																stmt = con.createStatement();
																String qOfLecturesLab = "SELECT * FROM section inner join candidate inner join currentcourse inner join course inner join user where currentcourse.courseCode = course.courseCode and section.currentcourseID = currentcourse.currentcourseID and currentcourse.year = '"
																		+ Syear
																		+ "' and currentcourse.semester = '"
																		+ Sterm
																		+ "' and  section.sectionID = candidate.sectionID  and candidate.teachtype = 'Lab' and currentcourse.courseCode = '"
																		+ courseCode
																		+ "' and user.usertype = 'Teaching Assistance' and candidate.userID = '"
																		+ userID + "'  group by candidate.userID;  ";
																ResultSet rsOfLec = stmt.executeQuery(qOfLecturesLab);
																rsOfLec.last();
																of_lablecturers = rsOfLec.getRow();
																while (rsOfLec.next()) {
																	String a = rsOfLec
																			.getString("currentcourse.courseCode");

																}

																//out.print(of_lablecturers);

															}
															
															// Count the same course
															String courseStack = null;
															int count = 0;
															stmt = con.createStatement();
															String findthecourse = "SELECT * FROM section inner join candidate inner join currentcourse inner join course where userID = '"
																	+ userID
																	+ "' and currentcourse.courseCode = course.courseCode and section.currentcourseID = currentcourse.currentcourseID and currentcourse.year = '"
																	+ Syear
																	+ "' and currentcourse.semester = '"
																	+ Sterm
																	+ "' and  section.sectionID = candidate.sectionID and candidate.teachtype = 'Lect'and currentcourse.courseCode = '"
																	+ courseCode + "' group by section.sectionlect ;";
															ResultSet rsfindCourse = stmt.executeQuery(findthecourse);
															while (rsfindCourse.next()) {
																courseStack = rsfindCourse.getString("course.courseName");
																count++;
															}
															try {
																int keepStack = count;
																double workloadNormal = 0;
																double workloadLectSum = 0;
																double Sumworkload = 0;
																double workloadLab = 0;

																// IF LECT AND LAB HAVE LECTURERS
																if (of_lecturers != 0 && of_lablecturers != 0) {
																	// For lecture

																	if (keepStack > 1) {
																		workloadNormal = (of_lec * lect_of_hour)
																				/ of_lecturers;

																		int keepExtra = keepStack - 1;
																		double workloadExtra = 0;
																		for (int i = 0; i < keepExtra; i++) {
																			double wle = (of_lec * lect_of_hour * 0.75)
																					/ of_lecturers;

																			workloadExtra = workloadExtra + wle;
																		}
																		workloadLectSum = workloadExtra + workloadNormal;

																	} else {
																		workloadLectSum = (of_lec * lect_of_hour)
																				/ of_lecturers;
																	}

																	// Cal Lab wl
																	workloadLab = (of_lab * lab_of_hour * 0.5)
																			/ of_lablecturers;

																	Sumworkload = workloadLab + workloadLectSum;

																	String finalResult = String.format("%.2f", Sumworkload);
																	//out.print(finalResult);

																	// IF LECT NOT HAVE LECTURERS BUT LAB HAVE LECTURERS
																} else if (of_lecturers == 0 && of_lablecturers != 0) {
																	// Cal Lab wl
																	workloadLab = (of_lab * lab_of_hour * 0.5)
																			/ of_lablecturers;

																	Sumworkload = workloadLab + workloadLectSum;

																	String finalResult = String.format("%.2f", Sumworkload);
																	//out.print(finalResult);

																}// IF LECT HAVE LECTURERS BUT LAB NOT HAVE
																else if (of_lecturers != 0 && of_lablecturers == 0) {
																	// For lecture

																	if (keepStack > 1) {
																		workloadNormal = (of_lec * lect_of_hour)
																				/ of_lecturers;

																		int keepExtra = keepStack - 1;
																		double workloadExtra = 0;
																		for (int i = 0; i < keepExtra; i++) {
																			double wle = (of_lec * lect_of_hour * 0.75)
																					/ of_lecturers;

																			workloadExtra = workloadExtra + wle;
																		}
																		workloadLectSum = workloadExtra + workloadNormal;

																	} else {
																		workloadLectSum = (of_lec * lect_of_hour)
																				/ of_lecturers;
																	}

																	Sumworkload = workloadLab + workloadLectSum;

																	String finalResult = String.format("%.2f", Sumworkload);
																	//out.print(finalResult);
																}
																// IF LECT AND LAB NOT CALCULATE
																else if (of_lecturers == 0 && of_lablecturers == 0) {
																	Sumworkload = workloadLab + workloadLectSum;

																	String finalResult = String.format("%.2f", Sumworkload);
																	//out.print(finalResult);

																}
																			listResult2.add(Sumworkload);
															} catch (ArithmeticException e) {
																out.print(e);
															} catch (NumberFormatException e) {
																out.print(e);
															} catch (Exception e) {
																out.print(e);
															}
														}}
													
													double totalResult2 = 0 ;
													for(int i = 0; i<listResult2.size(); i++)
													  {
														totalResult2 = totalResult2 + listResult2.get(i);
														}
													String finalResult = String.format("%.2f", totalResult2);
													out.print(finalResult);
													%>
													
													</td>
													
													<td>
													<% 
													stmt = con.createStatement();
													String qWorkload = "SELECT * FROM workload where userID = '"+userID+"' and year = '"+Syear+"' and semester = '"+Sterm+"' "; 
													ResultSet rswl = stmt.executeQuery(qWorkload);
													
													while(rswl.next()){
														String status = rswl.getString("status");
														
														if(status.equals("confirm")){%>
														
															<span class="label label-info">Confirm</span>
														<% }else if(status.equals("reject")){%>
													
													<span class="label label-warning">Reject</span>
													<% 	
													}}
													%>
													
													
													 </td>
													<td><% 
													stmt = con.createStatement();
													String qWorkload2 = "SELECT * FROM workload where userID = '"+userID+"' and year = '"+Sterm+"' and semester = '"+Syear+"' "; 
													ResultSet rswl2 = stmt.executeQuery(qWorkload);
													String comment = null;
													while(rswl2.next()){
														comment = rswl2.getString("comment");
														
														if(comment.equals("null")){
															out.print("-");
														%>
														
															
														<% }else {
															out.print(comment);
														%>
													
													
													<% 	
													}}
													%></td>
													<td><a class="btn btn-success btn-setting"
												href="Admin_Candidate_Workload_Detail.jsp?userID=<%out.print(rsUser.getString("user.userID"));%>&&year=<%=Syear%>&&term=<%=Sterm%>"
												data-toggle="modal"
												onClick="NewWindow(this.href,'name','800','600','yes');return false">
													<i class="glyphicon glyphicon-zoom-in icon-white"></i> View
											</a></td>
												
												
											</tbody>
											<%} %>
										</table>
									</div>
								</div>
							</div>
							<!--/span-->

						</div>
						<!--/row-->

						<!-- content ends -->
					</div>
					<!--/#content.col-md-0-->
				</div>
				
					
			
				<!--/fluid-row-->

				<div class="row">
					<div class="box col-md-12">
						<div class="row">
							<div class="box col-md-12">
								<div class="box-inner">
									<div class="box-header well" data-original-title="">
										<h2>
											<i class="glyphicon glyphicon-list-alt"></i>&nbsp;&nbsp;List
											Course (Not Candidate)
										</h2>
										<div class="box-icon">
											<a href="#settingfornotcandidate"
												class="btn btn-setting btn-round btn-default"
												data-toggle="modal"><i class="glyphicon glyphicon-cog"></i></a>
											<a href="#" class="btn btn-minimize btn-round btn-default"><i
												class="glyphicon glyphicon-chevron-up"></i></a> <a href="#"
												class="btn btn-close btn-round btn-default"><i
												class="glyphicon glyphicon-remove"></i></a>
										</div>
									</div>
									<div class="box-content">
										<p>
											<button class="btn btn-success sendduplicate">
												<i class="glyphicon glyphicon-repeat"></i> Duplicate
											</button>
										</p>
										<table
											class="table table-striped table-bordered bootstrap-datatable datatable responsive">

											<%
												String strdateterm1_1 = "";
												String strdateterm1_2 = "";
												String strdateterm2_1 = "";
												String strdateterm2_2 = "";

												String academicyear = null;
												String academicterm = null;

												if (null == (String) session.getAttribute("NotCandidateYear")) {

													Date td = new Date();
													String strtd = new String("");
													SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
													SimpleDateFormat format2 = new SimpleDateFormat("yyyy-MM-dd",
															new Locale("th"));
													strtd = format.format(td);
													Date today = format.parse(strtd);
													//System.out.println(today);

													/* String[] datetd = strtd.split("-", 3);
													int ydatetd = Integer.parseInt(datetd[0]);
													int mdatetd = Integer.parseInt(datetd[1]);
													int ddatetd = Integer.parseInt(datetd[2]); */

													stmt = con.createStatement();
													String QueryString = "SELECT * FROM setsemesterdate WHERE setsemesterdate_ID = '1'";
													ResultSet rs = stmt.executeQuery(QueryString);
													if (rs.next()) {
														strdateterm1_1 = rs.getString("dateterm1_1");
														strdateterm1_2 = rs.getString("dateterm1_2");
														strdateterm2_1 = rs.getString("dateterm2_1");
														strdateterm2_2 = rs.getString("dateterm2_2");

														Date dateterm1_1 = format2.parse(strdateterm1_1);
														Date dateterm1_2 = format2.parse(strdateterm1_2);
														Date dateterm2_1 = format2.parse(strdateterm2_1);
														Date dateterm2_2 = format2.parse(strdateterm2_2);

														String[] term1_1 = strdateterm1_1.split("-", 3);
														int yterm1_1 = 543 + Integer.parseInt(term1_1[0]);
														int mterm1_1 = Integer.parseInt(term1_1[1]);
														int dterm1_1 = Integer.parseInt(term1_1[2]);

														int intacademicyear = yterm1_1;
														academicyear = Integer.toString(intacademicyear);

														/* System.out.println(dateterm1_1);
														System.out.println(dateterm1_2);
														System.out.println(dateterm2_1);
														System.out.println(dateterm2_2); */

														if ((today.before(dateterm1_2) || today.equals(dateterm1_2))
																&& (today.after(dateterm1_1) || today
																		.equals(dateterm1_1))) {
															academicterm = "1";
														} else if ((today.before(dateterm2_2) || today
																.equals(dateterm2_2))
																&& (today.after(dateterm2_1) || today
																		.equals(dateterm2_1))) {
															academicterm = "2";
														} else {
															academicyear = "";
															academicterm = "";
														}
													}

													session.setAttribute("academicyear", academicyear);
													session.setAttribute("academicterm", academicterm);
											%>

											<p>
												<b><i>Year : <%=academicyear%> Term : <%=academicterm%></i></b>
											</p>
											<%
												} else {
											%>

											<p>
												<b><i>Year : <%=(String) session.getAttribute("NotCandidateYear")%>
														Term : <%=(String) session.getAttribute("NotCandidateTerm")%></i></b>
											</p>

											<%
												}
											%>

											<thead>
												<tr>
													<th>Duplicate</th>
													<th>Course Code</th>
													<th>Course Name</th>
													<th>Credit</th>
													<th>Major</th>
													<th>Number student</th>
													<th>Lect</th>
													<th>Select Teacher</th>
													<th>Lab</th>
													<th>Select Teacher</th>
													<th>Actions</th>
												</tr>
											</thead>
											<tbody>
												<%
													String year = "";
													String term = "";
													if (null == (String) session.getAttribute("NotCandidateYear")) {
														year = (String) session.getAttribute("academicyear");
														term = (String) session.getAttribute("academicterm");
													} else if (null != (String) session
															.getAttribute("NotCandidateYear")) {
														year = (String) session.getAttribute("NotCandidateYear");
														term = (String) session.getAttribute("NotCandidateTerm");
													} else {
														year = null;
														term = null;
													}

													stmt = con.createStatement();
													String QueryString = "SELECT * FROM courseplan LEFT JOIN course ON course.courseCode = courseplan.courseCode WHERE courseplan.year = '"
															+ year
															+ "' AND courseplan.semester = '"
															+ term
															+ "' ORDER BY courseplan.courseCode;";
													ResultSet rs = stmt.executeQuery(QueryString);

													int count = 0;
													while (rs.next()) {
														// count length
														stmt = con.createStatement();
														String QueryString2 = "SELECT * FROM course_survey INNER JOIN user ON course_survey.UserID = user.UserID INNER JOIN courseplan ON course_survey.courseCode = courseplan.courseCode WHERE courseplan.courseCode = '"
																+ rs.getString("courseplan.courseCode")
																+ "' AND course_survey.year = '"
																+ year
																+ "' AND course_survey.semester ='"
																+ term
																+ "' GROUP BY user.userID";
														ResultSet rs2 = stmt.executeQuery(QueryString2);
														rs2.last();
														int length = rs2.getRow();
														//System.out.println(length);
														// get user firstname
														stmt = con.createStatement();
														String[] arrayusername = new String[length];
														String QueryString3 = "SELECT * FROM course_survey INNER JOIN user ON course_survey.UserID = user.UserID INNER JOIN courseplan ON course_survey.courseCode = courseplan.courseCode WHERE courseplan.courseCode = '"
																+ rs.getString("courseplan.courseCode")
																+ "' AND course_survey.year = '"
																+ year
																+ "' AND course_survey.semester ='"
																+ term
																+ "' GROUP BY user.userID";
														ResultSet rs3 = stmt.executeQuery(QueryString3);
														int length2 = 0;
														while (rs3.next()) {
															arrayusername[length2] = rs3.getString("user.firstname")
																	+ " " + rs3.getString("user.lastname");
															length2++;
														}
												%>
												<tr>
													<td><input type="checkbox" class="checkbox"
														name="surveyid"
														value="<%=rs.getString("courseplan.courseplanID")%>"
														form="copyForm"></td>
													<td>
														<%
															out.print(rs.getString("course.courseCode"));
														%> <input type="hidden" name="coursecode_<%=count%>"
														value="<%=rs.getString("course.courseCode")%>"
														form="savecandidate" /> <input type="hidden"
														name="checkyear" id="checkyear" value="<%=year%>"
														form="savecandidate" /> <input type="hidden"
														name="checkterm" id="checkterm" value="<%=term%>"
														form="savecandidate" />
													</td>
													<td>
														<%
															out.print(rs.getString("course.courseName"));
														%>
													</td>
													<td>
														<%
															out.print(rs.getString("course.credit"));
														%>
													</td>
													<td>
														<p id="inputformajor">
															<input type="text" id="major" name="major_<%=count%>"
																value="<%=rs.getString("courseplan.major")%>"
																form="savecandidate" />
														</p>
													</td>
													<td><p id="inputforstudentnumber">
															<input type="text" id="numstudent"
																name="numstudent_<%=count%>"
																value="<%=rs.getString("courseplan.numberofstudent")%>"
																form="savecandidate" />
														</p></td>
													<td><p id="inputforlect">
															<input type="text" id="lect" name="lect_<%=count%>"
																form="savecandidate" />
														</p></td>
													<td><select name="selectlect_<%=count%>"
														id="selectError1" multiple class="form-control"
														data-rel="chosen" form="savecandidate">
															<optgroup label="From Survey">
																<%
																	for (int i = 0; i < arrayusername.length; i++) {
																%>
																<option><%=arrayusername[i]%></option>
																<%
																	}
																%>
															</optgroup>
															<optgroup label="From Teacher">
																<%
																	for (int i = 0; i < arrayTeacher.length; i++) {
																%>
																<option><%=arrayTeacher[i]%></option>
																<%
																	}
																%>
															</optgroup>
															<optgroup label="From TA">
																<%
																	for (int i = 0; i < arrayTa.length; i++) {
																%>
																<option><%=arrayTa[i]%></option>
																<%
																	}
																%>
															</optgroup>
													</select></td>
													<td><p id="inputforlab">
															<input type="text" id="lab" name="lab_<%=count%>"
																form="savecandidate" />
														</p></td>
													<td><select name="selectlab_<%=count%>"
														id="selectlab_<%=count%>" multiple class="form-control"
														data-rel="chosen" form="savecandidate">
															<optgroup label="From Surey">
																<%
																	for (int i = 0; i < arrayusername.length; i++) {
																%>
																<option><%=arrayusername[i]%></option>
																<%
																	}
																%>
															</optgroup>
															<optgroup label="From Teacher">
																<%
																	for (int i = 0; i < arrayTeacher.length; i++) {
																%>
																<option><%=arrayTeacher[i]%></option>
																<%
																	}
																%>
															</optgroup>
															<optgroup label="From TA">
																<%
																	for (int i = 0; i < arrayTa.length; i++) {
																%>
																<option><%=arrayTa[i]%></option>
																<%
																	}
																%>
															</optgroup>
													</select></td>
													<td></td>
												</tr>
												<%
													count++;
													}

													stmt = con.createStatement();
													String Queryfake = "SELECT * FROM notcandidate LEFT JOIN course ON course.courseCode = notcandidate.courseCode WHERE notcandidate.year = '"
															+ year + "' AND notcandidate.semester = '" + term + "' ";
													ResultSet rsfake = stmt.executeQuery(Queryfake);
													int countfake = 0;
													while (rsfake.next()) {
														stmt = con.createStatement();
														String Queryfake2 = "SELECT * FROM course_survey INNER JOIN user ON course_survey.UserID = user.UserID INNER JOIN notcandidate ON course_survey.courseCode = notcandidate.courseCode WHERE notcandidate.courseCode = '"
																+ rsfake.getString("notcandidate.courseCode")
																+ "' AND course_survey.year = '"
																+ year
																+ "' AND course_survey.semester ='"
																+ term
																+ "' GROUP BY user.userID";
														ResultSet rsfake2 = stmt.executeQuery(Queryfake2);
														rsfake2.last();
														int lengthfake = rsfake2.getRow();
														//System.out.println(lengthfake);
														stmt = con.createStatement();
														String[] arrayusername = new String[lengthfake];
														String Queryfake3 = "SELECT * FROM course_survey INNER JOIN user ON course_survey.UserID = user.UserID INNER JOIN notcandidate ON course_survey.courseCode = notcandidate.courseCode WHERE notcandidate.courseCode = '"
																+ rsfake.getString("notcandidate.courseCode")
																+ "' AND course_survey.year = '"
																+ year
																+ "' AND course_survey.semester ='"
																+ term
																+ "' GROUP BY user.userID";
														ResultSet rsfake3 = stmt.executeQuery(Queryfake3);
														int lengthfake2 = 0;
														while (rsfake3.next()) {
															arrayusername[lengthfake2] = rsfake3
																	.getString("user.firstname")
																	+ " "
																	+ rsfake3.getString("user.lastname");
															lengthfake2++;
														}
												%>
												<tr>
													<td><input type="hidden" name="surveyid"
														value="<%=rsfake.getString("notcandidate.notcandidateID")%>"></td>
													<td>
														<%
															out.print(rsfake.getString("course.courseCode"));
														%> <input type="hidden" name="coursecode2_<%=countfake%>"
														value="<%=rsfake.getString("course.courseCode")%>"
														form="savecandidate" />
													</td>
													<td>
														<%
															out.print(rsfake.getString("course.courseName"));
														%>
													</td>
													<td>
														<%
															out.print(rsfake.getString("course.credit"));
														%>
													</td>
													<td>
														<p id="inputformajor">
															<input type="text" id="major2"
																name="major2_<%=countfake%>"
																value="<%=rsfake.getString("notcandidate.major")%>"
																form="savecandidate" />
														</p>
													</td>
													<td><p id="inputforstudentnumber">
															<input type="text" id="numstudent2"
																name="numstudent2_<%=countfake%>"
																value="<%=rsfake.getString("notcandidate.numberofstudent")%>"
																form="savecandidate" />
														</p></td>
													<td><p id="inputforlect">
															<input type="text" id="lect2" name="lect2_<%=countfake%>"
																form="savecandidate" />
														</p></td>
													<td><select name="selectlect2_<%=countfake%>"
														id="selectError1" multiple class="form-control"
														data-rel="chosen" form="savecandidate">
															<optgroup label="From Survey">
																<%
																	for (int i = 0; i < arrayusername.length; i++) {
																%>
																<option><%=arrayusername[i]%></option>
																<%
																	}
																%>
															</optgroup>
															<optgroup label="From Teacher">
																<%
																	for (int i = 0; i < arrayTeacher.length; i++) {
																%>
																<option><%=arrayTeacher[i]%></option>
																<%
																	}
																%>
															</optgroup>
															<optgroup label="From TA">
																<%
																	for (int i = 0; i < arrayTa.length; i++) {
																%>
																<option><%=arrayTa[i]%></option>
																<%
																	}
																%>
															</optgroup>
													</select></td>
													<td><p id="inputforlab">
															<input type="text" id="lab2" name="lab2_<%=countfake%>"
																form="savecandidate" />
														</p></td>
													<td><select name="selectlab2_<%=countfake%>"
														id="selectError2" multiple class="form-control"
														data-rel="chosen" form="savecandidate">
															<optgroup label="From Surey">
																<%
																	for (int i = 0; i < arrayusername.length; i++) {
																%>
																<option><%=arrayusername[i]%></option>
																<%
																	}
																%>
															</optgroup>
															<optgroup label="From Teacher">
																<%
																	for (int i = 0; i < arrayTeacher.length; i++) {
																%>
																<option><%=arrayTeacher[i]%></option>
																<%
																	}
																%>
															</optgroup>
															<optgroup label="From TA">
																<%
																	for (int i = 0; i < arrayTa.length; i++) {
																%>
																<option><%=arrayTa[i]%></option>
																<%
																	}
																%>
															</optgroup>
													</select></td>
													<td><a class="btn btn-danger confirmation"
														href="Admin_Candidate_Duplicate_Delete.jsp?deleteid=<%=rsfake.getString("notcandidate.notcandidateID")%>">
															<i class="glyphicon glyphicon-trash icon-white"></i>
															Delete
													</a><input type="hidden" name="deletefake"
														value="<%=rsfake.getString("notcandidate.notcandidateID")%>"
														form="savecandidate" /></td>
												</tr>
												<%
													countfake++;
													}
												%>
											</tbody>
										</table>
										<div align="center">
											<input type="hidden" name=totalcount value="<%=count%>"
												form="savecandidate" /> <input type="hidden"
												name=totalcount2 value="<%=countfake%>" form="savecandidate" />
											<button class="btn btn-success savecandidatebtn"
												id="savecandidatebtn" onclick="savecourse()">
												<i class="glyphicon glyphicon-check"></i> Save
											</button>
											<br> <br>
										</div>
									</div>
								</div>
							</div>
							<form id="savecandidate" class="savecandidate" method="post"
								action="Admin_Candidate_SaveCandidate.jsp"></form>

							<!-- <script>
								$(function() {
									//twitter bootstrap script
									$("button#savecandidatebtn")
											.click(
													function() {
														$
																.ajax({
																	type : "POST",
																	url : "Admin_Candidate_SaveCandidate.jsp",
																	data : $(
																			'form.savecandidate')
																			.serialize(),
																	success : function(
																			msg) {
																		alert("Pass");
																	},
																	error : function() {
																		alert("Error something went wrong");
																	}
																});
													});
								});
							</script> -->

							<script type="text/javascript">
								function savecourse() {
									var checkyear = document
											.getElementById("checkyear");
									var checkterm = document
											.getElementById("checkterm");
									if (!checkyear || !checkterm) {
										swal("Select Year and Semester First.");
									} else {
										document.forms['savecandidate']
												.submit()
									}

								}
							</script>

							<!--/span-->
							<form id="copyForm" method="post"
								action="Admin_Candidate_Duplicate.jsp"></form>
							<script>
								// Code below come from this.
								/* http://jsfiddle.net/webwarrior/NJwv4/9/ */
								var allunchecked = true;

								$(".sendduplicate")
										.click(
												function() {
													allunchecked = true;
													$(".checkbox")
															.each(
																	function(
																			index) {
																		if ($(
																				this)
																				.prop(
																						"checked")) {
																			allunchecked = false;
																		}
																	});
													if (allunchecked == true) {
														swal("Please select course to duplicate.");
													} else {
														var check = confirm("Are you sure to duplicate?");
														if (check) {
															document.forms['copyForm']
																	.submit()
															return true;
														} else {
															return false;
														}
													}
												});
								//End code below
							</script>

						</div>
						<!--/row-->

						<div class="row">
							<div class="box col-md-12">
								<div class="row">
									<div class="box col-md-12">
										<div class="box-inner">
											<div class="box-header well" data-original-title="">
												<h2>
													<i class="glyphicon glyphicon-list-alt"></i>&nbsp;&nbsp;List
													Course (Candidate)
												</h2>
												<div class="box-icon">
													<a href="#" class="btn btn-minimize btn-round btn-default"><i
														class="glyphicon glyphicon-chevron-up"></i></a> <a href="#"
														class="btn btn-close btn-round btn-default"><i
														class="glyphicon glyphicon-remove"></i></a>
												</div>
											</div>
											<div class="box-content">
												<table
													class="table table-striped table-bordered bootstrap-datatable datatable responsive">

													<%
														if (null == (String) session.getAttribute("NotCandidateYear")) {
													%>

													<p>
														<b><i>Year : <%=academicyear%> Term : <%=academicterm%></i></b>
													</p>
													<%
														} else {
													%>

													<p>
														<b><i>Year : <%=(String) session.getAttribute("NotCandidateYear")%>
																Term : <%=(String) session.getAttribute("NotCandidateTerm")%></i></b>
													</p>

													<%
														}
													%>

													<thead>
														<tr>
															<th>Course Code</th>
															<th>Course Name</th>
															<th>Credit</th>
															<th>Major</th>
															<th>Number student</th>
															<th>Lect</th>
															<th>Lab</th>
															<th>Actions</th>
														</tr>
													</thead>
													<tbody>
														<%
															stmt = con.createStatement();
															String QueryCandidateLength = "SELECT * FROM currentcourse INNER JOIN course ON currentcourse.courseCode = course.courseCode INNER JOIN section ON currentcourse.currentcourseID = section.currentcourseID INNER JOIN candidate ON section.sectionID = candidate.sectionID WHERE currentcourse.year = '"
																	+ year + "' AND currentcourse.semester = '" + term + "'";
															ResultSet rscandidatelength = stmt
																	.executeQuery(QueryCandidateLength);
															rscandidatelength.last();
															int candidatelength = rscandidatelength.getRow();
															String QueryCandidate = "SELECT * FROM currentcourse INNER JOIN course ON currentcourse.courseCode = course.courseCode INNER JOIN section ON currentcourse.currentcourseID = section.currentcourseID WHERE currentcourse.year = '"
																	+ year
																	+ "' AND currentcourse.semester = '"
																	+ term
																	+ "' GROUP BY section.sectionID;";
															ResultSet rscandidate = stmt.executeQuery(QueryCandidate);
															String sectionid[] = new String[candidatelength];
															while (rscandidate.next()) {
														%>
														<tr>
															<td>
																<%
																	out.print(rscandidate.getString("currentcourse.courseCode"));
																%>
															</td>
															<td>
																<%
																	out.print(rscandidate.getString("course.courseName"));
																%>
															</td>
															<td>
																<%
																	out.print(rscandidate.getString("course.credit"));
																%>
															</td>
															<td>
																<%
																	out.print(rscandidate.getString("section.major"));
																%>
															</td>
															<td>
																<%
																	out.print(rscandidate.getString("section.numberofstudent"));
																%>
															</td>
															<td>
																<%
																	out.print(rscandidate.getString("section.sectionlect"));
																%>
															</td>
															<td>
																<%
																	out.print(rscandidate.getString("section.sectionlab"));
																%>
															</td>
															<td><a class="btn btn btn-success btn-setting"
																onClick="NewWindow(this.href,'name','800','600','yes');return false"
																href="Admin_Candidate_ShowCandidate.jsp?year=<%=year%>&term=<%=term%>&sectionid=<%=rscandidate.getString("section.sectionID")%>&coursecode=<%=rscandidate.getString("currentcourse.courseCode")%>&coursename=<%=rscandidate.getString("course.courseName")%>&lect=<%=rscandidate.getString("section.sectionlect")%>&lab=<%=rscandidate.getString("section.sectionlab")%>"
																data-toggle="modal"> <i
																	class="glyphicon glyphicon-zoom-in icon-white"></i>
																	View
															</a> <a class="btn btn-danger confirmation"
																href="Admin_Candidate_DeleteCandidate.jsp?del=<%=rscandidate.getString("section.sectionID")%>">
																	<i class="glyphicon glyphicon-trash icon-white"></i>
																	Delete
															</a></td>
														</tr>
														<%
															}
														%>
													</tbody>
												</table>
											</div>
										</div>
									</div>
									<!--/span-->
									<script type="text/javascript">
										var win = null;

										function NewWindow(mypage, myname, w,
												h, scroll) {
											LeftPosition = (screen.width) ? (screen.width - w) / 2
													: 0;
											TopPosition = (screen.height) ? (screen.height - h) / 2
													: 0;
											settings = 'height=' + h
													+ ',width=' + w + ',top='
													+ TopPosition + ',left='
													+ LeftPosition
													+ ',scrollbars=' + scroll
													+ ',resizable'
											win = window.open(mypage, myname,
													settings)
										}
									</script>
									<script type="text/javascript">
										var elems = document
												.getElementsByClassName('confirmation');
										var confirmIt = function(e) {
											if (!confirm('Are you sure to delete?'))
												e.preventDefault();
										};
										for (var i = 0, l = elems.length; i < l; i++) {
											elems[i].addEventListener('click',
													confirmIt, false);
										}
									</script>
								</div>
								<!--/row-->

								<div class="row">
									<div class="box col-md-12">
										<div class="row">
											<div class="box col-md-12">
												<div class="box-inner">
													<div class="box-header well" data-original-title="">
														<h2>
															<i class="glyphicon glyphicon-list-alt"></i>&nbsp;&nbsp;Select
															Course Co-ordinator
														</h2>
														<div class="box-icon">
															<a href="#"
																class="btn btn-minimize btn-round btn-default"><i
																class="glyphicon glyphicon-chevron-up"></i></a> <a href="#"
																class="btn btn-close btn-round btn-default"><i
																class="glyphicon glyphicon-remove"></i></a>
														</div>
													</div>
													<div class="box-content">
														<table
															class="table table-striped table-bordered bootstrap-datatable datatable responsive">

															<%
																if (null == (String) session.getAttribute("NotCandidateYear")) {
															%>

															<p>
																<b><i>Year : <%=academicyear%> Term : <%=academicterm%></i></b>
															</p>
															<%
																} else {
															%>

															<p>
																<b><i>Year : <%=(String) session.getAttribute("NotCandidateYear")%>
																		Term : <%=(String) session.getAttribute("NotCandidateTerm")%></i></b>
															</p>

															<%
																}
															%>

															<thead>
																<tr>
																	<th>Course Code</th>
																	<th>Course Name</th>
																	<th>Credit</th>
																	<th>Actions</th>
																</tr>
															</thead>
															<tbody>
																<%
																	stmt = con.createStatement();
																	String QueryCurrentcourse = "SELECT * FROM currentcourse INNER JOIN course on currentcourse.courseCode = course.courseCode WHERE currentcourse.year = '"
																			+ year + "' AND currentcourse.semester = '" + term + "'";
																	ResultSet rscurrentcourse = stmt.executeQuery(QueryCurrentcourse);
																	while (rscurrentcourse.next()) {
																%>
																<tr>
																	<td>
																		<%
																			out.println(rscurrentcourse
																						.getString("currentcourse.courseCode"));
																		%>
																	</td>
																	<td>
																		<%
																			out.println(rscurrentcourse.getString("course.courseName"));
																		%>
																	</td>
																	<td>
																		<%
																			out.println(rscurrentcourse.getString("course.credit"));
																		%>
																	</td>
																	<td><a class="btn btn btn-success btn-setting"
																		onClick="NewWindowforcoview(this.href,'name','800','300','yes');return false"
																		href="Admin_Candidate_ViewCourseCo.jsp?year=<%=year%>&term=<%=term%>&coursecode=<%=rscurrentcourse.getString("currentcourse.courseCode")%>"
																		data-toggle="modal"> <i
																			class="glyphicon glyphicon-zoom-in icon-white"></i>
																			View
																	</a> <a class="btn btn-success"
																		onClick="NewWindowforcoselect(this.href,'name','600','400','yes');return false"
																		href="Admin_Candidate_SelectCourseCo.jsp?year=<%=year%>&term=<%=term%>&coursecode=<%=rscurrentcourse.getString("currentcourse.courseCode")%>">
																			<i class="glyphicon glyphicon-user icon-white"></i>
																			Select
																	</a></td>
																</tr>
																<%
																	}
																%>
															</tbody>
														</table>
													</div>
												</div>
											</div>
											<!--/span-->

											<script type="text/javascript">
												var win = null;

												function NewWindowforcoselect(
														mypage, myname, w, h,
														scroll) {
													LeftPosition = (screen.width) ? (screen.width - w) / 2
															: 0;
													TopPosition = (screen.height) ? (screen.height - h) / 2
															: 0;
													settings = 'height=' + h
															+ ',width=' + w
															+ ',top='
															+ TopPosition
															+ ',left='
															+ LeftPosition
															+ ',scrollbars='
															+ scroll
															+ ',resizable'
													win = window.open(mypage,
															myname, settings)
												}
											</script>

											<script type="text/javascript">
												var win = null;

												function NewWindowforcoview(
														mypage, myname, w, h,
														scroll) {
													LeftPosition = (screen.width) ? (screen.width - w) / 2
															: 0;
													TopPosition = (screen.height) ? (screen.height - h) / 2
															: 0;
													settings = 'height=' + h
															+ ',width=' + w
															+ ',top='
															+ TopPosition
															+ ',left='
															+ LeftPosition
															+ ',scrollbars='
															+ scroll
															+ ',resizable'
													win = window.open(mypage,
															myname, settings)
												}
											</script>

										</div>
										<!--/row-->

										<!-- content ends -->
									</div>
									<!--/#content.col-md-0-->
								</div>
								<!--/fluid-row-->

								<script type="text/javascript">
									function sendnotcandidatesetting() {
										document.getElementById(
												"setnotcandidateform").submit();
									}
								</script>

								<hr>
								<div class="modal fade" id="settingforworkload"
				tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
				aria-hidden="true">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal">×</button>
							<h3>Setting Workload Year</h3>
						</div>
						<div class="modal-body">
							<form method="post"
								action="Admin_Workload_SetYear.jsp"
								role="setyeartermform" id="setyeartermform">
								<label for="Year">Year</label> <select id="workloadyear"
									name="workloadyear">
									<script>
										var myDate = new Date();
										var year = myDate.getFullYear() + 543;
										for (var i = year + 1; i > 2540; i--) {
											document
													.write('<option value="'+i+'">'
															+ i + '</option>');
										}
									</script>
								</select> <label for="Term">Term</label> <select id="workloadterm"
									name="workloadterm">
									<option value="1">1</option>
									<option value="2">2</option>
								</select> <br> <a href="#" class="btn btn-default"
									data-dismiss="modal">Close</a> <input type="button"
									class="btn btn-primary" onClick="sendworkloadsetting()"
									value="Submit" />
							</form>
						</div>
						<div class="modal-footer"></div>
					</div>
				</div>
			</div>
			
			<script type="text/javascript">
				function sendworkloadsetting() {
					document.getElementById("setyeartermform").submit();
				}
			</script>
				

<script type="text/javascript">
			var win = null;

			function NewWindow(mypage, myname, w, h, scroll) {
				LeftPosition = (screen.width) ? (screen.width - w) / 2 : 0;
				TopPosition = (screen.height) ? (screen.height - h) / 2 : 0;
				settings = 'height=' + h + ',width=' + w + ',top='
						+ TopPosition + ',left=' + LeftPosition
						+ ',scrollbars=' + scroll + ',resizable'
				win = window.open(mypage, myname, settings)
				
			}
		</script>

								<div class="modal fade" id="settingfornotcandidate"
									tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
									aria-hidden="true">
									<div class="modal-dialog">
										<div class="modal-content">
											<div class="modal-header">
												<button type="button" class="close" data-dismiss="modal">×</button>
												<h3>Setting List Course (Not Candidate)</h3>
											</div>
											<div class="modal-body">
												<form method="post"
													action="Admin_Candidate_SetYearSemester.jsp"
													role="setnotcandidateform" id="setnotcandidateform">
													<label for="Year">Year</label> <select
														id="notcandidateyear" name="notcandidateyear">
														<script>
															var myDate = new Date();
															var year = myDate
																	.getFullYear() + 543;
															for (var i = year + 1; i > 2540; i--) {
																document
																		.write('<option value="'+i+'">'
																				+ i
																				+ '</option>');
															}
														</script>
													</select> <label for="Term">Term</label> <select
														id="notcandidateterm" name="notcandidateterm">
														<option value="1">1</option>
														<option value="2">2</option>
													</select> <br> <a href="#" class="btn btn-default"
														data-dismiss="modal">Close</a> <input type="button"
														class="btn btn-primary"
														onClick="sendnotcandidatesetting()" value="Submit" />
												</form>
											</div>
											<div class="modal-footer"></div>
										</div>
									</div>
								</div>

								<footer class="row">
								<p class="col-md-9 col-sm-9 col-xs-12 copyright">
									© <a href="http://usman.it" target="_blank">Muhammad Usman</a>
									2012 - 2014
								</p>
								<p class="col-md-3 col-sm-3 col-xs-12 powered-by">
									Theme by:<a
										href="http://usman.it/free-responsive-admin-template">Charisma</a>
								</p>
								</footer>
								<!--/.fluid-container-->

								<!-- external javascript -->

								<script
									src="bower_components/bootstrap/dist/js/bootstrap.min.js"></script>

								<!-- library for cookie management -->
								<script src="js/jquery.cookie.js"></script>
								<!-- calender plugin -->
								<script src="bower_components/moment/min/moment.min.js"></script>
								<script
									src="bower_components/fullcalendar/dist/fullcalendar.min.js"></script>
								<!-- data table plugin -->
								<script src="js/jquery.dataTables.min.js"></script>

								<!-- select or dropdown enhancer -->
								<script src="bower_components/chosen/chosen.jquery.min.js"></script>
								<!-- plugin for gallery image view -->
								<script src="bower_components/colorbox/jquery.colorbox-min.js"></script>
								<!-- notification plugin -->
								<script src="js/jquery.noty.js"></script>
								<!-- library for making tables responsive -->
								<script
									src="bower_components/responsive-tables/responsive-tables.js"></script>
								<!-- tour plugin -->
								<script
									src="bower_components/bootstrap-tour/build/js/bootstrap-tour.min.js"></script>
								<!-- star rating plugin -->
								<script src="js/jquery.raty.min.js"></script>
								<!-- for iOS style toggle switch -->
								<script src="js/jquery.iphone.toggle.js"></script>
								<!-- autogrowing textarea plugin -->
								<script src="js/jquery.autogrow-textarea.js"></script>
								<!-- multiple file upload plugin -->
								<script src="js/jquery.uploadify-3.1.min.js"></script>
								<!-- history.js for cross-browser state change on ajax -->
								<script src="js/jquery.history.js"></script>
								<!-- application script for Charisma demo -->
								<script src="js/charisma.js"></script>
								<div style="display: none;" id="cboxOverlay"></div>
								<div style="display: none;" tabindex="-1" role="dialog" class=""
									id="colorbox">
									<div id="cboxWrapper">
										<div>
											<div style="float: left;" id="cboxTopLeft"></div>
											<div style="float: left;" id="cboxTopCenter"></div>
											<div style="float: left;" id="cboxTopRight"></div>
										</div>
										<div style="clear: left;">
											<div style="float: left;" id="cboxMiddleLeft"></div>
											<div style="float: left;" id="cboxContent">
												<div style="float: left;" id="cboxTitle"></div>
												<div style="float: left;" id="cboxCurrent"></div>
												<button id="cboxPrevious" type="button"></button>
												<button id="cboxNext" type="button"></button>
												<button id="cboxSlideshow"></button>
												<div style="float: left;" id="cboxLoadingOverlay"></div>
												<div style="float: left;" id="cboxLoadingGraphic"></div>
											</div>
											<div style="float: left;" id="cboxMiddleRight"></div>
										</div>
										<div style="clear: left;">
											<div style="float: left;" id="cboxBottomLeft"></div>
											<div style="float: left;" id="cboxBottomCenter"></div>
											<div style="float: left;" id="cboxBottomRight"></div>
										</div>
									</div>
									<div
										style="position: absolute; width: 9999px; visibility: hidden; display: none; max-width: none;"></div>
								</div>
								<div style="display: none;" id="cboxOverlay"></div>
								<div style="display: none;" tabindex="-1" role="dialog" class=""
									id="colorbox">
									<div id="cboxWrapper">
										<div>
											<div style="float: left;" id="cboxTopLeft"></div>
											<div style="float: left;" id="cboxTopCenter"></div>
											<div style="float: left;" id="cboxTopRight"></div>
										</div>
										<div style="clear: left;">
											<div style="float: left;" id="cboxMiddleLeft"></div>
											<div style="float: left;" id="cboxContent">
												<div style="float: left;" id="cboxTitle"></div>
												<div style="float: left;" id="cboxCurrent"></div>
												<button id="cboxPrevious" type="button"></button>
												<button id="cboxNext" type="button"></button>
												<button id="cboxSlideshow"></button>
												<div style="float: left;" id="cboxLoadingOverlay"></div>
												<div style="float: left;" id="cboxLoadingGraphic"></div>
											</div>
											<div style="float: left;" id="cboxMiddleRight"></div>
										</div>
										<div style="clear: left;">
											<div style="float: left;" id="cboxBottomLeft"></div>
											<div style="float: left;" id="cboxBottomCenter"></div>
											<div style="float: left;" id="cboxBottomRight"></div>
										</div>
									</div>
									<div
										style="position: absolute; width: 9999px; visibility: hidden; display: none; max-width: none;"></div>
								</div>
								<div style="display: none;" id="cboxOverlay"></div>
								<div style="display: none;" tabindex="-1" role="dialog" class=""
									id="colorbox">
									<div id="cboxWrapper">
										<div>
											<div style="float: left;" id="cboxTopLeft"></div>
											<div style="float: left;" id="cboxTopCenter"></div>
											<div style="float: left;" id="cboxTopRight"></div>
										</div>
										<div style="clear: left;">
											<div style="float: left;" id="cboxMiddleLeft"></div>
											<div style="float: left;" id="cboxContent">
												<div style="float: left;" id="cboxTitle"></div>
												<div style="float: left;" id="cboxCurrent"></div>
												<button id="cboxPrevious" type="button"></button>
												<button id="cboxNext" type="button"></button>
												<button id="cboxSlideshow"></button>
												<div style="float: left;" id="cboxLoadingOverlay"></div>
												<div style="float: left;" id="cboxLoadingGraphic"></div>
											</div>
											<div style="float: left;" id="cboxMiddleRight"></div>
										</div>
										<div style="clear: left;">
											<div style="float: left;" id="cboxBottomLeft"></div>
											<div style="float: left;" id="cboxBottomCenter"></div>
											<div style="float: left;" id="cboxBottomRight"></div>
										</div>
									</div>
									<div
										style="position: absolute; width: 9999px; visibility: hidden; display: none; max-width: none;"></div>
								</div>
								<div style="display: none;" id="cboxOverlay"></div>
								<div style="display: none;" tabindex="-1" role="dialog" class=""
									id="colorbox">
									<div id="cboxWrapper">
										<div>
											<div style="float: left;" id="cboxTopLeft"></div>
											<div style="float: left;" id="cboxTopCenter"></div>
											<div style="float: left;" id="cboxTopRight"></div>
										</div>
										<div style="clear: left;">
											<div style="float: left;" id="cboxMiddleLeft"></div>
											<div style="float: left;" id="cboxContent">
												<div style="float: left;" id="cboxTitle"></div>
												<div style="float: left;" id="cboxCurrent"></div>
												<button id="cboxPrevious" type="button"></button>
												<button id="cboxNext" type="button"></button>
												<button id="cboxSlideshow"></button>
												<div style="float: left;" id="cboxLoadingOverlay"></div>
												<div style="float: left;" id="cboxLoadingGraphic"></div>
											</div>
											<div style="float: left;" id="cboxMiddleRight"></div>
										</div>
										<div style="clear: left;">
											<div style="float: left;" id="cboxBottomLeft"></div>
											<div style="float: left;" id="cboxBottomCenter"></div>
											<div style="float: left;" id="cboxBottomRight"></div>
										</div>
									</div>
									<div
										style="position: absolute; width: 9999px; visibility: hidden; display: none; max-width: none;"></div>
								</div>
								<div style="display: none;" id="cboxOverlay"></div>
								<div style="display: none;" tabindex="-1" role="dialog" class=""
									id="colorbox">
									<div id="cboxWrapper">
										<div>
											<div style="float: left;" id="cboxTopLeft"></div>
											<div style="float: left;" id="cboxTopCenter"></div>
											<div style="float: left;" id="cboxTopRight"></div>
										</div>
										<div style="clear: left;">
											<div style="float: left;" id="cboxMiddleLeft"></div>
											<div style="float: left;" id="cboxContent">
												<div style="float: left;" id="cboxTitle"></div>
												<div style="float: left;" id="cboxCurrent"></div>
												<button id="cboxPrevious" type="button"></button>
												<button id="cboxNext" type="button"></button>
												<button id="cboxSlideshow"></button>
												<div style="float: left;" id="cboxLoadingOverlay"></div>
												<div style="float: left;" id="cboxLoadingGraphic"></div>
											</div>
											<div style="float: left;" id="cboxMiddleRight"></div>
										</div>
										<div style="clear: left;">
											<div style="float: left;" id="cboxBottomLeft"></div>
											<div style="float: left;" id="cboxBottomCenter"></div>
											<div style="float: left;" id="cboxBottomRight"></div>
										</div>
									</div>
									<div
										style="position: absolute; width: 9999px; visibility: hidden; display: none; max-width: none;"></div>
								</div>
								<div style="display: none;" id="cboxOverlay"></div>
								<div style="display: none;" tabindex="-1" role="dialog" class=""
									id="colorbox">
									<div id="cboxWrapper">
										<div>
											<div style="float: left;" id="cboxTopLeft"></div>
											<div style="float: left;" id="cboxTopCenter"></div>
											<div style="float: left;" id="cboxTopRight"></div>
										</div>
										<div style="clear: left;">
											<div style="float: left;" id="cboxMiddleLeft"></div>
											<div style="float: left;" id="cboxContent">
												<div style="float: left;" id="cboxTitle"></div>
												<div style="float: left;" id="cboxCurrent"></div>
												<button id="cboxPrevious" type="button"></button>
												<button id="cboxNext" type="button"></button>
												<button id="cboxSlideshow"></button>
												<div style="float: left;" id="cboxLoadingOverlay"></div>
												<div style="float: left;" id="cboxLoadingGraphic"></div>
											</div>
											<div style="float: left;" id="cboxMiddleRight"></div>
										</div>
										<div style="clear: left;">
											<div style="float: left;" id="cboxBottomLeft"></div>
											<div style="float: left;" id="cboxBottomCenter"></div>
											<div style="float: left;" id="cboxBottomRight"></div>
										</div>
									</div>
									<div
										style="position: absolute; width: 9999px; visibility: hidden; display: none; max-width: none;"></div>
								</div>
								<div style="display: none;" id="cboxOverlay"></div>
								<div style="display: none;" tabindex="-1" role="dialog" class=""
									id="colorbox">
									<div id="cboxWrapper">
										<div>
											<div style="float: left;" id="cboxTopLeft"></div>
											<div style="float: left;" id="cboxTopCenter"></div>
											<div style="float: left;" id="cboxTopRight"></div>
										</div>
										<div style="clear: left;">
											<div style="float: left;" id="cboxMiddleLeft"></div>
											<div style="float: left;" id="cboxContent">
												<div style="float: left;" id="cboxTitle"></div>
												<div style="float: left;" id="cboxCurrent"></div>
												<button id="cboxPrevious" type="button"></button>
												<button id="cboxNext" type="button"></button>
												<button id="cboxSlideshow"></button>
												<div style="float: left;" id="cboxLoadingOverlay"></div>
												<div style="float: left;" id="cboxLoadingGraphic"></div>
											</div>
											<div style="float: left;" id="cboxMiddleRight"></div>
										</div>
										<div style="clear: left;">
											<div style="float: left;" id="cboxBottomLeft"></div>
											<div style="float: left;" id="cboxBottomCenter"></div>
											<div style="float: left;" id="cboxBottomRight"></div>
										</div>
									</div>
									<div
										style="position: absolute; width: 9999px; visibility: hidden; display: none; max-width: none;"></div>
								</div>
								<div id="cboxOverlay" style="display: none;"></div>
								<div id="colorbox" class="" role="dialog" tabindex="-1"
									style="display: none;">
									<div id="cboxWrapper">
										<div>
											<div id="cboxTopLeft" style="float: left;"></div>
											<div id="cboxTopCenter" style="float: left;"></div>
											<div id="cboxTopRight" style="float: left;"></div>
										</div>
										<div style="clear: left;">
											<div id="cboxMiddleLeft" style="float: left;"></div>
											<div id="cboxContent" style="float: left;">
												<div id="cboxTitle" style="float: left;"></div>
												<div id="cboxCurrent" style="float: left;"></div>
												<button type="button" id="cboxPrevious"></button>
												<button type="button" id="cboxNext"></button>
												<button id="cboxSlideshow"></button>
												<div id="cboxLoadingOverlay" style="float: left;"></div>
												<div id="cboxLoadingGraphic" style="float: left;"></div>
											</div>
											<div id="cboxMiddleRight" style="float: left;"></div>
										</div>
										<div style="clear: left;">
											<div id="cboxBottomLeft" style="float: left;"></div>
											<div id="cboxBottomCenter" style="float: left;"></div>
											<div id="cboxBottomRight" style="float: left;"></div>
										</div>
									</div>
									<div
										style="position: absolute; width: 9999px; visibility: hidden; display: none; max-width: none;"></div>
								</div>
								<div id="cboxOverlay" style="display: none;"></div>
								<div id="colorbox" class="" role="dialog" tabindex="-1"
									style="display: none;">
									<div id="cboxWrapper">
										<div>
											<div id="cboxTopLeft" style="float: left;"></div>
											<div id="cboxTopCenter" style="float: left;"></div>
											<div id="cboxTopRight" style="float: left;"></div>
										</div>
										<div style="clear: left;">
											<div id="cboxMiddleLeft" style="float: left;"></div>
											<div id="cboxContent" style="float: left;">
												<div id="cboxTitle" style="float: left;"></div>
												<div id="cboxCurrent" style="float: left;"></div>
												<button type="button" id="cboxPrevious"></button>
												<button type="button" id="cboxNext"></button>
												<button id="cboxSlideshow"></button>
												<div id="cboxLoadingOverlay" style="float: left;"></div>
												<div id="cboxLoadingGraphic" style="float: left;"></div>
											</div>
											<div id="cboxMiddleRight" style="float: left;"></div>
										</div>
										<div style="clear: left;">
											<div id="cboxBottomLeft" style="float: left;"></div>
											<div id="cboxBottomCenter" style="float: left;"></div>
											<div id="cboxBottomRight" style="float: left;"></div>
										</div>
									</div>
									<div
										style="position: absolute; width: 9999px; visibility: hidden; display: none; max-width: none;"></div>
								</div>
</body>
</html>