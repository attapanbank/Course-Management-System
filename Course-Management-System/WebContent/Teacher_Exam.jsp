<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.sql.*"%>

<%@page import="java.io.InputStream"%>
<%@page import="java.util.Properties"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page import="java.io.*,java.util.Locale"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
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
	if (strUserID == null) {
		response.sendRedirect("Main_Login.jsp");
	}
%>

<head>
<meta charset="utf-8">
<title>Teacher Examination</title>
<script src="dist/sweetalert-dev.js"></script>
<link rel="stylesheet" href="dist/sweetalert.css">



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
			<a class="navbar-brand" href="#"> <span>IT:CMS</span></a>
			<!-- user dropdown starts -->
			<div class="btn-group pull-right">
				<button class="btn btn-default dropdown-toggle"
					data-toggle="dropdown">

					<i class="glyphicon glyphicon-user"></i><span
						class="hidden-sm hidden-xs"> <%
 	out.print(sFirstname);
 %>
					</span> <span class="caret"></span>
				</button>
				<ul class="dropdown-menu">
					<li><a href="Teacher_Profile.jsp">Profile</a></li>
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
							<li><a class="ajax-link" href="Teacher_News.jsp"><i
									class="glyphicon glyphicon-home"></i><span> Dashboard</span></a></li>
							<li class="nav-header hidden-md">Management</li>
							<li><a class="ajax-link" href="Teacher_Workload.jsp"><i
									class="glyphicon glyphicon-align-justify"></i><span>
										Workload</span></a></li>
							<li><a class="ajax-link" href="Teacher_Course.jsp"><i
									class="glyphicon glyphicon-align-justify"></i><span>
										Course</span></a></li>
							<li class="active"><a class="ajax-link"
								href="Teacher_Exam.jsp"><i
									class="glyphicon glyphicon-align-justify"></i><span>
										Examination</span></a></li>

						</ul>
					</div>
				</div>
			</div>
			<!--/span-->
			<!-- left menu ends -->

			<noscript>&amp;lt;div class="alert alert-block
				col-md-12"&amp;gt; &amp;lt;h4
				class="alert-heading"&amp;gt;Warning!&amp;lt;/h4&amp;gt;

				&amp;lt;p&amp;gt;You need to have &amp;lt;a
				href="http://en.wikipedia.org/wiki/JavaScript"
				target="_blank"&amp;gt;JavaScript&amp;lt;/a&amp;gt; enabled to use
				this site.&amp;lt;/p&amp;gt; &amp;lt;/div&amp;gt;</noscript>

			<div id="content" class="col-lg-10 col-sm-10">
				<!-- content starts -->


				


				<%
					// Check exam survey open 
					stmt = con.createStatement();
					String checkExamSurveyOpen = "SELECT * FROM examination_checksurvey where checksurvey = 'ON' ORDER BY year  ;";
					ResultSet rsCheckOpen = stmt.executeQuery(checkExamSurveyOpen);

					String checkOn = null;
					String year = null;
					String semester = null;

					while (rsCheckOpen.next()) {
						checkOn = rsCheckOpen.getString("checksurvey");
						year = rsCheckOpen.getString("year");
						semester = rsCheckOpen.getString("semester");

					}

					if (checkOn != null) {

						if (checkOn.equals("ON")) {
				%>



				<div class="row">
					<div class="box col-md-12">
						<div class="box-inner">
							<div class="box-header well" data-original-title="">
								<h2>
									<i class="glyphicon glyphicon-star-empty"></i> Examination Year
									<%=year%>
									Term
									<%=semester%>
								</h2>

								<div class="box-icon">
									<a href="#" class="btn btn-minimize btn-round btn-default"><i
										class="glyphicon glyphicon-chevron-up"></i></a>
								</div>
							</div>
							<div class="box-content" style="display: block;">
								<!-- put your content here -->
								<div id="DataTables_Table_0_wrapper" class="dataTables_wrapper"
									role="grid">

									<%
										String examCourse = null;
												stmt = con.createStatement();
												String QueryStringExamDb = "SELECT * FROM examsurvey ";
												ResultSet rsOut = stmt.executeQuery(QueryStringExamDb);

												while (rsOut.next()) {
													examCourse = rsOut.getString("courseCode");

												}
									%>

									<%
										stmt = con.createStatement();
												String QueryStringExam = "SELECT * FROM section inner join candidate inner join currentcourse inner join course where userID = '"
														+ strUserID
														+ "' and currentcourse.courseCode = course.courseCode and section.currentcourseID = currentcourse.currentcourseID and currentcourse.year = '"
														+ year
														+ "' and currentcourse.semester = '"
														+ semester
														+ "'  and  section.sectionID = candidate.sectionID and candidate.teachtype = 'Lect'and currentcourse.courseco_userID = '"
														+ strUserID + "';";
												ResultSet rsExam = stmt.executeQuery(QueryStringExam);
												String sCosCode = null;
												String sCosName = null;
												//String year = "2556";
												//String semester = "1";
									%>





									<table aria-describedby="DataTables_Table_0_info"
										id="DataTables_Table_0"
										class="table table-striped table-bordered bootstrap-datatable datatable responsive dataTable">

										<thead>
											<tr role="row">
												<th colspan="1" rowspan="1">Course Code</th>
												<th colspan="1" rowspan="1">Course Name</th>
												<th colspan="1" rowspan="1">Teacher Assistance</th>
												<th colspan="1" rowspan="1">Major</th>
												<th colspan="1" rowspan="1">Number of Student</th>
												<th colspan="1" rowspan="1">Action</th>
										</thead>

										



										<tbody aria-relevant="all" aria-live="polite" role="alert">

<%
											while (rsExam.next()) {
										%>
											<tr>
												<td>
													<%
														sCosCode = rsExam.getString("course.courseCode");

																	out.print(sCosCode);
													%> <input type="hidden" name="courseCode"
													value="<%=rsExam.getString("course.courseCode")%>">
												</td>
												<td>
													<%
														sCosName = rsExam.getString("course.courseName");
																	out.print(sCosName);
													%> <input type="hidden" name="courseName"
													value="<%=sCosName%>">

												</td>
												<td>
													<%
														// TO Get teacher assistance
																	stmt = con.createStatement();
																	String sql = "SELECT * FROM candidate  inner join user inner join currentcourse inner join section on user.userID = candidate.userID and user.usertype ='Teacher Assistance' and currentcourse.year = '"
																			+ year
																			+ "' and currentcourse.semester ='"
																			+ semester
																			+ "' and currentcourse.currentcourseID = section.currentcourseID and section.sectionID = candidate.sectionID ;";
																	ResultSet rsta = stmt.executeQuery(sql);
																	// Check form db who is teacher assistance.
																	// Loop only teacher assisstance.
																	while (rsta.next()) {
																		String courseTA = rsta
																				.getString("currentcourse.courseCode");
																		if (courseTA.equals(sCosCode)) {
																			out.println(" - Ajarn "
																					+ rsta.getString("user.firstname")
																					+ " " + rsta.getString("user.lastname")
																					+ "<br>");
																		}
																	}
													%>
												</td>

												<td>
													<%
														out.print(rsExam.getString("section.major"));
													%> <input type="hidden" name="year" value="<%=year%>">
												</td>
												<td>
													<%
														out.print(rsExam.getString("section.numberofstudent"));
													%> <input type="hidden" name="semester"
													value="<%=semester%>">
												</td>





												<td><a class="btn btn-success examSurveybtn"
													href="Teacher_Exam_Select.jsp?courseCode=<%out.print(rsExam.getString("courseCode"));%>&&courseName=<%out.print(rsExam.getString("courseName"));%>&&year=<%=year%>&&semester=<%=semester%>"
													onClick="NewWindow(this.href,'name','1200','300','yes');return false">
														<i class="glyphicon glyphicon glyphicon-check"></i> Select
												</a></td>
											</tr>


										</tbody>

										<%
											}//}
										%>
									</table>


								</div>


							</div>


						</div>
					</div>
				</div>


				<%
					} else if (checkOn == null) {
				%>

				<div class="alert alert-info">

					A Course Examination Survey year
					<%=year%>
					term
					<%=semester%>
					has been already closed.
				</div>
				<%
					} else {
				%>
				<div class="alert alert-info">A Course Examination Survey has
					been already closed.</div>
				<%
					}
					} else {
				%>

				<div class="alert alert-info">A Course Examination Survey is
					not open.</div>

				<%
					}
				%>
				<script type="text/javascript">
					var win = null;

					function NewWindow(mypage, myname, w, h, scroll) {
						LeftPosition = (screen.width) ? (screen.width - w) / 2
								: 0;
						TopPosition = (screen.height) ? (screen.height - h) / 2
								: 0;
						settings = 'height=' + h + ',width=' + w + ',top='
								+ TopPosition + ',left=' + LeftPosition
								+ ',scrollbars=' + scroll + ',resizable'
						win = window.open(mypage, myname, settings)
					}
				</script>




				<div class="row">
					<div class="box col-md-12">
						<div class="box-inner">
							<div class="box-header well" data-original-title="">
								<h2>
									<i class="glyphicon glyphicon-th"></i> Examination
								</h2>

								<div class="box-icon">
									<a href="#settingforexaminationteacher"
										class="btn btn-setting btn-round btn-default"
										data-toggle="modal"><i class="glyphicon glyphicon-cog"></i></a>
									<a href="#" class="btn btn-minimize btn-round btn-default"><i
										class="glyphicon glyphicon-chevron-up"></i></a>
								</div>
							</div>
							<div class="box-content">
								<div id="DataTables_Table_0_wrapper" class="dataTables_wrapper"
									role="grid">
									<table aria-describedby="DataTables_Table_0_info"
										id="DataTables_Table_0"
										class="table table-striped table-bordered bootstrap-datatable datatable responsive dataTable">
										<thead>

											<tr>
												<th>รหัสรายวิชา</th>
												<th>ชื่อรายวิชา</th>
												<th>อาจารย์ผู้ประสานงาน</th>
												<th>อาจารย์ผู้ช่วยสอน</th>
												<th>กลางภาค</th>
												<th>ปลายภาค</th>

											</tr>
										</thead>
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
												}else{
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
										<%
											String Syear = "";
											String Sterm = "";
											if (null == (String) session.getAttribute("ExaminationYear")) {
												Syear = (String) session.getAttribute("academicyear");
												Sterm = (String) session.getAttribute("academicterm");
											} else if (null != (String) session.getAttribute("ExaminationYear")) {
												Syear = (String) session.getAttribute("ExaminationYear");
												Sterm = (String) session.getAttribute("ExaminationTerm");
											} else {
												Syear = null;
												Sterm = null;
											}
										%>



										<%
											stmt = con.createStatement();
											String qeString = "SELECT * FROM section inner join candidate inner join currentcourse inner join course where userID = '"
													+ strUserID
													+ "' and currentcourse.courseCode = course.courseCode and section.currentcourseID = currentcourse.currentcourseID and currentcourse.year = '"
													+ Syear
													+ "' and currentcourse.semester = '"
													+ Sterm
													+ "'  and  section.sectionID = candidate.sectionID and candidate.teachtype = 'Lect'group by course.courseCode;";
											ResultSet rsExamResult = stmt.executeQuery(qeString);
											String midType = null;
											String finalType = null;
											String reasonMid = null;
											String reasonFinal = null;
											String courseCode = null;
											String userType = null;
											

											
										%>
										<tbody>
											
											<%while (rsExamResult.next()) { %>
											<tr>
												<td>
													<%
														
															courseCode = rsExamResult.getString("course.courseCode");
															out.print(courseCode);
													%>
												</td>
												<td>
													<%
														out.print(rsExamResult.getString("course.courseName"));
													%>
												</td>
												<td>
													<%
														// get co-course
															stmt = con.createStatement();
															String QueryStringCoCourse = "SELECT * FROM section inner join candidate inner join currentcourse inner join course inner join user where currentcourse.courseCode = course.courseCode and section.currentcourseID = currentcourse.currentcourseID and currentcourse.year = '"
																	+ Syear
																	+ "' and currentcourse.semester = '"
																	+ Sterm
																	+ "'  and  section.sectionID = candidate.sectionID and currentcourse.courseco_userID = user.userID and  user.userID = candidate.userID and currentcourse.courseCode = '"
																	+ courseCode + "' group by currentcourse.courseCode ;";
															ResultSet rsCoCourse = stmt.executeQuery(QueryStringCoCourse);
															while (rsCoCourse.next()) {
																out.print("-" + rsCoCourse.getString("user.firstname")
																		+ " " + rsCoCourse.getString("user.lastname"));

															}
													%>
												</td>

												<td>
													<%
														// TO Get teacher assistance
															stmt = con.createStatement();
															String sql = "SELECT * FROM candidate  inner join user inner join currentcourse inner join section  on user.userID = candidate.userID and user.usertype ='Teacher Assistance' and currentcourse.year = '"
																	+ Syear
																	+ "' and currentcourse.semester ='"
																	+ Sterm
																	+ "'  and currentcourse.currentcourseID = section.currentcourseID and section.sectionID = candidate.sectionID ;";
															ResultSet rsta = stmt.executeQuery(sql);
															// Check form db who is teacher assistance.
															// Loop only teacher assisstance.
															while (rsta.next()) {
																String courseTA = rsta
																		.getString("currentcourse.courseCode");
																if (courseTA.equals(courseCode)) {
																	out.println(" - Ajarn "
																			+ rsta.getString("user.firstname") + " "
																			+ rsta.getString("user.lastname") + "<br>");
																}
															}
													%>
												</td>

												<td>
													<%
														
													// Midterm
													stmt = con.createStatement();
															String examType = "SELECT * FROM examsurvey where courseCode = '"+courseCode+"' and year = '"+Syear+"' and semester = '"+Sterm+"' ;";
															ResultSet rs = stmt.executeQuery(examType);
															
															while (rs.next()) {

																String checkExamID = rs.getString("examSurveyID");
																String course = rs.getString("courseCode");
																

																if (course.equals(courseCode)) {
																	midType = rs.getString("midtermType");
																	reasonMid = rs.getString("reasonMid");
																	if (midType != null) {

																		if (midType.equals("Not have")) {

																			out.print("No exam : Reason : " + reasonMid);

																		} else if (midType.equals("MD")) {
																			out.print("Multiple choice , Writting");

																		} else {

																			if (midType.equals("Writing")) {

																				out.print("Writing");

																			} else if (midType.equals("Multiple Choice")) {

																				out.print("Multiple Choice");

																			} else if (midType.equals("Off Schedule")) {

																				out.print("Off Schedule :" +reasonMid);

																			}
																		}
																	}
																}

															}
													%>

												</td>


												<td>
													<%
														stmt = con.createStatement();
															String examType2 = "SELECT * FROM examsurvey where courseCode = '"+courseCode+"' and year = '"+Syear+"' and semester = '"+Sterm+"';";
															ResultSet rs2 = stmt.executeQuery(examType2);
															while (rs2.next()) {

																String checkExamID = rs2.getString("examSurveyID");
																String course = rs2.getString("courseCode");

																if (course.equals(courseCode)) {
																	finalType = rs2.getString("finalType");
																	reasonFinal = rs2.getString("reasonFinal");
																	if (finalType != null) {

																		if (finalType.equals("Not have")) {

																			out.print("No exam : Reason : " + reasonFinal);

																		} else if (finalType.equals("MD")) {
																			out.print("Multiple choice , Writting");

																		} else {

																			if (finalType.equals("Writing")) {

																				out.print("Writing");

																			} else if (finalType.equals("Multiple Choice")) {

																				out.print("Multiple Choice");

																			} else if (finalType.equals("Off Schedule")) {

																				out.print("Off Schedule : "+reasonFinal );

																			}
																		}
																	}
																}
															}
													%>
												</td>


											</tr>
	<%
											}
										%>
										</tbody>

									









									</table>
								</div>
							</div>
						</div>
					</div>
					<!--/span-->
				</div>

			</div>


			<!--/fluid-row-->

			<!-- Ad, you can remove it -->

			<!-- Ad ends -->

			<hr>

			<div class="modal fade" id="settingforexaminationteacher"
				tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
				aria-hidden="true">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal">×</button>
							<h3>Setting Examination Year</h3>
						</div>
						<div class="modal-body">
							<form method="post"
								action="Teacher_Examination_SetYearSemester.jsp"
								role="setyeartermform" id="setyeartermform">
								<label for="Year">Year</label> <select id="examinationyear"
									name="examinationyear">
									<script>
										var myDate = new Date();
										var year = myDate.getFullYear() + 543;
										for (var i = year + 1; i > 2540; i--) {
											document
													.write('<option value="'+i+'">'
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
				Â© <a href="http://usman.it" target="_blank">Muhammad Usman</a> 2012
				- 2014
			</p>

			<p class="col-md-3 col-sm-3 col-xs-12 powered-by">
				Powered by: <a href="http://usman.it/free-responsive-admin-template">Charisma</a>
			</p>
			</footer>

		</div>
		<!--/.fluid-container-->

		<!-- external javascript -->

		<script src="bower_components/bootstrap/dist/js/bootstrap.min.js">
			
		</script>

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