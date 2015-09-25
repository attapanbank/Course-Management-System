<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.sql.*"%>

<%@page import="java.io.InputStream"%>
<%@page import="java.util.Properties"%>
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
			<a class="navbar-brand" href="index.html"> <span>IT:CMS</span></a>
			<!-- user dropdown starts -->
			<div class="btn-group pull-right">
				<button class="btn btn-default dropdown-toggle"
					data-toggle="dropdown">
					<%
						String sFirstname = String.valueOf(session
								.getAttribute("sFirstname"));
						String sLastname = String
								.valueOf(session.getAttribute("sLastname"));
					%>
					<i class="glyphicon glyphicon-user"></i><span
						class="hidden-sm hidden-xs"> <%
 	out.print(sFirstname);
 %>
					</span> <span class="caret"></span>
				</button>
				<ul class="dropdown-menu">
					<li><a href="Teacher_Profile.jsp">Profile</a></li>
					<li class="divider"></li>
					<li><a href="login.html">Logout</a></li>
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


				<div>
					<ul class="breadcrumb">
						<li><a href="#">Home</a></li>
						<li><a href="#">Examination</a></li>
					</ul>
				</div>



				<div class="row">
					<div class="box col-md-12">
						<div class="box-inner">
							<div class="box-header well" data-original-title="">
								<h2>
									<i class="glyphicon glyphicon-star-empty"></i> Examination
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
										String QueryStringExamDb = "SELECT * FROM cms.examsurvey where userID = '"
												+ strUserID + "'";
										ResultSet rsOut = stmt.executeQuery(QueryStringExamDb);

										while (rsOut.next()) {
											examCourse = rsOut.getString("courseCode");

										}
									%>

									<%
										stmt = con.createStatement();
										String QueryStringExam = "SELECT * FROM cms.section inner join cms.candidate inner join cms.currentcourse inner join cms.course where userID = '"
												+ strUserID
												+ "' and currentcourse.courseCode = course.courseCode and section.currentcourseID = currentcourse.currentcourseID and currentcourse.year = '2556' and currentcourse.semester = '1'  and  section.sectionID = candidate.sectionID and candidate.teachtype = 'Lect';";
										ResultSet rsExam = stmt.executeQuery(QueryStringExam);
										String sCosCode = null;
										String sCosName = null;
										String year = "2556";
										String semester = "1";
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

										<%
											while (rsExam.next()) {
										%>



										<tbody aria-relevant="all" aria-live="polite" role="alert">


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
												<td>Teacher Assistance</td>

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


				<%
					stmt = con.createStatement();
					String qeString = "SELECT * FROM examsurvey INNER JOIN course  WHERE examsurvey.courseCode = course.courseCode AND examsurvey.userID = '"
							+ strUserID + "' ;";
					ResultSet rsExamResult = stmt.executeQuery(qeString);
				%>

				<div class="row">
					<div class="box col-md-12">
						<div class="box-inner">
							<div class="box-header well" data-original-title="">
								<h2>
									<i class="glyphicon glyphicon-th"></i> Examination
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
								<div id="DataTables_Table_0_wrapper" class="dataTables_wrapper"
									role="grid">
									<table aria-describedby="DataTables_Table_0_info"
										id="DataTables_Table_0"
										class="table table-striped table-bordered bootstrap-datatable datatable responsive dataTable">
										<thead>

											<tr>
												<th>Course Code</th>
												<th>Course Name</th>

												<th>Teaching assistance</th>
												<th>Midterm</th>
												<th>Final</th>

											</tr>
										</thead>

										<%
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


												<td>
													<%
														stmt = con.createStatement();
															String sql = "SELECT * FROM cms.user INNER JOIN course_survey INNER JOIN examsurvey WHERE usertype = 'Teacher Assistance' AND course_survey.userID = user.userID AND examsurvey.userID = '"
																	+ strUserID
																	+ "' AND examsurvey.examSurveyID ='"
																	+ examID + "';";
															ResultSet rsta = stmt.executeQuery(sql);

															while (rsta.next()) {
																String courseTA = rsta
																		.getString("course_survey.courseCode");
																if (courseTA.equals(courseCode)
																		&& rsta.getString("user.userID").equals(
																				rsta.getString("course_survey.userID"))) {
																	out.println("- " + rsta.getString("user.firstname")
																			+ " " + rsta.getString("user.lastname")
																			+ "<br>");
																}
															}
													%>
												</td>
												<%
													midType = rsExamResult.getString("midtermType");
														reasonMid = rsExamResult.getString("reasonMid");
														if (midType != null) {
												%>

												<%
													if (midType.equals("Not have")) {
												%>

												<td>
													<%
														out.print("No exam : Reason : " + reasonMid);
													%>
												</td>
												<%
													} else if (midType.equals("MD")) {
												%>
												<td>Multiple choice , Writting</td>
												<%
													} else {
												%>

												<%
													if (midType.equals("Wriiting")) {
												%>
												<td>Wriiting</td>
												<%
													} else if (midType.equals("Multiple Choice")) {
												%>
												<td>Multiple Choice</td>
												<%
													} else if (midType.equals("Off Schedule")) {
												%>
												<td>Off Schedule</td>
												<%
													}
															}
														}
												%>



												<%
													finalType = rsExamResult.getString("finalType");
														reasonFinal = rsExamResult.getString("reasonFinal");
														if (finalType != null) {
												%>

												<%
													if (finalType.equals("Not have")) {
												%>

												<td>
													<%
														out.print("<b> No exam : Reason :</b> " + reasonFinal);
													%>
												</td>
												<%
													} else if (finalType.equals("MD")) {
												%>
												<td>Multiple choice , Writting</td>
												<%
													} else {
												%>

												<%
													if (finalType.equals("Wriiting")) {
												%>
												<td>Wriiting</td>
												<%
													} else if (finalType.equals("Multiple Choice")) {
												%>
												<td>Multiple Choice</td>
												<%
													} else if (finalType.equals("Off Schedule")) {
												%>
												<td>Off Schedule</td>
												<%
													}
															}
														}
												%>


											</tr>

										</tbody>
										<%
											}
										%>
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

			<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
				aria-labelledby="myModalLabel" aria-hidden="true">

				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal">Ã</button>
							<h3>à¸£à¸²à¸¢à¸¥à¸°à¹à¸­à¸µà¸¢à¸</h3>
						</div>
						<div class="modal-body">
							<!--à¹à¸à¹à¹à¸à¸à¸£à¸à¸à¸µà¹-->
							<table>
								<tr>
									<td><p>à¸£à¸«à¸±à¸ªà¸£à¸²à¸¢à¸§à¸´à¸à¸²:</p></td>
									<td><p>1302305</p></td>
								</tr>
								<tr>
									<td><p>à¸à¸·à¹à¸­à¸£à¸²à¸¢à¸§à¸´à¸à¸²:</p></td>
									<td><p>Network Programing</p></td>
								</tr>
								<tr>
									<td><p>à¸«à¸à¹à¸§à¸¢à¸à¸´à¸:</p></td>
									<td><p>3(2-2-5)</p></td>
								</tr>
								<tr>
									<td><p>Section:</p></td>
									<td><select>
											<option>Section 01</option>
											<option>Section 02</option>
											<option>Section 03</option>
											<option>Section 04</option>
									</select></td>
								</tr>
								<tr>
									<td><p>à¸à¸±à¸à¸¨à¸¶à¸à¸©à¸²à¸ªà¸²à¸à¸²à¸§à¸´à¸à¸²:</p></td>
									<td><p>CS57</p></td>
								</tr>
								<tr>
									<td><p>Lecture:</p></td>
									<td><p>2 hour/lec</p></td>
								</tr>
								<tr>
									<td><p>Lab:</p></td>
									<td><p>2 hour/lab</p></td>
								</tr>
							</table>
						</div>
						<div class="modal-footer">
							<a href="#" class="btn btn-default" data-dismiss="modal">Close</a>
							<a href="#" class="btn btn-primary" data-dismiss="modal">Select</a>
						</div>
					</div>
				</div>
			</div>

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