<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="java.sql.Statement"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.DriverManager"%>
<%@ page import="java.util.Calendar"%>
<%
	// Prepare for connect DB
%>
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

	Statement stmt = null;
	Connection con = null;
	String url = readurl;

	Class.forName(readdriver);
	con = DriverManager.getConnection(url, readuser, readpass);
%>
<%
	// End Prepare for connect DB
%>
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
<title>Coordinator</title>
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
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog"
		aria-labelledby="myModalLabel" aria-hidden="true">

		<div class="modal-dialog">
			<form method="post" action="Coordinator_UploadStudyPlan.jsp"
				role="form" name="" id="fileupload" enctype="multipart/form-data">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal">x</button>
						<h3>Please select the file</h3>
					</div>
					<div class="modal-body">

						<div class="form-group">
							<label for="exampleInputFile">File input</label> <input
								type="file" id="planFile" accept=".xls,.xlsx">
							<p class="help-block">Example excel.xls or excel.xlsx.</p>
						</div>

					</div>
					<div class="modal-footer">
						<a href="#" class="btn btn-default" data-dismiss="modal">Close</a>
						<a onclick="uploadFile()" href="#" class="btn btn-primary"
							data-dismiss="modal">Upload File</a>
					</div>
				</div>
			</form>
		</div>
	</div>
	<!-- Aniroot's javascript -->
	<script type="text/javascript">
		function showUploadFile() {
			$(document).ready(function() {
				$("#myModal").modal('show');
			});
		}

		function uploadFile() {
			if (document.getElementById("planFile").files.length == 0) {
				alert("No file input.");
			} else {
				document.getElementById("formUpload").submit();
			}

		}
	</script>
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
					<i class="glyphicon glyphicon-user"></i><span
						class="hidden-sm hidden-xs"> Coordinator</span> <span
						class="caret"></span>
				</button>
				<ul class="dropdown-menu">
					<li><a href="#">Profile</a></li>
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
							<li><a class="ajax-link" href="Coordinator.jsp"><i
									class="glyphicon glyphicon-home"></i><span> Dashboard</span></a></li>





							<li class="nav-header hidden-md">Management</li>
							<li class="active"><a class="ajax-link"
								href="Coordinator_StudyPlan.jsp"><i
									class="glyphicon glyphicon-align-justify"></i><span>
										Study Plan</span></a></li>






						</ul>

					</div>
				</div>
			</div>
			<!--/span-->
			<!-- left menu ends -->

			<noscript>
				&amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;lt;div class="alert
				alert-block
				col-md-12"&amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;gt;
				&amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;lt;h4
				class="alert-heading"&amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;gt;Warning!&amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;lt;/h4&amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;gt;

				&amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;lt;p&amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;gt;You
				need to have &amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;lt;a
				href="http://en.wikipedia.org/wiki/JavaScript"
				target="_blank"&amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;gt;JavaScript&amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;lt;/a&amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;gt;
				enabled to use this
				site.&amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;lt;/p&amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;gt;
				&amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;lt;/div&amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;amp;gt;
			</noscript>
			<%
				// start get data  from SQL server
				int year = Calendar.getInstance().get(Calendar.YEAR);
				// 1 st year
				int yearOnBE1 = (year) + 543;
				String yearOnBEStr1 = Integer.toString(yearOnBE1);
				//System.out.println(yearOnBEStr1);
				//2 nd year
				int yearOnBE2 = (year) + 543 - 1;
				String yearOnBEStr2 = Integer.toString(yearOnBE2);
				//System.out.println(yearOnBEStr2);
				//3 rd year
				int yearOnBE3 = (year) + 543 - 2;
				String yearOnBEStr3 = Integer.toString(yearOnBE3);
				//System.out.println(yearOnBEStr3);
				//4 th year
				int yearOnBE4 = (year) + 543 - 3;
				String yearOnBEStr4 = Integer.toString(yearOnBE4);
				//System.out.println(yearOnBEStr4);

				try {
					Class.forName("com.mysql.jdbc.Driver");
					stmt = con.createStatement();

					String sql = "SELECT studyplan.academicYear FROM studyplan group by studyplan.academicYear order by studyplan.academicYear desc";
					ResultSet rec = stmt.executeQuery(sql);
			%>
			<div id="content" class="col-lg-10 col-sm-10">
				<!-- content starts -->
				<div>
					<ul class="breadcrumb">
						<li><a href="Coordinator.jsp">Home</a></li>
						<li><a href="#">Study Plan Management</a></li>
					</ul>
				</div>


				<div class="row">
					<div class="box col-md-12">


						<div class="row">
							<div class="box col-md-12">
								<div class="box-inner">
									<div class="box-header well" data-original-title="">
										<h2>
											<i class="glyphicon glyphicon-user"></i> Study Plan
											Management
										</h2>

										<div class="box-icon">

											<a href="#" class="btn btn-minimize btn-round btn-default"><i
												class="glyphicon glyphicon-chevron-up"></i></a> <a href="#"
												class="btn btn-close btn-round btn-default"><i
												class="glyphicon glyphicon-remove"></i></a>
										</div>
									</div>
									<div class="box-content">

										<div id="DataTables_Table_0_wrapper"
											class="dataTables_wrapper" role="grid">
											<div id="DataTables_Table_0_wrapper"
												class="dataTables_wrapper" role="grid">
												<div id="DataTables_Table_0_wrapper"
													class="dataTables_wrapper" role="grid">
													<p>
														<button onclick="showUploadFile()"
															class="btn btn-warning btn-sm">Add Study Plan</button>
													</p>
													<div id="DataTables_Table_0_wrapper"
														class="dataTables_wrapper" role="grid">
														<table
															class="table table-striped table-bordered bootstrap-datatable datatable responsive dataTable"
															id="DataTables_Table_0"
															aria-describedby="DataTables_Table_0_info">
															<thead>

																<tr role="row">
																	<th class="sorting_desc" role="columnheader"
																		tabindex="0" aria-controls="DataTables_Table_0"
																		rowspan="1" colspan="1" style="width: 330px;"
																		aria-sort="descending"
																		aria-label="Year: activate to sort column ascending">Year</th>
																	<th class="sorting" role="columnheader" tabindex="0"
																		aria-controls="DataTables_Table_0" rowspan="1"
																		colspan="1" style="width: 696px;"
																		aria-label="Actions: activate to sort column ascending">Actions</th>
																</tr>

															</thead>

															<tbody role="alert" aria-live="polite"
																aria-relevant="all">
																<%
																	while ((rec != null) && (rec.next())) {
																%>
																<tr>
																	<td class=" sorting_1"><%=rec.getInt("academicYear")%></td>
																	<td class="center"><a
																		class="btn btn-primary btn-sm"
																		href="Coordinator_ListStudyPlan.jsp?year=<%=rec.getInt("academicYear")%>&major=">
																			<i class="glyphicon glyphicon-zoom-in icon-white"></i>
																			All major
																	</a> <a class="btn btn-info btn-sm"
																		href="Coordinator_ListStudyPlan.jsp?year=<%=rec.getInt("academicYear")%>&major=IT">
																			<i class="glyphicon glyphicon-zoom-in icon-white"></i>
																			IT
																	</a> <a class="btn btn-info btn-sm"
																		href="Coordinator_ListStudyPlan.jsp?year=<%=rec.getInt("academicYear")%>&major=CS">
																			<i class="glyphicon glyphicon-zoom-in icon-white"></i>
																			CS
																	</a> <a class="btn btn-success btn-sm"
																		href="Coordinator_ListStudyPlan.jsp?year=<%=rec.getInt("academicYear")%>&major=SE">
																			<i class="glyphicon glyphicon-zoom-in icon-white"></i>
																			SE
																	</a> <a class="btn btn-success btn-sm"
																		href="Coordinator_ListStudyPlan.jsp?year=<%=rec.getInt("academicYear")%>&major=MTA">
																			<i class="glyphicon glyphicon-zoom-in icon-white"></i>
																			MTA
																	</a> <a class="btn btn-danger btn-sm"
																		href="Coordinator_ListStudyPlan.jsp?year=<%=rec.getInt("academicYear")%>&major=CE">
																			<i class="glyphicon glyphicon-zoom-in icon-white"></i>
																			CE
																	</a> <a class="btn btn-danger btn-sm"
																		href="Coordinator_ListStudyPlan.jsp?year=<%=rec.getInt("academicYear")%>&major=ICE">
																			<i class="glyphicon glyphicon-zoom-in icon-white"></i>
																			ICE
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
										</div>
									</div>
								</div>
							</div>
							<!--/span-->

						</div>

						<div class="row">
							<div class="box col-md-6">
								<div class="box-inner">
									<div class="box-header well" data-original-title="">
										<h2>
											1 st year current course (<%=yearOnBE1%>)
										</h2>

										<div class="box-icon">

											<a href="#" class="btn btn-minimize btn-round btn-default"><i
												class="glyphicon glyphicon-chevron-up"></i></a> <a href="#"
												class="btn btn-close btn-round btn-default"><i
												class="glyphicon glyphicon-remove"></i></a>
										</div>
									</div>
									<div class="box-content" style="display: block;">
										<div id="DataTables_Table_0_wrapper"
											class="dataTables_wrapper" role="grid">
											<div id="DataTables_Table_0_wrapper"
												class="dataTables_wrapper" role="grid">
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
																			<th class="sorting_asc" role="columnheader"
																				tabindex="0" aria-controls="DataTables_Table_0"
																				rowspan="1" colspan="1" style="width: 176px;"
																				aria-sort="ascending"
																				aria-label="Code: activate to sort column descending">Code</th>
																			<th class="sorting" role="columnheader" tabindex="0"
																				aria-controls="DataTables_Table_0" rowspan="1"
																				colspan="1" style="width: 292px;"
																				aria-label="Name: activate to sort column ascending">Name</th>
																			<th class="sorting" role="columnheader" tabindex="0"
																				aria-controls="DataTables_Table_0" rowspan="1"
																				colspan="1" style="width: 80px;"
																				aria-label="Name: activate to sort column ascending">Major</th>
																		</tr>
																	</thead>

																	<tbody role="alert" aria-live="polite"
																		aria-relevant="all">
																		<%
																			// Year 1st
																				sql = "SELECT * FROM studyplan inner join course on (studyPlan.courseCode=course.courseCode) Where academicYear like '"
																						+ yearOnBEStr1 + "'";
																				rec = stmt.executeQuery(sql);
																				while ((rec != null) && (rec.next())) {
																		%>
																		<tr>
																			<td class=" sorting_1"><%=rec.getString("courseCode")%></td>
																			<td class="center"><%=rec.getString("courseName")%></td>
																			<td class="center"><%=rec.getString("major")%></td>
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
											</div>
										</div>

									</div>
								</div>
							</div>
							<!--/span-->

							<div class="box col-md-6">
								<div class="box-inner">
									<div class="box-header well" data-original-title="">
										<h2>
											2 nd year current course (<%=yearOnBE2%>)
										</h2>

										<div class="box-icon">

											<a href="#" class="btn btn-minimize btn-round btn-default"><i
												class="glyphicon glyphicon-chevron-up"></i></a> <a href="#"
												class="btn btn-close btn-round btn-default"><i
												class="glyphicon glyphicon-remove"></i></a>
										</div>
									</div>
									<div class="box-content" style="display: block;">
										<div id="DataTables_Table_0_wrapper"
											class="dataTables_wrapper" role="grid">
											<div id="DataTables_Table_0_wrapper"
												class="dataTables_wrapper" role="grid">
												<div id="DataTables_Table_0_wrapper"
													class="dataTables_wrapper" role="grid">
													<div id="DataTables_Table_0_wrapper"
														class="dataTables_wrapper" role="grid">
														<div id="DataTables_Table_0_wrapper"
															class="dataTables_wrapper" role="grid">
															<table table=""
																aria-describedby="DataTables_Table_0_info"
																id="DataTables_Table_0"
																class="table table-striped table-bordered bootstrap-datatable datatable responsive dataTable">
																<thead>
																	<tr role="row">
																		<th class="sorting_asc" role="columnheader"
																			tabindex="0" aria-controls="DataTables_Table_0"
																			rowspan="1" colspan="1" style="width: 201px;"
																			aria-sort="ascending"
																			aria-label="Code: activate to sort column descending">Code</th>
																		<th class="sorting" role="columnheader" tabindex="0"
																			aria-controls="DataTables_Table_0" rowspan="1"
																			colspan="1" style="width: 267px;"
																			aria-label="Name: activate to sort column ascending">Name</th>
																		<th class="sorting" role="columnheader" tabindex="0"
																			aria-controls="DataTables_Table_0" rowspan="1"
																			colspan="1" style="width: 80px;"
																			aria-label="Name: activate to sort column ascending">Major</th>
																	</tr>
																</thead>

																<tbody role="alert" aria-live="polite"
																	aria-relevant="all">
																	<%
																		// Year 2
																			sql = "SELECT * FROM studyplan inner join course on (studyPlan.courseCode=course.courseCode) Where academicYear like '"
																					+ yearOnBEStr2 + "'";
																			rec = stmt.executeQuery(sql);
																			while ((rec != null) && (rec.next())) {
																	%>
																	<tr>
																		<td class=" sorting_1"><%=rec.getString("courseCode")%></td>
																		<td class="center"><%=rec.getString("courseName")%></td>
																		<td class="center"><%=rec.getString("major")%></td>
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
										</div>

									</div>
								</div>
							</div>
							<!--/span-->
						</div>
						<div class="row">
							<div class="box col-md-6">
								<div class="box-inner">
									<div class="box-header well" data-original-title="">
										<h2>
											3 rd year current course (<%=yearOnBE3%>)
										</h2>

										<div class="box-icon">

											<a href="#" class="btn btn-minimize btn-round btn-default"><i
												class="glyphicon glyphicon-chevron-up"></i></a> <a href="#"
												class="btn btn-close btn-round btn-default"><i
												class="glyphicon glyphicon-remove"></i></a>
										</div>
									</div>
									<div class="box-content" style="display: block;">
										<div id="DataTables_Table_0_wrapper"
											class="dataTables_wrapper" role="grid">
											<div id="DataTables_Table_0_wrapper"
												class="dataTables_wrapper" role="grid">
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
																			<th class="sorting_asc" role="columnheader"
																				tabindex="0" aria-controls="DataTables_Table_0"
																				rowspan="1" colspan="1" style="width: 176px;"
																				aria-sort="ascending"
																				aria-label="Code: activate to sort column descending">Code</th>
																			<th class="sorting" role="columnheader" tabindex="0"
																				aria-controls="DataTables_Table_0" rowspan="1"
																				colspan="1" style="width: 292px;"
																				aria-label="Name: activate to sort column ascending">Name</th>
																			<th class="sorting" role="columnheader" tabindex="0"
																				aria-controls="DataTables_Table_0" rowspan="1"
																				colspan="1" style="width: 80px;"
																				aria-label="Name: activate to sort column ascending">Major</th>
																		</tr>
																	</thead>

																	<tbody role="alert" aria-live="polite"
																		aria-relevant="all">
																		<%
																			// Year 3
																				sql = "SELECT * FROM studyplan inner join course on (studyPlan.courseCode=course.courseCode) Where academicYear like '"
																						+ yearOnBEStr3 + "'";
																				rec = stmt.executeQuery(sql);
																				while ((rec != null) && (rec.next())) {
																		%>
																		<tr>
																			<td class=" sorting_1"><%=rec.getString("courseCode")%></td>
																			<td class="center"><%=rec.getString("courseName")%></td>
																			<td class="center"><%=rec.getString("major")%></td>
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
											</div>
										</div>

									</div>
								</div>
							</div>
							<!--/span-->

							<div class="box col-md-6">
								<div class="box-inner">
									<div class="box-header well" data-original-title="">
										<h2>
											4 th year current course (<%=yearOnBE4%>)
										</h2>

										<div class="box-icon">

											<a href="#" class="btn btn-minimize btn-round btn-default"><i
												class="glyphicon glyphicon-chevron-up"></i></a> <a href="#"
												class="btn btn-close btn-round btn-default"><i
												class="glyphicon glyphicon-remove"></i></a>
										</div>
									</div>
									<div class="box-content" style="display: block;">
										<div id="DataTables_Table_0_wrapper"
											class="dataTables_wrapper" role="grid">
											<div id="DataTables_Table_0_wrapper"
												class="dataTables_wrapper" role="grid">
												<div id="DataTables_Table_0_wrapper"
													class="dataTables_wrapper" role="grid">
													<div id="DataTables_Table_0_wrapper"
														class="dataTables_wrapper" role="grid">
														<div id="DataTables_Table_0_wrapper"
															class="dataTables_wrapper" role="grid">
															<table table=""
																aria-describedby="DataTables_Table_0_info"
																id="DataTables_Table_0"
																class="table table-striped table-bordered bootstrap-datatable datatable responsive dataTable">
																<thead>
																	<tr role="row">
																		<th class="sorting_asc" role="columnheader"
																			tabindex="0" aria-controls="DataTables_Table_0"
																			rowspan="1" colspan="1" style="width: 201px;"
																			aria-sort="ascending"
																			aria-label="Code: activate to sort column descending">Code</th>
																		<th class="sorting" role="columnheader" tabindex="0"
																			aria-controls="DataTables_Table_0" rowspan="1"
																			colspan="1" style="width: 267px;"
																			aria-label="Name: activate to sort column ascending">Name</th>
																		<th class="sorting" role="columnheader" tabindex="0"
																			aria-controls="DataTables_Table_0" rowspan="1"
																			colspan="1" style="width: 80px;"
																			aria-label="Name: activate to sort column ascending">Major</th>
																	</tr>
																</thead>

																<tbody role="alert" aria-live="polite"
																	aria-relevant="all">
																	<%
																		// Year 4
																			sql = "SELECT * FROM studyplan inner join course on (studyPlan.courseCode=course.courseCode) Where academicYear like '"
																					+ yearOnBEStr4 + "'";
																			rec = stmt.executeQuery(sql);
																			while ((rec != null) && (rec.next())) {
																	%>
																	<tr>
																		<td class=" sorting_1"><%=rec.getString("courseCode")%></td>
																		<td class="center"><%=rec.getString("courseName")%></td>
																		<td class="center"><%=rec.getString("major")%></td>
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
										</div>

									</div>
								</div>
							</div>
							<!--/span-->
						</div>
					</div>
				</div>


				<%
					} catch (Exception e) {
						// TODO Auto-generated catch block
						out.println(e.getMessage());
						e.printStackTrace();
					}

					try {
						if (stmt != null) {
							stmt.close();
							con.close();
						}
					} catch (SQLException e) {
						// TODO Auto-generated catch block
						out.println(e.getMessage());
						e.printStackTrace();
					}
				%>


				<!-- content ends -->
			</div>
			<!--/#content.col-md-0-->
		</div>
		<!--/fluid-row-->

		<hr>



		<footer class="row">
			<p class="col-md-9 col-sm-9 col-xs-12 copyright">
				ฉ <a href="http://usman.it" target="_blank">Muhammad Usman</a> 2012
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