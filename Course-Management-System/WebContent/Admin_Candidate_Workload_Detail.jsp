<%@ page language="java" contentType="text/html; charset=utf-8"
	import="java.sql.*" pageEncoding="utf-8"%>

<%@page import="java.io.InputStream"%>
<%@page import="java.util.Properties"%>
<%@page import="java.util.ArrayList"%>

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

	<%
		// Get teacher name
		String userID = request.getParameter("userID");
		String year = request.getParameter("year");
		String term = request.getParameter("term");
		String courseCode = null;
		stmt = con.createStatement();
		String QueryName = "SELECT * FROM user where userID = '" + userID
				+ "' ;";
		ResultSet rsname = stmt.executeQuery(QueryName);
		if (rsname.next()) {
			out.println("<div align=" + "center" + "><font size=" + 6 + ">"
					+ rsname.getString("user.firstname") + " "
					+ rsname.getString("user.lastname") + " </font></div>");
			//courseCode = rsname.getString("examsurvey.courseCode");
		}
	%>
	<br>
	<br>

	<%
		stmt = con.createStatement();
		String courseFinal = "SELECT * FROM section inner join candidate inner join currentcourse inner join course where userID = '"
				+ userID
				+ "' and currentcourse.courseCode = course.courseCode and section.currentcourseID = currentcourse.currentcourseID and currentcourse.year = '"
				+ year
				+ "' and currentcourse.semester = '"
				+ term
				+ "'  and  section.sectionID = candidate.sectionID  group by currentcourse.courseCode;";
		ResultSet rsFinal = stmt.executeQuery(courseFinal);
	%>


	<table
		class="table table-striped table-bordered bootstrap-datatable datatable responsive">
		<thead>
			<tr>

				<th>รหัสรายวิชา</th>
				<th>ชื่อรายวิชา</th>
				<th>หน่วยกิจ</th>

				<th>of Lec</th>
				<th>of Lecturers</th>
				<th>of Lab</th>
				<th>of Lecturers</th>
				<th>Hour</th>
				<th>Workload</th>
			</tr>
		</thead>

		<%
			while (rsFinal.next()) {

				String credit = null;
		%>
		<tbody>

			<tr>
				<td>
					<%
						String courseCode2 = rsFinal.getString("course.courseCode");
							out.print(courseCode2);
					%>
				</td>


				<td>
					<%
						String courseName = rsFinal.getString("course.courseName");

							out.print(rsFinal.getString("course.courseName"));
					%>
				</td>
				<td>
					<%
						out.print(rsFinal.getString("course.Credit"));
					%>
				</td>

				<%
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

						int of_lec = 0;
						int of_lecturers = 0;
						int of_lab = 0;
						int of_lablecturers = 0;
				%>

				<td>
					<%
						// หาจำนวน section lect ที่ สอนในวิชานั้น															
							if (courseName.equalsIgnoreCase("Senior Project 2")
									|| courseName
											.equalsIgnoreCase("Co-operative Education")
									|| courseName.equalsIgnoreCase("Senior Project 1")) {

							} else {

								if (lect_of_hour == 0) {
									out.print(lect_of_hour);
								} else {

									stmt = con.createStatement();
									String qOfLec = "SELECT * FROM section inner join candidate inner join currentcourse inner join course where userID = '"
											+ userID
											+ "' and currentcourse.courseCode = course.courseCode and section.currentcourseID = currentcourse.currentcourseID and currentcourse.year = '"
											+ year
											+ "' and currentcourse.semester = '"
											+ term
											+ "' and  section.sectionID = candidate.sectionID and candidate.teachtype = 'Lect' and currentcourse.courseCode = '"
											+ courseCode2
											+ "'  group by section.sectionlect   ";
									ResultSet rsOfLec = stmt.executeQuery(qOfLec);
									rsOfLec.last();
									of_lec = rsOfLec.getRow();
									System.out.print(of_lec);
									//of_lec = rsOfLec.getInt("rowcount");
									out.print(of_lec);

								}
							}
					%>
				</td>

				<td>
					<%
						// หาจำนวน อ. ท่ีสอนใน Lect นั้น
							stmt = con.createStatement();
							String qOfLectures = "SELECT * FROM section inner join candidate inner join currentcourse inner join course where currentcourse.courseCode = course.courseCode and section.currentcourseID = currentcourse.currentcourseID and currentcourse.year = '"
									+ year
									+ "' and currentcourse.semester = '"
									+ term
									+ "' and  section.sectionID = candidate.sectionID and candidate.teachtype = 'Lect' and currentcourse.courseCode = '"
									+ courseCode2
									+ "' and candidate.userID = '"
									+ userID
									+ "' group by candidate.userID ";
							ResultSet rsOfLectures = stmt.executeQuery(qOfLectures);

							rsOfLectures.last();
							of_lecturers = rsOfLectures.getRow();
							out.print(of_lecturers);
					%>
				</td>
				<td>
					<%
						// หาจำนวน section lab ที่ สอนในวิชานั้น		

							if (courseName.equalsIgnoreCase("Senior Project 2")
									|| courseName
											.equalsIgnoreCase("Co-operative Education")
									|| courseName.equalsIgnoreCase("Senior Project 1")) {

							} else {

								if (lab_of_hour == 0) {
									out.print(lab_of_hour);
								} else {

									stmt = con.createStatement();
									String qOfLec = "SELECT COUNT(*) AS rowcount FROM section inner join candidate inner join currentcourse inner join course where userID = '"
											+ userID
											+ "' and currentcourse.courseCode = course.courseCode and section.currentcourseID = currentcourse.currentcourseID and currentcourse.year = '"
											+ year
											+ "' and currentcourse.semester = '"
											+ term
											+ "' and  section.sectionID = candidate.sectionID and candidate.teachtype = 'Lab' and currentcourse.courseCode = '"
											+ courseCode2 + "'  ";
									ResultSet rsOfLec = stmt.executeQuery(qOfLec);

									rsOfLec.next();
									of_lab = rsOfLec.getInt("rowcount");
									out.print(of_lab);

								}
							}
					%>
				</td>
				<td>
					<%
						// Check type role teacher

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
										+ year
										+ "' and currentcourse.semester = '"
										+ term
										+ "' and  section.sectionID = candidate.sectionID  and candidate.teachtype = 'Lab' and currentcourse.courseCode = '"
										+ courseCode2
										+ "' and user.usertype = 'Teacher' and candidate.userID = '"
										+ userID + "' group by candidate.userID;  ";
								ResultSet rsOfLec2 = stmt.executeQuery(qOfLecturesLab);
								rsOfLec2.last();
								of_lablecturers = rsOfLec2.getRow();
								while (rsOfLec2.next()) {
									String a = rsOfLec2
											.getString("currentcourse.courseCode");

								}

								out.print(of_lablecturers);

							} else if (userType.equals("Teaching Assistance")) {
								// หาจำนวน อ. ท่ีสอนใน Lab นั้น
								stmt = con.createStatement();
								String qOfLecturesLab = "SELECT * FROM section inner join candidate inner join currentcourse inner join course inner join user where currentcourse.courseCode = course.courseCode and section.currentcourseID = currentcourse.currentcourseID and currentcourse.year = '"
										+ year
										+ "' and currentcourse.semester = '"
										+ term
										+ "' and  section.sectionID = candidate.sectionID  and candidate.teachtype = 'Lab' and currentcourse.courseCode = '"
										+ courseCode2
										+ "' and user.usertype = 'Teaching Assistance' and candidate.userID = '"
										+ userID + "'  group by candidate.userID;  ";
								ResultSet rsOfLec2 = stmt.executeQuery(qOfLecturesLab);
								rsOfLec2.last();
								of_lablecturers = rsOfLec2.getRow();
								while (rsOfLec2.next()) {
									String a = rsOfLec2
											.getString("currentcourse.courseCode");

								}

								out.print(of_lablecturers);

							}
					%>
				</td>
				<td>
					<%
						// รวมชั่วโมงต่อสัปดา	
							if (courseName.equalsIgnoreCase("Senior Project 2")
									|| courseName
											.equalsIgnoreCase("Co-operative Education")
									|| courseName.equalsIgnoreCase("Senior Project 1")) {
								out.print("0.00");

							} else {

								int of_lec_all_hour = 0;
								int of_lab_all_hour = 0;
								of_lec_all_hour = lect_of_hour * of_lec;
								of_lab_all_hour = lab_of_hour * of_lab;

								int hourAll = of_lec_all_hour + of_lab_all_hour;
								out.print(hourAll);
							}
					%>
				</td>
				<td class="center">
					<%
						// Count the same course
							String courseStack = null;
							int count = 0;
							stmt = con.createStatement();
							String findthecourse = "SELECT * FROM section inner join candidate inner join currentcourse inner join course where userID = '"
									+ userID
									+ "' and currentcourse.courseCode = course.courseCode and section.currentcourseID = currentcourse.currentcourseID and currentcourse.year = '"
									+ year
									+ "' and currentcourse.semester = '"
									+ term
									+ "' and  section.sectionID = candidate.sectionID and candidate.teachtype = 'Lect'and currentcourse.courseCode = '"
									+ courseCode2 + "' group by section.sectionlect ;";
							ResultSet rsfindCourse = stmt.executeQuery(findthecourse);
							while (rsfindCourse.next()) {
								courseStack = rsfindCourse.getString("course.courseName");
								count++;
							}

							//double wlLect = 0;
							//double wlLab = 0;
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
									out.print(finalResult);

									// IF LECT NOT HAVE LECTURERS BUT LAB HAVE LECTURERS
								} else if (of_lecturers == 0 && of_lablecturers != 0) {
									// Cal Lab wl
									workloadLab = (of_lab * lab_of_hour * 0.5)
											/ of_lablecturers;

									Sumworkload = workloadLab + workloadLectSum;

									String finalResult = String.format("%.2f", Sumworkload);
									out.print(finalResult);

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
									out.print(finalResult);
								}
								// IF LECT AND LAB NOT CALCULATE
								else if (of_lecturers == 0 && of_lablecturers == 0) {
									Sumworkload = workloadLab + workloadLectSum;

									String finalResult = String.format("%.2f", Sumworkload);
									out.print(finalResult);

								}

							} catch (ArithmeticException e) {
								out.print(e);
							} catch (NumberFormatException e) {
								out.print(e);
							} catch (Exception e) {
								out.print(e);
							}
							// การคิดคำนวณ workload แบบผิด
							/* try {

								

								if (of_lecturers != 0 && of_lablecturers != 0) {

									// Extra Lect
									if (of_lec >= 2) {
										wlLect = (of_lec * lect_of_hour)
												/ of_lecturers;
										// for lecture
										wlLect = (of_lec * lect_of_hour * 0.75)
												/ of_lecturers;
									} else {
										wlLect = (of_lec * lect_of_hour) / of_lecturers;
									}

									// for lab

									wlLab = (of_lab * lab_of_hour * 0.5) / of_lablecturers;

									double result = wlLab + wlLect;
									String finalResult = String.format("%.2f", result);
									out.print(finalResult);

								} else if (of_lecturers == 0 && of_lablecturers != 0) {
									// for lab
									wlLab = (of_lab * lab_of_hour * 0.5) / of_lablecturers;

									double result = wlLab + wlLect;
									String finalResult = String.format("%.2f", result);
									out.print(finalResult);

								} else if (of_lecturers != 0 && of_lablecturers == 0) {
									if (of_lec >= 2) {
										// for lecture
										wlLect = (of_lec * lect_of_hour * 0.75)
												/ of_lecturers;
									} else {
										wlLect = (of_lec * lect_of_hour) / of_lecturers;
									}

									double result = wlLab + wlLect;
									String finalResult = String.format("%.2f", result);
									out.print(finalResult);
								} else if (of_lecturers == 0 && of_lablecturers == 0) {
									// no calculate
									double result = wlLab + wlLect;

									String finalResult = String.format("%.2f", result);
									out.print(finalResult);

								}
							} catch (ArithmeticException e) {
								out.print(e);
							} catch (NumberFormatException e) {
								out.print(e);
							} catch (Exception e) {
								out.print(e);
							} */
					%>
				</td>

			</tr>

		</tbody>

		<%
			}
		%>
	</table>

	<div align="center">
		<button class="btn btn-danger" onclick="window.close()">Close</button>
	</div>

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