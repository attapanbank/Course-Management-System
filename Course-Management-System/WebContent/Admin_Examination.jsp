<%@ page language="java" contentType="text/html; charset=utf-8"
	import="java.sql.*" pageEncoding="utf-8"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.util.Properties"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page import="java.io.*,java.util.Locale"%>

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
<title>Examination</title>
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
									class="glyphicon glyphicon-home"></i><span> Dashboard</span></a></li>
							<li class="nav-header hidden-md">Management</li>
							<li><a class="ajax-link" href="Admin_Candidate.jsp"><i
									class="glyphicon glyphicon-align-justify"></i><span>
										Candidate</span></a></li>
							<li><a class="ajax-link" href="Admin_CoursePlan.jsp"><i
									class="glyphicon glyphicon-align-justify"></i><span>
										Course Plan</span></a></li>
							<li class="active"><a class="ajax-link"
								href="Admin_Examination.jsp"><i
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
						<li><a href="Admin_Examination.jsp">Examination</a></li>
					</ul>
				</div>
				<div class="row">
					<div class="box col-md-4">
						<div class="box-inner">
							<div class="box-header well" data-original-title="">
								<h2>
									<i class="glyphicon glyphicon-ok"></i>&nbsp;&nbsp;Set Select
									Examination Type
								</h2>
								<div class="box-icon">
									<a href="#settingforexamsurvey"
										class="btn btn-setting btn-round btn-default"
										data-toggle="modal"><i class="glyphicon glyphicon-cog"></i></a>
									<a href="#" class="btn btn-minimize btn-round btn-default"><i
										class="glyphicon glyphicon-chevron-up"></i></a> <a href="#"
										class="btn btn-close btn-round btn-default"><i
										class="glyphicon glyphicon-remove"></i></a>
								</div>
							</div>
							<div class="box-content" align="center">
								<form method="post" action="Admin_Examination_SubmitSurvey.jsp"
									role="form" id="examsurveyform">
									<div class="box-content" align="center">
										<%
											if (null == (String) session.getAttribute("ExamSurveyYear")) {
										%>

										<p>
											<b><i>Year : Term : </i></b>
										</p>

										<%
											} else {
										%>

										<p>
											<b><i>Year : <%=(String) session.getAttribute("ExamSurveyYear")%>
													Term : <%=(String) session.getAttribute("ExamSurveyTerm")%></i></b>
										</p>

										<%
											}
										%>
										<label for="exampleToggleSwitch">Switch</label> <input
											data-no-uniform="true" name="checkboxsurvey" type="checkbox"
											class="iphone-toggle"> <br> <input type="hidden"
											name="surveyyear" id="surveyyear"
											value="<%=(String) session.getAttribute("ExamSurveyYear")%>">
										<input type="hidden" name="surveyterm" id="surveyterm"
											value="<%=(String) session.getAttribute("ExamSurveyTerm")%>">
										<p>
											Status :
											<%
											if (null == (String) session.getAttribute("ExamSurveyYear")) {
										%>

											<%
												} else {
													stmt = con.createStatement();
													String QueryString = "SELECT * FROM examination_checksurvey where year = "
															+ (String) session.getAttribute("ExamSurveyYear")
															+ " and semester = "
															+ (String) session.getAttribute("ExamSurveyTerm");
													ResultSet rs = stmt.executeQuery(QueryString);
													if (rs.next()) {
											%>
											<input type="hidden" name="checksurveyID" id="checksurveyID"
												value="<%=rs
							.getString("examination_checksurvey.examination_checksurveyID")%>">
											<%=rs
							.getString("examination_checksurvey.checksurvey")%>
											<%
												} else {
											%>
											OFF
											<%
												}

												}
											%>
										</p>
									</div>
									<button type="button" onclick="submitsurveyform()"
										class="btn btn-default">Submit</button>
								</form>

								<script type="text/javascript">
									function submitsurveyform() {
										var surveyyear =
								<%=session.getAttribute("ExamSurveyYear")%>
									;
										var surveyterm =
								<%=session.getAttribute("ExamSurveyTerm")%>
									;

										if (!surveyyear || !surveyterm) {
											swal("Select Year and Semester First.");
										} else {
											document.getElementById(
													"examsurveyform").submit();
										}
									}
								</script>

							</div>
						</div>
					</div>
					<!--/span-->

				</div>
				<!--/row-->


				<div class="row">
					<div class="box col-md-12">
						<div class="box-inner">
							<div class="box-header well" data-original-title="">
								<h2>
									<i class="glyphicon glyphicon-list-alt"></i>&nbsp;&nbsp;Examination
								</h2>
								<div class="box-icon">
									<a href="#settingforexamination"
										class="btn btn-setting btn-round btn-default"
										data-toggle="modal"><i class="glyphicon glyphicon-cog"></i></a>
									<a href="#" class="btn btn-minimize btn-round btn-default"><i
										class="glyphicon glyphicon-chevron-up"></i></a> <a href="#"
										class="btn btn-close btn-round btn-default"> <i
										class="glyphicon glyphicon-remove"></i></a>
								</div>
							</div>
							<div class="box-content">
								<table
									class="table table-striped table-bordered bootstrap-datatable datatable responsive">




									<%
										String strdateterm1_1 = "";
										String strdateterm1_2 = "";
										String strdateterm2_1 = "";
										String strdateterm2_2 = "";

										String academicyear = null;
										String academicterm = null;

										if (null == (String) session.getAttribute("ExaminationYear")) {

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
											} else {
												academicyear = "";
												academicterm = "";
											}

											session.setAttribute("academicyear", academicyear);
											session.setAttribute("academicterm", academicterm);
									%>
									<p>
										<b><i>Year : <%=academicyear%> Term : <%=academicterm%>
										</i></b>
									</p>

									<%
										} else {
									%>

									<p>
										<b><i>Year : <%=(String) session.getAttribute("ExaminationYear")%>
												Term : <%=(String) session.getAttribute("ExaminationTerm")%></i></b>
									</p>

									<%
										}
									%>





									<thead>
										<tr>
											<th>Course Code</th>
											<th>Course Name</th>


											<th>Midterm</th>
											<td>Writting</td>
											<td>Multiple Choice</td>
											<td>Off Schedule</td>
											<td>No-Exam</td>
											<th>Final</th>
											<td>Writting</td>
											<td>Multiple Choice</td>
											<td>Off Schedule</td>
											<td>No-Exam</td>
											<th>Detail</th>
										</tr>
									</thead>

									<%
										String year = "";
										String term = "";
										if (null == (String) session.getAttribute("ExaminationYear")) {
											year = (String) session.getAttribute("academicyear");
											term = (String) session.getAttribute("academicterm");
										} else if (null != (String) session.getAttribute("ExaminationYear")) {
											year = (String) session.getAttribute("ExaminationYear");
											term = (String) session.getAttribute("ExaminationTerm");
										} else {
											year = null;
											term = null;
										}
										stmt = con.createStatement();
										String qeString = "SELECT * FROM examsurvey inner join course inner join candidate inner join currentcourse inner join section where examsurvey.courseCode = course.courseCode and examsurvey.year = '"
												+ year
												+ "' and examsurvey.semester ='"
												+ term
												+ "'and examsurvey.courseCode = currentcourse.courseCode and section.currentcourseID = currentcourse.currentcourseID and section.sectionID = candidate.sectionID group by course.courseName;";
										ResultSet rsExamResult = stmt.executeQuery(qeString);
									%>

									<%
										// use for check type of exam
										String midType = null;
										String finalType = null;
										String reasonMid = null;
										String reasonFinal = null;
										String courseCode = null;
										String userType = null;
										String examID = null;

										while (rsExamResult.next()) {
									%>
									<tbody>
										<tr>
											<td>
												<%
													examID = rsExamResult.getString("examsurvey.examSurveyID");
														courseCode = rsExamResult.getString("course.courseCode");
														out.print(courseCode);
												%>
											</td>
											<td>
												<%
													out.print(rsExamResult.getString("course.courseName"));
												%>
											</td>




											<%
												midType = rsExamResult.getString("midtermType");

													reasonMid = rsExamResult.getString("reasonMid");

													if (midType != null) {
											%>

											<%
												// Check midterm type
														
														if (midType.equals("Not have")) {
											%>
											<td><input type="checkbox" value="" disabled></td>
											<td><input type="checkbox" value="" disabled></td>
											<td><input type="checkbox" value="" disabled></td>
											<td><input type="checkbox" value="" disabled></td>
											<td><input type="checkbox" value="" disabled
												checked="checked"></td>
											<%
												} else if (midType.equals("MD")) {
											%>
											<td><input type="checkbox" checked="checked" value=""
												disabled></td>
											<td><input type="checkbox" checked="checked" value=""
												disabled></td>
											<td><input type="checkbox" checked="checked" value=""
												disabled></td>
											<td><input type="checkbox" value="" disabled></td>
											<td><input type="checkbox" value="" disabled></td>
											<%
												} else if (midType.equals("Writing")) {
											%>
											<td><input type="checkbox" checked="checked" value=""
												disabled></td>
											<td><input type="checkbox" checked="checked" value=""
												disabled></td>
											<td><input type="checkbox" value="" disabled></td>
											<td><input type="checkbox" value="" disabled></td>
											<td><input type="checkbox" value="" disabled></td>
											<%
												} else if (midType.equals("Multiple Choice")) {
											%>
											<td><input type="checkbox" checked="checked" value=""
												disabled></td>
											<td><input type="checkbox" value="" disabled></td>
											<td><input type="checkbox" checked="checked" value=""
												disabled></td>
											<td><input type="checkbox" value="" disabled></td>
											<td><input type="checkbox" value="" disabled></td>
											<%
												} else if (midType.equals("Off Schedule")) {
											%>
											<td><input type="checkbox"  value=""
												disabled></td>
											<td><input type="checkbox" value="" disabled></td>
											<td><input type="checkbox"  value=""
												disabled></td>
											<td><input type="checkbox" checked="checked" value="" disabled></td>
											<td><input type="checkbox" value="" disabled></td>
											<%
												}
											%>
											<%
												} else {
											%>
											<td><input type="checkbox" value="" disabled></td>
											<%
												}
											%>



										<%
												finalType = rsExamResult.getString("finalType");

													reasonFinal = rsExamResult.getString("reasonFinal");

													if (finalType != null) {
											%>

											<%
												// Check final type
														
														if (finalType.equals("Not have")) {
											%>
											<td><input type="checkbox" value="" disabled></td>
											<td><input type="checkbox" value="" disabled></td>
											<td><input type="checkbox" value="" disabled></td>
											<td><input type="checkbox" value="" disabled></td>
											<td><input type="checkbox" value="" disabled
												checked="checked"></td>
											<%
												} else if (finalType.equals("MD")) {
											%>
											<td><input type="checkbox" checked="checked" value=""
												disabled></td>
											<td><input type="checkbox" checked="checked" value=""
												disabled></td>
											<td><input type="checkbox" checked="checked" value=""
												disabled></td>
											<td><input type="checkbox" value="" disabled></td>
											<td><input type="checkbox" value="" disabled></td>
											<%
												} else if (finalType.equals("Writing")) {
											%>
											<td><input type="checkbox" checked="checked" value=""
												disabled></td>
											<td><input type="checkbox" checked="checked" value=""
												disabled></td>
											<td><input type="checkbox" value="" disabled></td>
											<td><input type="checkbox" value="" disabled></td>
											<td><input type="checkbox" value="" disabled></td>
											<%
												} else if (finalType.equals("Multiple Choice")) {
											%>
											<td><input type="checkbox" checked="checked" value=""
												disabled></td>
											<td><input type="checkbox" value="" disabled></td>
											<td><input type="checkbox" checked="checked" value=""
												disabled></td>
											<td><input type="checkbox" value="" disabled></td>
											<td><input type="checkbox" value="" disabled></td>
											<%
												} else if (finalType.equals("Off Schedule")) {
											%>
											<td><input type="checkbox"  value=""
												disabled></td>
											<td><input type="checkbox" value="" disabled></td>
											<td><input type="checkbox"  value=""
												disabled></td>
											<td><input type="checkbox" checked="checked" value="" disabled></td>
											<td><input type="checkbox" value="" disabled></td>
											<%
												}
											%>
											<%
												} else {
											%>
											<td><input type="checkbox" value="" disabled></td>
											<%
												}
											%>




											<td><a class="btn btn-success btn-setting"
												href="Admin_Examination_View_Detail.jsp?examSurveyID=<%out.print(rsExamResult.getString("examsurvey.examSurveyID"));%>&&year=<%=year%>&&term=<%=term%>"
												data-toggle="modal"
												onClick="NewWindow(this.href,'name','800','600','yes');return false">
													<i class="glyphicon glyphicon-zoom-in icon-white"></i> View
											</a></td>
										</tr>

									</tbody>
									<%
										}
									%>
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

		<hr>

		<script type="text/javascript">
			function sendexamsurveysetting() {
				document.getElementById("setyeartermformexamsurvey").submit();
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

		<div class="modal fade" id="settingforexamsurvey" tabindex="-1"
			role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">×</button>
						<h3>Setting Course Plan Survey</h3>
					</div>
					<div class="modal-body">
						<form method="post"
							action="Admin_Examination_SetSurveyYearSemester.jsp"
							role="setyeartermformsurvey" id="setyeartermformexamsurvey">
							<p>Select year and semester</p>
							<label for="Year">Year</label> <select id="examsurveyyear"
								name="examsurveyyear">
								<script>
									var myDate = new Date();
									var year = myDate.getFullYear() + 543;
									for (var i = year + 1; i > 2540; i--) {
										document.write('<option value="'+i+'">'
												+ i + '</option>');
									}
								</script>
							</select> <label for="Term">Term</label> <select id="examsurveyterm"
								name="examsurveyterm">
								<option value="1">1</option>
								<option value="2">2</option>
							</select> <br> <br>
							<p>Table for all year and semester</p>
							<table
								class="table table-striped table-bordered bootstrap-datatable datatable responsive">
								<thead>
									<tr>
										<th>Year</th>
										<th>Semester</th>
										<th>Status</th>
									</tr>
								</thead>
								<tbody>
									<%
										stmt = con.createStatement();
										String QuerySurveyString = "SELECT * FROM examination_checksurvey ORDER BY year DESC , semester DESC";
										ResultSet result = stmt.executeQuery(QuerySurveyString);
										while (result.next()) {
									%>
									<tr>
										<td>
											<%
												out.print(result.getString("examination_checksurvey.year"));
											%>
										</td>
										<td class="center">
											<%
												out.print(result.getString("examination_checksurvey.semester"));
											%>
										</td>
										<td class="center">
											<%
												out.print(result
															.getString("examination_checksurvey.checksurvey"));
											%>
										</td>
									</tr>
									<%
										}
									%>

								</tbody>
							</table>

							<a href="#" class="btn btn-default" data-dismiss="modal">Close</a>
							<input type="button" class="btn btn-primary"
								onClick="sendexamsurveysetting()" value="Submit" />
						</form>
					</div>
					<div class="modal-footer"></div>
				</div>
			</div>
		</div>

		<div class="modal fade" id="settingforexamination" tabindex="-1"
			role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">×</button>
						<h3>Setting Examination Year</h3>
					</div>
					<div class="modal-body">
						<form method="post" action="Admin_Examination_SetYearSemester.jsp"
							role="setyeartermform" id="setyeartermform">
							<label for="Year">Year</label> <select id="examinationyear"
								name="examinationyear">
								<script>
									var myDate = new Date();
									var year = myDate.getFullYear() + 543;
									for (var i = year + 1; i > 2540; i--) {
										document.write('<option value="'+i+'">'
												+ i + '</option>');
									}
								</script>
							</select> <label for="Term">Term</label> <select id="examinationterm"
								name="examinationterm">
								<option value="1">1</option>
								<option value="2">2</option>
							</select> <br> <a href="#" class="btn btn-default"
								data-dismiss="modal">Close</a> <input type="button"
								class="btn btn-primary" onClick="sendexaminationsetting()"
								value="Submit" />
						</form>
					</div>
					<div class="modal-footer"></div>
				</div>
			</div>
		</div>

		<script type="text/javascript">
			function sendexaminationsetting() {
				document.getElementById("setyeartermform").submit();
			}
		</script>

		<footer class="row">
		<p class="col-md-9 col-sm-9 col-xs-12 copyright">
			© <a href="http://usman.it" target="_blank">Muhammad Usman</a> 2012 -
			2014
		</p>
		<p class="col-md-3 col-sm-3 col-xs-12 powered-by">
			Theme by:<a href="http://usman.it/free-responsive-admin-template">Charisma</a>
		</p>
		</footer>
	</div>
	<!--/.fluid-container-->

	<!-- external javascript -->

	<script src="bower_components/bootstrap/dist/js/bootstrap.min.js"></script>

	<!-- library for cookie management -->
	<script src="js/jquery.cookie.js"></script>
	<!-- calender plugin -->
	<script src="bower_components/moment/min/moment.min.js"></script>
	<script src="bower_components/fullcalendar/dist/fullcalendar.min.js"></script>
	<!-- data table plugin -->
	<script src="js/jquery.dataTables.min.js"></script>

	<!-- select or dropdown enhancer -->
	<script src="bower_components/chosen/chosen.jquery.min.js"></script>
	<!-- plugin for gallery image view -->
	<script src="bower_components/colorbox/jquery.colorbox-min.js"></script>
	<!-- notification plugin -->
	<script src="js/jquery.noty.js"></script>
	<!-- library for making tables responsive -->
	<script src="bower_components/responsive-tables/responsive-tables.js"></script>
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