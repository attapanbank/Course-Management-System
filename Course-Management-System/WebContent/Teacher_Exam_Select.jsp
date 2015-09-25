<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title></title>

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
	<div class="row">
		<div class="box col-md-12">
			<div class="box-inner">
				<div class="box-header well" data-original-title="">
					<h2>
						<i class="glyphicon glyphicon-star-empty"></i> Examination
					</h2>

					<div class="box-icon">
						<a href="Teacher_Profile.jsp"
							class="btn btn-setting btn-round btn-default"><i
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

					<%Object strUserID = session.getAttribute("sUserID"); 
					String courseCode = request.getParameter("courseCode");
					String courseName = request.getParameter("courseName");
					String year = request.getParameter("year");
					String semester = request.getParameter("semester");
					
					%>




						<form action="save_exam.jsp" method="post" id="examSurvyBox"
							name="examSurvyBox">

							<table aria-describedby="DataTables_Table_0_info"
								id="DataTables_Table_0"
								class="table table-striped table-bordered bootstrap-datatable datatable responsive dataTable">

								<thead>
									<tr role="row">
										<th colspan="1" rowspan="2">Course Code</th>
										<th colspan="1" rowspan="2">Course Name</th>
										<th colspan="3" rowspan="1">Midterm</th>
										<th colspan="1" rowspan="2">Reason</th>
										<th colspan="3" rowspan="1">Final</th>
										<th colspan="1" rowspan="2">Reason</th>
										<th colspan="1" rowspan="2">Action</th>
									<tr>
										<td rowspan="2" colspan="1">Wriiting</td>
										<td rowspan="1" colspan="1">Multiple Choice</td>
										<td rowspan="1" colspan="1">Off Schedule</td>
										<td rowspan="2" colspan="1">Wriiting</td>
										<td rowspan="1" colspan="1">Multiple Choice</td>
										<td rowspan="1" colspan="1">Off Schedule</td>
									</tr>

								</thead>





								<tbody aria-relevant="all" aria-live="polite" role="alert">


									<tr>
										<td>
										<input type="hidden" name ="courseCode" value="<%=courseCode%>">
										<input type="hidden" name="semester"value="<%=semester%>">
										<input type="hidden" name="year" value="<%=year%>">
										<%out.print(courseCode); %></td>
										<td>
										<input type="hidden" name ="courseCode" value="<%=courseName%>">
										<%out.print(courseName);%></td>




										<td><input type="checkbox" value="Wriiting"
											name="chkBoxWrittingMid" id="chkBoxWrittingMid"></td>
										<td><input type="checkbox" value="Multiple Choice"
											name="chkBoxMultiMid" id="chkBoxMultiMid"></td>
										<td><input type="checkbox" value="Off Schedule"
											name="chkBoxOffMid" id="chkBoxOffMid"></td>
										<td class="center"><input type="text" name="reasonMid"
											id="reasonMid"></td>

										<td><input type="checkbox" value="Wriiting"
											name="chkBoxWrittingFinal" id="chkBoxWrittingFinal"></td>
										<td><input type="checkbox" value="Multiple Choice"
											name="chkBoxMultiFinal" id="chkBoxMultiFinal"></td>
										<td><input type="checkbox" value="Off Schedule"
											name="chkBoxOffFinal" id="chkBoxOffFinal"></td>
										<td><input type="text" name="reasonFinal"
											id="reasonFinal"></td>

										<td><a class="btn btn-success examSurveybtn"
										
											onClick="check();">
												<i class="glyphicon glyphicon glyphicon-check"></i> Confirm
										</a></td>
									</tr>


								</tbody>

							</table>
						</form>

					</div>


				</div>


			</div>
		</div>
	</div>
	
	
	<script type="text/javascript">

					function check() {

						if (document.getElementById("chkBoxWrittingMid").checked == false
								&& document.getElementById("chkBoxMultiMid").checked == false
								&& document.getElementById("chkBoxOffMid").checked == false
								&& document.getElementById("reasonMid").value == "") {
							alert("If you don't want to have exam of midterm. Please give the reason.");
							document.getElementById("chkBoxWrittingMid")
									.focus();
							return false;
						}
						if (document.getElementById("chkBoxWrittingFinal").checked == false
								&& document.getElementById("chkBoxMultiFinal").checked == false
								&& document.getElementById("chkBoxOffFinal").checked == false
								&& document.getElementById("reasonFinal").value == "") {
							alert("If you don't want to have exam of final. Please give the reason.");
							document.getElementById("chkBoxWrittingFinal")
									.focus();
							return false;
						}

						if (document.getElementById("chkBoxWrittingMid").checked == false
								&& document.getElementById("chkBoxMultiMid").checked == false
								&& document.getElementById("chkBoxOffMid").checked == false
								&& document.getElementById("reasonMid").value == ""
								&& document
										.getElementById("chkBoxWrittingFinal").checked == false
								&& document.getElementById("chkBoxMultiFinal").checked == false
								&& document.getElementById("chkBoxOffFinal").checked == false
								&& document.getElementById("reasonFinal").value == "") {
							alert("If you don't want to have exam of midterm and final. Please give the reason.");
							document.getElementById("chkBoxWrittingFinal")
									.focus();
							return false;

						}

						if (document.getElementById("chkBoxOffMid").checked == true
								&& document.getElementById("chkBoxWrittingMid").checked == true

						//|| document.getElementById("chkBoxWrittingFinal").checked != true
						//|| document.getElementById("chkBoxMultiFinal").checked != true
						//|| document.getElementById("chkBoxOffFinal").checked != true
						) {
							alert("If you selecting Multple choice or writing you can't select Off Schedule ");
							document.getElementById("chkBoxOffMid");
							return false;

						}

						if (document.getElementById("chkBoxOffMid").checked == true
								&& document.getElementById("chkBoxMultiMid").checked == true
						//|| document.getElementById("chkBoxWrittingFinal").checked != true
						//|| document.getElementById("chkBoxMultiFinal").checked != true
						//|| document.getElementById("chkBoxOffFinal").checked != true
						) {
							alert("If you selecting Multple choice or writing you can't select Off Schedule ");
							document.getElementById("chkBoxOffMid");
							return false;

						}

						if (document.getElementById("chkBoxOffFinal").checked == true
								&& document
										.getElementById("chkBoxWrittingFinal").checked == true) {
							alert("If you selecting Multple choice or writing you can't select Off Schedule ");
							document.getElementById("chkBoxOffFinal");
							return false;

						}

						if (document.getElementById("chkBoxOffFinal").checked == true
								&& document.getElementById("chkBoxMultiFinal").checked == true) {
							alert("If you selecting Multple choice or writing you can't select Off Schedule ");
							document.getElementById("chkBoxOffFinal");
							return false;

						}

						if (document.getElementById("chkBoxWrittingMid").checked == false
								&& document.getElementById("chkBoxMultiMid").checked == false
								&& document.getElementById("chkBoxOffMid").checked == false
								&& document
										.getElementById("chkBoxWrittingFinal").checked == false
								&& document.getElementById("chkBoxMultiFinal").checked == false
								&& document.getElementById("chkBoxOffFinal").checked == false
								&& document.getElementById("reasonMid").value != ""
								&& document.getElementById("reasonFinal").value != "") {

							document.forms['examSurvyBox'].submit();

						}

						if (document.getElementById("chkBoxWrittingMid").checked == true
								|| document.getElementById("chkBoxMultiMid").checked == true
								|| document.getElementById("chkBoxOffMid").checked == true
								|| document
										.getElementById("chkBoxWrittingFinal").checked == true
								|| document.getElementById("chkBoxMultiFinal").checked == true
								|| document.getElementById("chkBoxOffFinal").checked == true) {

							document.forms['examSurvyBox'].submit();

						}

					}
				</script>
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
				
</body>
</html>