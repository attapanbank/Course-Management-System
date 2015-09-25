<%@ page language="java" contentType="text/html; charset=utf-8"
	import="java.sql.*" pageEncoding="utf-8"%>

<%@page import="java.io.InputStream"%>
<%@page import="java.util.Properties"%>

<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page import="java.io.*,java.util.Locale"%>

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
					<li><a href="#">Profile</a></li>
					<li class="divider"></li>
					<li><a href="login.jsp">Logout</a></li>
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
												class="glyphicon glyphicon-chevron-up"></i></a> <a href="#"
												class="btn btn-close btn-round btn-default"><i
												class="glyphicon glyphicon-remove"></i></a>
										</div>
									</div>
									<div class="box-content">
										<table
											class="table table-striped table-bordered bootstrap-datatable datatable responsive">
											<thead>
												<tr>
													<th width="700px">Lecture</th>
													<th>Hours / Week</th>
													<th>Workload / Week</th>
													<th>Actions</th>
												</tr>
											</thead>
											<tbody>
												<tr>
													<td>ดร.ธีรวิศิฏฐ์ เลาหะเพ็ญแสง</td>
													<td>8</td>
													<td>6.5</td>
													<td><a class="btn btn btn-success btn-setting"
														href="#"> <i
															class="glyphicon glyphicon-zoom-in icon-white"></i> View
													</a></td>
												<tr>
													<td>ดร.ภาคภูมิ บุญญานันต์</td>
													<td>7</td>
													<td>6</td>
													<td><a class="btn btn btn-success btn-setting"
														href="#"> <i
															class="glyphicon glyphicon-zoom-in icon-white"></i> View
													</a></td>
												</tr>
												<tr>
													<td>ดร.สุรพงษ์ อุตมา</td>
													<td>11</td>
													<td>6.5</td>
													<td><a class="btn btn btn-success btn-setting"
														href="#"> <i
															class="glyphicon glyphicon-zoom-in icon-white"></i> View
													</a></td>
												</tr>
											</tbody>
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
															System.out.println("None");
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
													String QueryString = "SELECT * FROM courseplan LEFT JOIN course ON course.courseCode = courseplan.courseCode LEFT JOIN course_survey ON course_survey.courseCode = courseplan.courseCode WHERE courseplan.year = '"
															+ year
															+ "' AND courseplan.semester = '"
															+ term
															+ "' GROUP BY courseplan.courseCode;";
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
													<a href="#" class="btn btn-setting btn-round btn-default"><i
														class="glyphicon glyphicon-cog"></i></a> <a href="#"
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
															String QueryCandidate = "SELECT * FROM currentcourse INNER JOIN course ON currentcourse.courseCode = course.courseCode INNER JOIN section ON currentcourse.currentcourseID = section.currentcourseID INNER JOIN candidate ON section.sectionID = candidate.sectionID WHERE currentcourse.year = '"
																	+ year
																	+ "' AND currentcourse.semester = '"
																	+ term
																	+ "' GROUP BY section.sectionID;";
															ResultSet rscandidate = stmt.executeQuery(QueryCandidate);
															int countcandidate = 0;
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
																		sectionid[countcandidate] = rscandidate
																				.getString("section.sectionID");
																%>
															</td>
															<td><a class="btn btn btn-success btn-setting"
																href="#AfterCandidate<%=sectionid[countcandidate]%>"
																data-toggle="modal"> <i
																	class="glyphicon glyphicon-zoom-in icon-white"></i>
																	View
															</a> <a class="btn btn-danger confirmation"
																href="Admin_Candidate_DeleteCandidate.jsp?del=<%=sectionid[countcandidate]%>">
																	<i class="glyphicon glyphicon-trash icon-white"></i>
																	Delete
															</a></td>
														</tr>
														<%
															countcandidate++;
															}
														%>
													</tbody>
												</table>
											</div>
										</div>
									</div>
									<!--/span-->
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

								<!-- content ends -->
							</div>
							<!--/#content.col-md-0-->
						</div>
						<!--/fluid-row-->

						<script type="text/javascript">
							function sendnotcandidatesetting() {
								document.getElementById("setnotcandidateform")
										.submit();
							}
						</script>

						<hr>
						<div class="modal fade" id="settingforworkload" tabindex="-1"
							role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
							<div class="modal-dialog">
								<div class="modal-content">
									<div class="modal-header">
										<button type="button" class="close" data-dismiss="modal">×</button>
										<h3>Settings</h3>
									</div>
									<div class="modal-body">
										<p>Here settings can be configured...</p>
									</div>
									<div class="modal-footer">
										<a href="#" class="btn btn-default" data-dismiss="modal">Close</a>
										<a href="#" class="btn btn-primary" data-dismiss="modal">Save
											changes</a>
									</div>
								</div>
							</div>
						</div>

						<div class="modal fade" id="settingfornotcandidate" tabindex="-1"
							role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
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
											<label for="Year">Year</label> <select id="notcandidateyear"
												name="notcandidateyear">
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
											</select> <label for="Term">Term</label> <select id="notcandidateterm"
												name="notcandidateterm">
												<option value="1">1</option>
												<option value="2">2</option>
											</select> <br> <a href="#" class="btn btn-default"
												data-dismiss="modal">Close</a> <input type="button"
												class="btn btn-primary" onClick="sendnotcandidatesetting()"
												value="Submit" />
										</form>
									</div>
									<div class="modal-footer"></div>
								</div>
							</div>
						</div>

						<%
							for (int d = 0; d < countcandidate; d++) {
								stmt = con.createStatement();
								String Querysection = "SELECT * FROM section INNER JOIN candidate ON candidate.sectionID = section.sectionID INNER JOIN user ON candidate.userID = user.userID INNER JOIN currentcourse ON currentcourse.currentcourseID = section.currentcourseID WHERE currentcourse.year = '"
										+ year
										+ "' AND currentcourse.semester = '"
										+ term
										+ "' AND section.sectionID = '"
										+ sectionid[d]
										+ "' ORDER BY teachtype desc";
								ResultSet rssection = stmt.executeQuery(Querysection);
						%>
						<div class="modal fade" id="AfterCandidate<%=sectionid[d]%>"
							tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
							aria-hidden="true">
							<div class="modal-dialog">
								<div class="modal-content">
									<div class="modal-header">
										<button type="button" class="close" data-dismiss="modal">×</button>
										<h3>Candidate</h3>
									</div>
									<div class="modal-body">
										<table class="table">
											<thead>
												<tr>
													<th>Teacher Name</th>
													<th>Role</th>
													<th>Teach in</th>
												</tr>
											</thead>
											<tbody>
												<%
													while (rssection.next()) {
												%>
												<tr>
													<td><%=rssection.getString("user.firstname")%> <%=rssection.getString("user.lastname")%></td>
													<td><%=rssection.getString("user.usertype")%></td>
													<td><%=rssection.getString("candidate.teachtype")%></td>
												</tr>
												<%
													}
												%>
											</tbody>
										</table>
									</div>
									<div class="modal-footer">
										<a href="#" class="btn btn-default" data-dismiss="modal">Close</a>
									</div>
								</div>
							</div>
						</div>
						<%
							}
						%>
						<footer class="row">
						<p class="col-md-9 col-sm-9 col-xs-12 copyright">
							© <a href="http://usman.it" target="_blank">Muhammad Usman</a>
							2012 - 2014
						</p>
						<p class="col-md-3 col-sm-3 col-xs-12 powered-by">
							Theme by:<a href="http://usman.it/free-responsive-admin-template">Charisma</a>
						</p>
						</footer>
						<!--/.fluid-container-->

						<!-- external javascript -->

						<script src="bower_components/bootstrap/dist/js/bootstrap.min.js"></script>

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