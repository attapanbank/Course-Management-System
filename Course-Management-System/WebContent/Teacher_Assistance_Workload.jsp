<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
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
					<i class="glyphicon glyphicon-user"></i><span
						class="hidden-sm hidden-xs"> Teacher</span> <span class="caret"></span>
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
							<li><a class="ajax-link"
								href="Teacher_Assistance_News.jsp"><i
									class="glyphicon glyphicon-home"></i><span> News</span></a></li>
							<li class="nav-header hidden-md">Management</li>
							<li class="active"><a class="ajax-link"
								href="Teacher_Assistance_Workload.jsp"><i
									class="glyphicon glyphicon-align-justify"></i><span>
										Workload</span></a></li>
							<li><a class="ajax-link"
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


				<div>
					<ul class="breadcrumb">
						<li><a href="#">Home</a></li>
						<li><a href="#">Workload</a></li>
					</ul>
				</div>



				<div class="row">
					<div class="box col-md-12">
						<div class="box-inner">
							<div class="box-header well" data-original-title="">
								<h2>
									<i class="glyphicon glyphicon-star-empty"></i> Workload
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
																	<th style="width: 100px;" colspan="1" rowspan="1"
																		aria-controls="DataTables_Table_0" tabindex="0"
																		role="columnheader" class="sorting"
																		aria-label="Role: activate to sort column ascending">Course
																		Code</th>
																	<th style="width: 150px;" colspan="1" rowspan="1"
																		aria-controls="DataTables_Table_0" tabindex="0"
																		role="columnheader" class="sorting"
																		aria-label="Role: activate to sort column ascending">Course
																		Name</th>
																	<th style="width: 150px;" colspan="1" rowspan="1"
																		aria-controls="DataTables_Table_0" tabindex="0"
																		role="columnheader" class="sorting"
																		aria-label="Status: activate to sort column ascending">Lec
																		(Hour/Lec sec)</th>
																	<th style="width: 150px;" colspan="1" rowspan="1"
																		aria-controls="DataTables_Table_0" tabindex="0"
																		role="columnheader" class="sorting"
																		aria-label="Status: activate to sort column ascending">Lab(Hour/Leb)
																	</th>
																	<th style="width: 100px;" colspan="1" rowspan="1"
																		aria-controls="DataTables_Table_0" tabindex="0"
																		role="columnheader" class="sorting"
																		aria-label="Actions: activate to sort column ascending">Hour/Week</th>
																	<th style="width: 100px;" colspan="1" rowspan="1"
																		aria-controls="DataTables_Table_0" tabindex="0"
																		role="columnheader" class="sorting"
																		aria-label="Actions: activate to sort column ascending">Workload/Week</th>
																</tr>
															</thead>

															<tbody aria-relevant="all" aria-live="polite"
																role="alert">
																<tr class="odd">
																	<td class="">1302305</td>

																	<td class="center">Network Programing</td>
																	<td class="center">2</td>
																	<td class="center">2</td>
																	<td class="center">4</td>
																	<td class="center">4</td>
																</tr>
																<tr class="even">
																	<td class="">1302312</td>

																	<td class="center">Data Storage</td>
																	<td class="center">2</td>
																	<td class="center">2</td>
																	<td class="center">4</td>
																	<td class="center">4</td>


																</tr>

															</tbody>
														</table>
														<div class="center">
															<a href="#" class="btn btn-primary" data-dismiss="modal">Confirm</a>
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
							<button type="button" class="close" data-dismiss="modal">×</button>
							<h3>รายละเอียด</h3>
						</div>
						<div class="modal-body">
							<!--แก้ไขตรงนี้-->
							<table>
								<tr>
									<td><p>รหัสรายวิขา:</p></td>
									<td><p>1302305</p></td>
								</tr>
								<tr>
									<td><p>ชื่อรายวิชา:</p></td>
									<td><p>Network Programing</p></td>
								</tr>
								<tr>
									<td><p>หน่วยกิต:</p></td>
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
									<td><p>นักศึกษาสาขาวิชา:</p></td>
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
				© <a href="http://usman.it" target="_blank">Muhammad Usman</a> 2012
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