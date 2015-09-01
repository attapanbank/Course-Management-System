<%@ page contentType="text/html; charset=utf-8" language="java"
	import="java.sql.*" errorPage=""%>

<%@page import="java.io.InputStream"%>
<%@page import="java.util.Properties"%>

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
<title>Course Form</title>
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

<script type="text/javascript">
	//check null or blank
	function checkaddcourseplanform() {
		var major = document.getElementById("major").value;
		var numberofstudent = document.getElementById("numberofstudent").value;
		var selectcourse = document.getElementById("selectcourse").value;
		if (!major) {
			swal("Please Input Major.");
		} else if (!numberofstudent) {
			swal("Please Input Number of student.");
		} else if (!selectcourse) {
			swal("Please select course.");
		} else {
			document.getElementById("AddcourseplanForm").submit();
		}
	}

	//check press enter
	$(function() {

		$('#major').keypress(function(event) {
			if (event.which == 13) {
				checkaddcourseplanform()
			}
		});

		$('#numberofstudent').keypress(function(event) {
			if (event.which == 13) {
				checkaddcourseplanform()
			}
		});
	});
</script>

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
							<li><a class="ajax-link" href="Admin_Candidate.jsp"><i
									class="glyphicon glyphicon-align-justify"></i><span>
										Candidate</span></a></li>
							<li class="active"><a class="ajax-link"
								href="Admin_CoursePlan.jsp"><i
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
						<li><a href="Admin_CoursePlan.jsp">Course Plan</a></li>
						<li>Course Plan Add Form</li>
					</ul>
				</div>

				<div class="row">
					<div class="box col-md-12">

						<div class="box col-md-6">
							<div class="box-inner">
								<div class="box-header well" data-original-title="">
									<h2>
										<i class="glyphicon glyphicon-edit"></i> Add Course to
										CoursePlan
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
								<div class="box-content" align="center">
									<form method="post"
										action="Admin_CoursePlan_AddInformation.jsp"
										role="selectcourseform" id="AddcourseplanForm"
										autocomplete="off">
										<table>
											<tr>
												<td style="text-align: right"><label for="Year">Year</label>
													<select id="year" name="year">
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
												</select></td>
												<td><label for="Term">Term</label> <select id="term"
													name="term">
														<option value="1">1</option>
														<option value="2">2</option>
												</select></td>
											</tr>
											<tr>
												<td style="text-align: right">Major :</td>
												<td><input type="text" id="major" name="major" /></td>
											</tr>
											<tr>
												<td style="text-align: right">Number of Students :</td>
												<td><input type="text" id="numberofstudent"
													name="numberofstudent" value="0" /></td>
											</tr>
											<tr>
												<td colspan="2"></td>
											</tr>
										</table>
										<%
											stmt = con.createStatement();
											String QueryString1301 = "SELECT * from course where courseCode like '1301%' order by courseCode";
											String QueryString1302 = "SELECT * from course where courseCode like '1302%' order by courseCode";
											String QueryString1305 = "SELECT * from course where courseCode like '1305%' order by courseCode";
											String QueryString1306 = "SELECT * from course where courseCode like '1306%' order by courseCode";
											String QueryString1501 = "SELECT * from course where courseCode like '1501%' order by courseCode";
											String QueryString1502 = "SELECT * from course where courseCode like '1502%' order by courseCode";
										%>

										<select data-placeholder="Select Course" id="selectcourse"
											name="selectcourse" data-rel="chosen">
											<option value=""></option>
											<optgroup label="Information Technology">
												<%
													ResultSet rs1301 = stmt.executeQuery(QueryString1301);
													while (rs1301.next()) {
												%>
												<option style="text-align: left;">
													<%
														out.print(rs1301.getString("courseCode"));
													%>
													<%
														out.print(rs1301.getString("courseName"));
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
												<option style="text-align: left;">
													<%
														out.print(rs1302.getString("courseCode"));
													%>
													<%
														out.print(rs1302.getString("courseName"));
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
												<option style="text-align: left;">
													<%
														out.print(rs1305.getString("courseCode"));
													%>
													<%
														out.print(rs1305.getString("courseName"));
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
												<option style="text-align: left;">
													<%
														out.print(rs1306.getString("courseCode"));
													%>
													<%
														out.print(rs1306.getString("courseName"));
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
												<option style="text-align: left;">
													<%
														out.print(rs1501.getString("courseCode"));
													%>
													<%
														out.print(rs1501.getString("courseName"));
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
												<option style="text-align: left;">
													<%
														out.print(rs1502.getString("courseCode"));
													%>
													<%
														out.print(rs1502.getString("courseName"));
													%>
												</option>
												<%
													}
												%>
											</optgroup>
										</select><br> <br> <input type="button"
											id="submitaddcourplanbtn" onclick="checkaddcourseplanform()"
											class="btn btn-success" value="Submit" />
									</form>
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
			<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
				aria-labelledby="myModalLabel" aria-hidden="true">
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
			<footer class="row">
			<p class="col-md-9 col-sm-9 col-xs-12 copyright">
				© <a href="http://usman.it" target="_blank">Muhammad Usman</a> 2012
				- 2014
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