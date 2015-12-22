<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="java.sql.*"%>

<%@page import="java.io.InputStream"%>
<%@page import="java.util.Properties"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page import="java.io.*,java.util.Locale"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>

<meta charset="utf-8">
<title>Course Survey</title>
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
					<%
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
					<i class="glyphicon glyphicon-user"></i><span
						class="hidden-sm hidden-xs"> <%
 	out.print(sFirstname);
 %>
					</span> <span class="caret"></span>
				</button>
				<ul class="dropdown-menu">
					<li><a href="Teacher_Assistance_Profile.jsp">Profile</a></li>
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
							<li><a class="ajax-link" href="Teacher_Assistance_News.jsp"><i
									class="glyphicon glyphicon-home"></i><span> News</span></a></li>
							<li class="nav-header hidden-md">Management</li>
							<li><a class="ajax-link" href="Teacher_Assistance_Workload.jsp"><i
									class="glyphicon glyphicon-align-justify"></i><span>
										Workload</span></a></li>
							<li class="active"><a class="ajax-link"
								href="Teacher_Assistance_Course.jsp"><i
									class="glyphicon glyphicon-align-justify"></i><span>
										Course</span></a></li>
							

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
					stmt = con.createStatement();

					String QueryString = "select * from courseplan_checksurvey where checksurvey = 'ON' order by semester";
					ResultSet rsCheck = stmt.executeQuery(QueryString);

					String on = null;
					int year = 0;
					int semester = 0;

					while (rsCheck.next()) {
						on = rsCheck.getString("checksurvey");
						year = rsCheck.getInt("year");
						semester = rsCheck.getInt("semester");

						session.setAttribute("sYear", year);
						session.setAttribute("sSemester", semester);
					}
				%>


				<%
					if (on != null) {
						if (on.equals("ON")) {
				%>

				<div class="row">
					<div class="box col-md-12">
						<div class="box-inner">
							<div class="box-header well" data-original-title="">
								<h2>
									<i class="glyphicon glyphicon-star-empty"></i> Course Select

									<%
										if (year != 0 && semester != 0) {
									%>
									Year :
									<%
										out.print(year);
									%>
									Term :
									<%
										out.print(semester);
												}
									%>
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
							<div class="box-content" style="display: block;">
								<!-- put your content here -->


								<%
									String QueryString1301 = "SELECT * FROM course INNER JOIN courseplan WHERE course.courseCode = courseplan.courseCode AND course.courseCode LIKE '1301%' AND courseplan.year='"
													+ year
													+ "' and courseplan.semester='"
													+ semester
													+ "' GROUP BY course.courseCode;";
											String QueryString1302 = "SELECT * FROM course INNER JOIN courseplan WHERE course.courseCode = courseplan.courseCode AND course.courseCode LIKE '1302%' AND courseplan.year='"
													+ year
													+ "' and courseplan.semester='"
													+ semester
													+ "' GROUP BY course.courseCode;";
											String QueryString1305 = "SELECT * FROM course INNER JOIN courseplan WHERE course.courseCode = courseplan.courseCode AND course.courseCode LIKE '1305%' AND courseplan.year='"
													+ year
													+ "' and courseplan.semester='"
													+ semester
													+ "' GROUP BY course.courseCode;";
											String QueryString1306 = "SELECT * FROM course INNER JOIN courseplan WHERE course.courseCode = courseplan.courseCode AND course.courseCode LIKE '1306%' AND courseplan.year='"
													+ year
													+ "' and courseplan.semester='"
													+ semester
													+ "' GROUP BY course.courseCode;";
											String QueryString1501 = "SELECT * FROM course INNER JOIN courseplan WHERE course.courseCode = courseplan.courseCode AND course.courseCode LIKE '1501%' AND courseplan.year='"
													+ year
													+ "' and courseplan.semester='"
													+ semester
													+ "' GROUP BY course.courseCode;";
											String QueryString1502 = "SELECT * FROM course INNER JOIN courseplan WHERE course.courseCode = courseplan.courseCode AND course.courseCode LIKE '1502%' AND courseplan.year='"
													+ year
													+ "' and courseplan.semester='"
													+ semester
													+ "' GROUP BY course.courseCode;";
								%>



								<form action="Teacher_Save_Survey.jsp" method="post" id="myform">
									<div class="center">
										<div class="control-group">
											<label class="control-label" for="selectError2">Select
												course <%
												out.print(on);
											%>
											</label>
											<div class="controls">
												<select name="courseSelect"
													data-placeholder="Select course that your need to teach"
													id="selectError2" >
													<optgroup label="Information Technology">
														<%
															ResultSet rs1301 = stmt.executeQuery(QueryString1301);
																	while (rs1301.next()) {
														%>
														<option>
															<%
																out.print(rs1301.getString("course.courseName"));
															%>
														</option>
														<%
															}
														%>
													</optgroup>
													<optgroup label="Computer Science">
														<%
															ResultSet rs1302 = stmt.executeQuery(QueryString1302);
																	while (rs1302.next()) {
														%>
														<option>
															<%
																out.print(rs1302.getString("course.courseName"));
															%>
														</option>
														<%
															}
														%>
													</optgroup>
													<optgroup label="Software Engineering">
														<%
															ResultSet rs1305 = stmt.executeQuery(QueryString1305);
																	while (rs1305.next()) {
														%>
														<option>
															<%
																out.print(rs1305.getString("course.courseName"));
															%>
														</option>
														<%
															}
														%>
													</optgroup>

													<optgroup label="Multimedia Technology and Animation">
														<%
															ResultSet rs1306 = stmt.executeQuery(QueryString1306);
																	while (rs1306.next()) {
														%>
														<option>
															<%
																out.print(rs1306.getString("course.courseName"));
															%>
														</option>
														<%
															}
														%>
													</optgroup>
													<optgroup label="Computer Engineering">
														<%
															ResultSet rs1501 = stmt.executeQuery(QueryString1501);
																	while (rs1501.next()) {
														%>
														<option>
															<%
																out.print(rs1501.getString("course.courseName"));
															%>
														</option>
														<%
															}
														%>
													</optgroup>
													<optgroup label="Information and Communication Engineering">
														<%
															ResultSet rs1502 = stmt.executeQuery(QueryString1502);
																	while (rs1502.next()) {
														%>
														<option>
															<%
																out.print(rs1502.getString("course.courseName"));
															%>
														</option>
														<%
															}
														%>
													</optgroup>

												</select><br> <br>
												<div class="center">
													<input type="submit" class="btn btn-success"
														onclick="submitRunAjax();"
														class="glyphicon glyphicon glyphicon-check" value="Select">
												</div>


											</div>


										</div>
									</div>
								</form>





							</div>
						</div>
					</div>

					<%
						} else if (on.equals("OFF")) {
					%>
					<div class="alert alert-info">
						<button type="button" class="close" data-dismiss="alert">&times;</button>

						<strong> Course survey has been close. !</strong> Please wait
						openning course survey.
					</div>
					<%
						}
					%>
					<%
						} else {
					%>
					<div class="alert alert-info">
						<button type="button" class="close" data-dismiss="alert">&times;</button>
						<strong> Course survey is not open !</strong> Please wait openning
						course survey.<%
							
						%>

					</div>
					<%
						}
					%>

					<%
						if (on != null) {
							if (on.equals("ON")) {
					%>

					<div class="box col-md-6">
						<div class="box-inner">
							<div class="box-header well" data-original-title="">
								<h2>
									<i class="glyphicon glyphicon-star-empty"></i> Your select
									Course
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
								<!-- put your content here -->


								<table
									class="table table-striped table-bordered bootstrap-datatable datatable responsive">
									<thead>
										<tr role="row">
											<th>Course Code</th>
											<th>Course Name</th>
											<th>Action</th>
										</tr>
									</thead>

									<tbody>

										<%
											String cos = null;
													String cosCo = null;
													String cosCe = null;

													String QueryString_selectCourse = "SELECT * FROM course_survey where userID = '"
															+ strUserID
															+ "' and year = '"
															+ year
															+ "' and semester = '" + semester + "';";

													ResultSet rsSelectCourse = stmt
															.executeQuery(QueryString_selectCourse);
										%>
										<%
											if (strUserID != null) {
														while (rsSelectCourse.next()) {
										%>
										<tr>
											<td>
												<%
													cosCo = rsSelectCourse.getString("courseCode");
																	out.print(cosCo);
												%>
											</td>
											<td>
												<%
													cos = rsSelectCourse.getString("courseName");
																	out.print(cos);
												%>
											</td>

											<td><a class="btn btn-danger confirmation"
												href="Teacher_Delete_Course_Session.jsp?coursesurveyID=<%out.print(rsSelectCourse
									.getString("coursesurveyID"));%>">
													<i class="glyphicon glyphicon-trash icon-white"></i> Delete
											</a></td>
										</tr>
										<%
											}
													}
										%>


									</tbody>
								</table>


								<!-- put your content here -->
								<div align="center"></div>


							</div>

						</div>
					</div>

					<script type="text/javascript">
						var elems = document
								.getElementsByClassName('confirmation');
						var confirmIt = function(e) {
							if (!confirm('Are you sure to delete?'))
								e.preventDefault();
						};
						for (var i = 0, l = elems.length; i < l; i++) {
							elems[i]
									.addEventListener('click', confirmIt, false);
						}
					</script>

					<%
						}
					%>

					<%
						} else {
					%>


					<div class="box col-md-12">
						<div class="box-inner">
							<div class="box-header well" data-original-title="">
								<h2>
									<i class="glyphicon glyphicon-star-empty"></i>Course

								</h2>

								<div class="box-icon">
									<a href="#settingforcourseteacher"
										class="btn btn-setting btn-round btn-default"
										data-toggle="modal"><i class="glyphicon glyphicon-cog"></i></a>
									<a href="#" class="btn btn-minimize btn-round btn-default"><i
										class="glyphicon glyphicon-chevron-up"></i></a>
								</div>
							</div>
							<div class="box-content" style="display: block;">
								<!-- put your content here -->
								<div id="DataTables_Table_0_wrapper" class="dataTables_wrapper"
									role="grid">





									<table aria-describedby="DataTables_Table_0_info"
										id="DataTables_Table_0"
										class="table table-striped table-bordered bootstrap-datatable datatable responsive dataTable">
										<thead>
											<tr role="row">
												<th style="width: 100px;" colspan="1" rowspan="2"
													aria-controls="DataTables_Table_0" tabindex="0"
													role="columnheader" class="sorting"
													aria-label="Role: activate to sort column ascending">Course
													Code</th>
												<th style="width: 150px;" colspan="1" rowspan="2"
													aria-controls="DataTables_Table_0" tabindex="0"
													role="columnheader" class="sorting"
													aria-label="Role: activate to sort column ascending">Course
													Name</th>


												


												<th style="width: 150px;" colspan="2" rowspan="1"
													aria-controls="DataTables_Table_0" tabindex="0"
													role="columnheader" class="sorting"
													aria-label="Status: activate to sort column ascending">Section
												</th>
												
												<th style="width: 150px;" colspan="1" rowspan="2"
													aria-controls="DataTables_Table_0" tabindex="0"
													role="columnheader" class="sorting"
													aria-label="Status: activate to sort column ascending">Teach Type</th>



											</tr>

											<tr>

												<td style="width: 150px;" colspan="1" rowspan="1"
													aria-controls="DataTables_Table_0" tabindex="0"
													role="columnheader" class="sorting"
													aria-label="Status: activate to sort column ascending">Lect
												</td>
												<td style="width: 150px;" colspan="1" rowspan="1"
													aria-controls="DataTables_Table_0" tabindex="0"
													role="columnheader" class="sorting"
													aria-label="Status: activate to sort column ascending">Lab
												</td>
											</tr>

										</thead>
										<%
											String strdateterm1_1 = "";
												String strdateterm1_2 = "";
												String strdateterm2_1 = "";
												String strdateterm2_2 = "";

												String academicyear = null;
												String academicterm = null;

												if (null == (String) session.getAttribute("TeacherCourseYear")) {

													Date td = new Date();
													String strtd = new String("");
													SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
													SimpleDateFormat format2 = new SimpleDateFormat(
															"yyyy-MM-dd", new Locale("th"));
													strtd = format.format(td);
													Date today = format.parse(strtd);
													//System.out.println(today);

													/* String[] datetd = strtd.split("-", 3);
													int ydatetd = Integer.parseInt(datetd[0]);
													int mdatetd = Integer.parseInt(datetd[1]);
													int ddatetd = Integer.parseInt(datetd[2]); */

													stmt = con.createStatement();
													String QueryString2 = "SELECT * FROM setsemesterdate WHERE setsemesterdate_ID = '1'";
													ResultSet rs = stmt.executeQuery(QueryString2);
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

														if ((today.before(dateterm1_2) || today
																.equals(dateterm1_2))
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
											<b><i>Year : <%=(String) session
							.getAttribute("TeacherCourseYear")%> Term : <%=(String) session
							.getAttribute("TeacherCourseTerm")%></i></b>
										</p>

										<%
											}
										%>
										<%
											String Syear = "";
												String Sterm = "";
												if (null == (String) session.getAttribute("TeacherCourseYear")) {
													Syear = (String) session.getAttribute("academicyear");
													Sterm = (String) session.getAttribute("academicterm");
												} else if (null != (String) session
														.getAttribute("TeacherCourseYear")) {
													Syear = (String) session.getAttribute("TeacherCourseYear");
													Sterm = (String) session.getAttribute("TeacherCourseTerm");
												} else {
													Syear = null;
													Sterm = null;
												}
										%>

										<%
										String courseFinal = "SELECT * FROM candidate INNER JOIN section ON section.sectionID = candidate.sectionID INNER JOIN currentcourse ON currentcourse.currentcourseID = section.currentcourseID and currentcourse.year = '"
												+ Syear
												+ "' and currentcourse.semester = '"
												+ Sterm
												+ "' INNER JOIN course ON course.courseCode = currentcourse.courseCode WHERE userID = '"
												+ sUserID
												+ "' GROUP BY section.sectionID ORDER BY candidate.teachtype desc;";
										ResultSet rsFinal = stmt.executeQuery(courseFinal);
										stmt = con.createStatement();

												String sCosCode = null;
										%>

										<%
											while (rsFinal.next()) {
										%>
										<tbody aria-relevant="all" aria-live="polite" role="alert">
											<tr>
												<td>
													<%
														sCosCode = rsFinal.getString("course.courseCode");
																out.print(sCosCode);
													%>
												</td>
												<td>
													<%
														out.print(rsFinal.getString("course.courseName"));
													%>
												</td>

												

												<td>
													<%
														out.print(rsFinal.getString("section.sectionlect"));
													%>
												</td>
												<td>
													<%
														out.print(rsFinal.getString("section.sectionlab"));
													%>
												</td>
												
												<td>
													<%
													stmt = con.createStatement();
													String QuerySelect = "SELECT * FROM candidate INNER JOIN section ON section.sectionID = candidate.sectionID INNER JOIN currentcourse ON currentcourse.currentcourseID = section.currentcourseID and currentcourse.year = '"
															+ Syear
															+ "' and currentcourse.semester = '"
															+ Sterm
															+ "' INNER JOIN course ON course.courseCode = currentcourse.courseCode WHERE userID = '"
															+ sUserID
															+ "' AND section.sectionID = '"
															+ rsFinal.getString("section.sectionID")
															+ "' ORDER BY candidate.teachtype desc";
													ResultSet rsselect = stmt.executeQuery(QuerySelect);

													while (rsselect.next()) {
														out.println("- "
																+ rsselect.getString("candidate.teachtype")
																+ "<br>");
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
							<!-- put your content here -->
							<div align="center"></div>


						</div>
					</div>

				</div>
			</div>

			<%
				}
			%>


		</div>
	</div>
	<!--/fluid-row-->

	<!-- Ad, you can remove it -->

	<!-- Ad ends -->

	<hr>

	<div class="modal fade" id="settingforcourseteacher" tabindex="-1"
		role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">×</button>
					<h3>Setting Course Year</h3>
				</div>
				<div class="modal-body">
					<form method="post" action="Teacher_Assistance_Course_Setting_Year.jsp"
						role="setyeartermform" id="setyeartermform">
						<label for="Year">Year</label> <select id="teachercourseyear"
							name="teachercourseyear">
							<script>
								var myDate = new Date();
								var year = myDate.getFullYear() + 543;
								for (var i = year + 1; i > 2540; i--) {
									document.write('<option value="'+i+'">' + i
											+ '</option>');
								}
							</script>
						</select> <label for="Term">Term</label> <select id="teachercourseterm"
							name="teachercourseterm">
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


	<div class="modal fade" id="settingforcoursesurveyteacher"
		tabindex="-1" role="dialog" aria-labelledby="myModalLabel"
		aria-hidden="true">
		<div class="modal-dialog">
			<div class="modal-content">
				<div class="modal-header">
					<button type="button" class="close" data-dismiss="modal">×</button>
					<h3>Setting Course Survey Year</h3>
				</div>
				<div class="modal-body">
					<form method="post" action="Teacher_Assistance_Course_Survey_Setting_Year.jsp"
						role="setyeartermform" id="Asetyeartermform">
						<label for="Year">Year</label> <select id="Ateachercourseyear"
							name="Ateachercourseyear">
							<script>
								var myDate = new Date();
								var year = myDate.getFullYear() + 543;
								for (var i = year + 1; i > 2540; i--) {
									document.write('<option value="'+i+'">' + i
											+ '</option>');
								}
							</script>
						</select> <label for="Term">Term</label> <select id="Ateachercourseterm"
							name="Ateachercourseterm">
							<option value="1">1</option>
							<option value="2">2</option>
						</select> <br> <a href="#" class="btn btn-default"
							data-dismiss="modal">Close</a> <input type="button"
							class="btn btn-primary" onClick="Asendexaminationsetting()"
							value="Submit" />
					</form>
				</div>
				<div class="modal-footer"></div>
			</div>
		</div>
	</div>

	<script type="text/javascript">
		function Asendexaminationsetting() {
			document.getElementById("Asetyeartermform").submit();
		}
	</script>

	<footer class="row">
	<p class="col-md-9 col-sm-9 col-xs-12 copyright">
		Â© <a href="http://usman.it" target="_blank">Muhammad Usman</a> 2012 -
		2014
	</p>

	<p class="col-md-3 col-sm-3 col-xs-12 powered-by">
		Powered by: <a href="http://usman.it/free-responsive-admin-template">Charisma</a>
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