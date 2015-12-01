<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="java.sql.*"%>
<%@page import="java.io.InputStream"%>
<%@page import="java.util.Properties"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@ page import="java.io.*,java.util.Locale"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
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
<title>Workload</title>
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
<link rel="stylesheet" href="dist/sweetalert.css">
<link rel="stylesheet" href="dist/semantic.css">
<link rel="stylesheet" href="dist/semantic.js">
<link rel="stylesheet" href="dist/semantic.min.css">
<link rel="stylesheet" href="dist/semantic.min.js">
<link rel="stylesheet" href="dist/sweetalert-dev.js">
<link rel="stylesheet" href="dist/components/dropdown.css">
<link rel="stylesheet" href="dist/components/dropdown.js">

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
																		if (sUserID == null) {
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
									class="glyphicon glyphicon-home"></i><span> News</span></a></li>
							<li class="nav-header hidden-md">Management</li>
							<li class="active"><a class="ajax-link"
								href="Teacher_Assistance_Workload.jsp"><i
									class="glyphicon glyphicon-align-justify"></i><span>
										Workload</span></a></li>
							<li><a class="ajax-link" href="Teacher_Assistance_Course.jsp"><i
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


				



				<div class="row">
					<div class="box col-md-12">
						<div class="box-inner">
							<div class="box-header well" data-original-title="">
								<h2>
									<i class="glyphicon glyphicon-star-empty"></i> Workload
								</h2>

								<div class="box-icon">
									<a href="#settingforworkloadteacher"
										class="btn btn-setting btn-round btn-default"
										data-toggle="modal"><i class="glyphicon glyphicon-cog"></i></a>
									<a href="#" class="btn btn-minimize btn-round btn-default"><i
										class="glyphicon glyphicon-chevron-up"></i></a> <a href="#"
										class="btn btn-close btn-round btn-default"><i
										class="glyphicon glyphicon-remove"></i></a>
								</div>
							</div>
							<div class="box-content" style="display: block;">
								<!-- put your content here -->
								<div id="DataTables_Table_0_wrapper" class="dataTables_wrapper"
									role="grid">
									<div id="DataTables_Table_0_wrapper" class="dataTables_wrapper"
										role="grid">
										<div id="DataTables_Table_0_wrapper"
											class="dataTables_wrapper" role="grid">
											<div id="DataTables_Table_0_wrapper"
												class="dataTables_wrapper" role="grid">
												<div id="DataTables_Table_0_wrapper"
													class="dataTables_wrapper" role="grid">
													<div id="DataTables_Table_0_wrapper"
														class="dataTables_wrapper" role="grid">
														<table aria-describedby="DataTables_Table_0_info"
															id="DataTables_Table_0"
															class="table table-striped table-bordered bootstrap-datatable datatable responsive dataTable">
															<thead>
																<tr role="row">
																	<th colspan="1" rowspan="2">Course Code</th>
																	<th colspan="1" rowspan="2">Course Name</th>

																	<th colspan="1" rowspan="2">Credit</th>
																	<th colspan="2" rowspan="1">Lecture</th>
																	<th colspan="2" rowspan="1">Lab</th>
																	<th colspan="2" rowspan="1">(Lec + Lab)/Week</th>

																</tr>

																<tr>
																	<td rowspan="1" colspan="1">of Lec</td>
																	<td rowspan="1" colspan="1">of Lecturers</td>
																	<td rowspan="1" colspan="1">of Lab</td>
																	<td rowspan="1" colspan="1">of Lecturers</td>
																	<td rowspan="1" colspan="1">Hours</td>
																	<td rowspan="1" colspan="1">Workload</td>
																</tr>
															</thead>

<%
Statement stmt;
Connection con;
InputStream stream = application.getResourceAsStream("/fileUpload/db.properties");
Properties props = new Properties();
props.load(stream);
String url = props.getProperty("driver");
String dbUrl = props.getProperty("url");
String dbUser = props.getProperty("user");
String dbPassword = props.getProperty("password");
con = DriverManager.getConnection(dbUrl, dbUser, dbPassword);
%>
<%
String strdateterm1_1 = "";
String strdateterm1_2 = "";
String strdateterm2_1 = "";
String strdateterm2_2 = "";

				String academicyear = null;
				String academicterm = null;

				if (null == (String) session.getAttribute("WorkloadYear")) {

				Date td = new Date();
				String strtd = new String("");
				SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
				SimpleDateFormat format2 = new SimpleDateFormat("yyyy-MM-dd",
				new Locale("th"));
				strtd = format.format(td);
				Date today = format.parse(strtd);
																																																																
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
																<b><i>Year : <%=academicyear%> Term : <%=academicterm%>
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
																stmt = con.createStatement();
																String courseFinal = "SELECT * FROM section inner join candidate inner join currentcourse inner join course where userID = '"
																+ sUserID
																+ "' and currentcourse.courseCode = course.courseCode and section.currentcourseID = currentcourse.currentcourseID and currentcourse.year = '"
																+Syear
																+"' and currentcourse.semester = '"
																+Sterm
																+"'  and  section.sectionID = candidate.sectionID and candidate.teachtype = 'Lect' group by currentcourse.courseCode;";
																ResultSet rsFinal = stmt.executeQuery(courseFinal);
																																																																				
																int of_lec = 0;
																int of_lecturers = 0;
																int of_lab = 0;
																int of_lablecturers = 0;
																double wlLect = 0;
																double wlLab = 0;
																																																																				
																int hourAll = 0 ;
																double result =0;
																																																																				
																ArrayList<Integer> listHourAll = new ArrayList<Integer>();
																ArrayList<Double> listResult = new ArrayList<Double>();
															%>


															<tbody aria-relevant="all" aria-live="polite"
																role="alert">


																<%
																	if (strUserID != null) {
																	while (rsFinal.next()) {

																	String credit = null;
																%>
																<tr class="odd">
																	<td class="center">
																		<%
																			String courseCode = rsFinal.getString("course.courseCode");
																			out.print(courseCode);
																		%>
																	</td>

																	<td class="center">
																		<%
																			String courseName = rsFinal.getString("course.courseName");
																			out.print(courseName);
																		%>
																	</td>
																	<td class="center">
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
																	%>

																	<td class="center">
																		<%
																			
																		if(courseName.equalsIgnoreCase("Senior Project 2") 
																				|| courseName.equalsIgnoreCase("Co-operative Education") 
																				|| courseName.equalsIgnoreCase("Senior Project 1")){
																			
																		
																		}else{
																		if (lect_of_hour == 0) {
																					out.print(lect_of_hour);
																				} else {

																				stmt = con.createStatement();
																				String qOfLec = "SELECT COUNT(*) AS rowcount FROM section inner join candidate inner join currentcourse inner join course where userID = '"
																				+ sUserID
																				+ "' and currentcourse.courseCode = course.courseCode and section.currentcourseID = currentcourse.currentcourseID and currentcourse.year = '"
																				+Syear
																				+"' and currentcourse.semester = '"
																				+Sterm
																				+"' and  section.sectionID = candidate.sectionID and candidate.teachtype = 'Lect' and currentcourse.courseCode = '"
																				+ courseCode + "'  ";
																				ResultSet rsOfLec = stmt.executeQuery(qOfLec);
																				rsOfLec.last();
																				of_lec = rsOfLec.getInt("rowcount");
																				out.print(of_lec);

																	}
																		}
																		%>
																	</td>
																	<td class="center">
																		<%
																			stmt = con.createStatement();
																		String qOfLectures = "SELECT COUNT(*) AS rowcount FROM section inner join candidate inner join currentcourse inner join course where currentcourse.courseCode = course.courseCode and section.currentcourseID = currentcourse.currentcourseID and currentcourse.year = '"
																			+Syear
																			+"' and currentcourse.semester = '"+
																			Sterm
																			+"' and  section.sectionID = candidate.sectionID and candidate.teachtype = 'Lect' and currentcourse.courseCode = '"
																			+ courseCode 
																			+ "' group by candidate.userID ";
																			ResultSet rsOfLectures = stmt.executeQuery(qOfLectures);

																			rsOfLectures.last();
																			of_lecturers = rsOfLectures.getInt("rowcount");
																			out.print(of_lecturers);
																		%>
																	</td>
																	<td class="center">
																		<%
																			
																		
																		if(courseName.equalsIgnoreCase("Senior Project 2") 
																				|| courseName.equalsIgnoreCase("Co-operative Education") 
																				|| courseName.equalsIgnoreCase("Senior Project 1")){
																			
																		
																		}else{
																		
																		if (lab_of_hour == 0) {
																			out.print(lab_of_hour);
																			} else {

																			stmt = con.createStatement();
																			String qOfLec = "SELECT COUNT(*) AS rowcount FROM section inner join candidate inner join currentcourse inner join course where userID = '"
																							+ sUserID
																							+ "' and currentcourse.courseCode = course.courseCode and section.currentcourseID = currentcourse.currentcourseID and currentcourse.year = '"
																							+Syear
																							+"' and currentcourse.semester = '"
																							+Sterm
																							+"' and  section.sectionID = candidate.sectionID and candidate.teachtype = 'Lab' and currentcourse.courseCode = '"
																							+ courseCode + "'  ";
																			ResultSet rsOfLec = stmt.executeQuery(qOfLec);

																			rsOfLec.next();
																			of_lab = rsOfLec.getInt("rowcount");
																			out.print(of_lab);

																			}
																		}
																		%>
																	</td>
																	<td class="center">
																		<%
																			stmt = con.createStatement();
																			String qOfLecturesLab = "SELECT * FROM section inner join candidate inner join currentcourse inner join course where currentcourse.courseCode = course.courseCode and section.currentcourseID = currentcourse.currentcourseID and currentcourse.year = '"
																			+Syear
																			+"' and currentcourse.semester = '"+
																			Sterm
																			+"' and  section.sectionID = candidate.sectionID  and candidate.teachtype = 'Lab' and currentcourse.courseCode = '"
																			+ courseCode 
																			+ "' group by candidate.userID;  ";
																			ResultSet rsOfLec2 = stmt.executeQuery(qOfLecturesLab);
																			rsOfLec2.last();
																			of_lablecturers = rsOfLec2.getRow();
																			while (rsOfLec2.next()) {
																			String a = rsOfLec2.getString("currentcourse.courseCode");

																			}

																			out.print(of_lablecturers);
																		%>
																	</td>
																	<td class="center">
																		<%
																		
																		if(courseName.equalsIgnoreCase("Senior Project 2") 
																				|| courseName.equalsIgnoreCase("Co-operative Education") 
																				|| courseName.equalsIgnoreCase("Senior Project 1")){
																			
																		out.print("0");
																		}else{	
																		
																		
																		
																		hourAll = lect_of_hour + lab_of_hour;
																			listHourAll.add(hourAll);
																			out.print(hourAll);
																		}
																		%>
																	</td>
																	<td class="center">
																		<%
																			try {
																																																																																				
																																																																																						
																				
																				if(courseName.equalsIgnoreCase("Senior Project 2") 
																						|| courseName.equalsIgnoreCase("Co-operative Education") 
																						|| courseName.equalsIgnoreCase("Senior Project 1")){
																					
																					out.print("0");
																				
																				}		else{																																																													
																																																																																				
																			if (of_lecturers != 0 && of_lablecturers != 0) {

																				if (of_lecturers >= 2) {
																			// for lecture
																					wlLect = (of_lec * lect_of_hour * 0.5)
																							/ of_lecturers;
																				} else {
																				wlLect = (of_lec * lect_of_hour) / of_lecturers;
																			}

																			// for lab

																			wlLab = (of_lab * lab_of_hour * 0.5)
																			/ of_lablecturers;

																			 result = wlLab + wlLect;
																			String finalResult = String.format("%.2f", result);
																			out.print(finalResult);

																			} else if (of_lecturers == 0 && of_lablecturers != 0) {
																			// for lab
																			wlLab = (of_lab * lab_of_hour * 0.5)
																			/ of_lablecturers;

																			result = wlLab + wlLect;
																			 String finalResult = String.format("%.2f", result);
																			out.print(finalResult);

																			} else if (of_lecturers != 0 && of_lablecturers == 0) {
																				if (of_lecturers >= 2) {
																					// for lecture
																				wlLect = (of_lec * lect_of_hour * 0.5)
																				/ of_lecturers;
																				} else {
																				wlLect = (of_lec * lect_of_hour) / of_lecturers;
																				}

																				result = wlLab + wlLect;
																				String finalResult = String.format("%.2f", result);
																				out.print(finalResult);
																				} else if (of_lecturers == 0 && of_lablecturers == 0) {
																				// no calculate
																				result = wlLab + wlLect;
																				 String finalResult = String.format("%.2f", result);
																				out.print(finalResult);
																				}
																				
																																																																																						
																				listResult.add(result);
																				}
																				} catch (ArithmeticException e) {
																				out.print(e);
																				} catch (NumberFormatException e) {
																				out.print(e);
																				} catch (Exception e) {
																				out.print(e);
																				}
																		%>
																	</td>

																	<%
																		
																	%>


																</tr>
																<%
																	}
																	}
																%>
																<%
																	int totalHour  = 0 ;
																	double totalResult = 0 ;
																%>
																<tr>
																	<td></td>
																	<td></td>
																	<td></td>
																	<td></td>
																	<td></td>
																	<td></td>
																	<td >Total</td>
																	<td>
																		<%
																			for(int i = 0; i<listHourAll.size(); i++)
																		  {
																																																																																		  
																			totalHour = totalHour + listHourAll.get(i);
																																																																																		
																																																																																		
																			 }
																		out.print(totalHour);
																		%>

																	</td>
																	<td>
																		<%
																			for(int i = 0; i<listResult.size(); i++)
																		 {
																		totalResult = totalResult + listResult.get(i);
																		}
																		String finalResult = String.format("%.2f", totalResult);
																		out.print(finalResult);
																		%>

																	</td>

																</tr>


															</tbody>


														</table>


														<%
															stmt = con.createStatement();
																																																															String qCheck = "SELECT * FROM workload where userID = '"
																																																																	+ strUserID + "'  ";
																																																															ResultSet rs = stmt.executeQuery(qCheck);
																																																															while (rs.next()) {

																																																															}
														%>
														<table>
															<tr>
																<td><a
																	href="Teacher_Assistance_Confirm_Workload.jsp?userID=<%=strUserID%>&&year=<%=Syear%>&&term=<%=Sterm%>&&status=confirm"
																	class="btn btn-primary" data-dismiss="modal">Confirm</a></td>
																<td><a class="btn btn-danger examSurveybtn"
																	href="Teacher_Assistance_Reject_Comment_Workload.jsp?userID=<%=strUserID%>&&year=<%=Syear%>&&term=<%=Sterm%>"
																	onClick="NewWindow(this.href,'name','600','120','yes');return false">
																		Reject </a></td>
															</tr>
														</table>



													</div>
												</div>
											</div>
										</div>
									</div>
								</div>


							</div>
						</div>
					</div>

				</div>


			</div>


			<div class="modal fade" id="settingforworkloadteacher" tabindex="-1"
				role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<button type="button" class="close" data-dismiss="modal">×</button>
							<h3>Setting Workload Year</h3>
						</div>
						<div class="modal-body">
							<form method="post" action="Teacher_Workload_SetYear.jsp"
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

				function confirm() {

					swal({
						title : "Are you sure?",
						text : "You want to change!",
						type : "warning",
						showCancelButton : true,
						confirmButtonColor : '#1DBFBF',
						confirmButtonText : 'Yes, Save it!',
						closeOnConfirm : false
					}, function() {
						swal("Save!", "Your profile has been save!", document
								.getElementById("AdduserForm").submit());
					});

				}
			</script>
			<!--/fluid-row-->

			<!-- Ad, you can remove it -->

			<!-- Ad ends -->

			<hr>



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