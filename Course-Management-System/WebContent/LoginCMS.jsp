<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.sql.ResultSet"%>
<%@ page import="java.sql.SQLException"%>
<%@ page import="java.sql.Statement"%>
<%@ page import="java.sql.Connection"%>
<%@ page import="java.sql.DriverManager"%>
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
<!DOCTYPE html>
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
<title>Course Management System Login</title>

<script type="text/javascript">
	function createXMLHttpRequest() {
		if (window.ActiveXObject) {
			xmlHttp = new ActiveXObject("Microsoft.XMLHTTP");
		} else if (window.XMLHttpRequest) {
			xmlHttp = new XMLHttpRequest();
		}
	}

	function submitRunAjax() {
		loginCheck = document.getElementById("loginCheck").value;
		var url = "loginCheck.jsp?examSelect=" + loginCheck;
		createXMLHttpRequest();
		xmlHttp.onreadystatechange = handleStateChangeAjax;
		xmlHttp.open("POST", url, true);
		xmlHttp.send(null);
	}

	function handleStateChangeAjax() {
		var objAdd = document.forms['myForm'];
		if (xmlHttp.readyState == 4) {
			if (xmlHttp.status == 200) {
				if (xmlHttp.responseText == 0) {
					var status = validateForm();
					if (status == false) {

					} else {
						objAdd.submit();
					}
				} else {
					alert("User Same");
					return false;
				}
			} else {
				alert("Error Xml in System");
				return false;
			}
		}
	}
</script>
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta name="description"
	content="Charisma, a fully featured, responsive, HTML5, Bootstrap admin template.">
<meta name="author" content="Muhammad Usman">

<!-- The styles -->
<link id="bs-css" href="css/bootstrap-cerulean.min.css" rel="stylesheet">

<link href="css/charisma-app.css" rel="stylesheet">
<link href='bower_components/fullcalendar/dist/fullcalendar.css'
	rel='stylesheet'>
<link href='bower_components/fullcalendar/dist/fullcalendar.print.css'
	rel='stylesheet' media='print'>
<link href='bower_components/chosen/chosen.min.css' rel='stylesheet'>
<link href='bower_components/colorbox/example3/colorbox.css'
	rel='stylesheet'>
<link href='bower_components/responsive-tables/responsive-tables.css'
	rel='stylesheet'>
<link
	href='bower_components/bootstrap-tour/build/css/bootstrap-tour.min.css'
	rel='stylesheet'>
<link href='css/jquery.noty.css' rel='stylesheet'>
<link href='css/noty_theme_default.css' rel='stylesheet'>
<link href='css/elfinder.min.css' rel='stylesheet'>
<link href='css/elfinder.theme.css' rel='stylesheet'>
<link href='css/jquery.iphone.toggle.css' rel='stylesheet'>
<link href='css/uploadify.css' rel='stylesheet'>
<link href='css/animate.min.css' rel='stylesheet'>

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
		if (request.getParameter("Action") != null) {

			Connection connect = null;
			Statement s = null;

			try {
				Class.forName("com.mysql.jdbc.Driver");

				String username = request.getParameter("txtUsername");
				String password = request.getParameter("txtPassword");

				s = connect.createStatement();

				String sql = "SELECT * FROM  user WHERE " + " username = '"+ username + "' AND " + " password = '" + password + "' ";

				ResultSet rec = s.executeQuery(sql);

				String fristname = null ;
				String lastname = null;
				if (!rec.next()) {
					
					
					
					%>
					<div class="alert alert-danger">
                    <button type="button" class="close" data-dismiss="alert">&times;</button>
                    <strong>Oh snap!</strong> Username and Password Incorrect!
                </div>
					<% 
					
				} else {
					
					rec.first();
					session.setAttribute("sUserID", rec.getString("userID"));
					response.sendRedirect("checkLogin.jsp");
					%>
					<div class="alert alert-success">
                    <button type="button" class="close" data-dismiss="alert">&times;</button>
                    <strong>Success!</strong> You successfully Login.
                </div>
					<% 
				}

				
			} catch (Exception e) {
				// TODO Auto-generated catch block
				out.println(e.getMessage());
				e.printStackTrace();
			}

			try {
				if (s != null) {
					s.close();
					connect.close();
				}
			} catch (SQLException e) {
				// TODO Auto-generated catch block
				out.println(e.getMessage());
				e.printStackTrace();
			}

		}
	%>
	<div class="ch-container">
		<div class="row">

			<div class="row">
				<div class="col-md-12 center login-header">
					<h2>Welcome to Course Management System</h2>
				</div>
				<!--/span-->
			</div>
			<!--/row-->
<form name="frmLogin" method="post" action="LoginCMS.jsp?Action=Login">
			<div class="row">
				<div class="well col-md-5 center login-box">
					<div class="alert alert-info">Please login with your Username
						and Password.</div>
					<form class="form-horizontal" action="index.html" method="post">
						<fieldset>
							<div class="input-group input-group-lg">
								<span class="input-group-addon"><i
									class="glyphicon glyphicon-user red"></i></span> <input name="txtUsername" type="text" id="txtUsername"
									class="form-control" placeholder="Username">
							</div>
							<div class="clearfix"></div>
							<br>

							<div class="input-group input-group-lg">
								<span class="input-group-addon"><i
									class="glyphicon glyphicon-lock red"></i></span> <input
									name="txtPassword" type="password" id="txtPassword" class="form-control" placeholder="Password">
							</div>
							<div class="clearfix"></div>

							<div class="input-prepend">
								<label class="remember" for="remember"><input
									type="checkbox" id="remember"> Remember me</label>
							</div>
							<div class="clearfix"></div>

							<p class="center col-md-5">
								<button type="submit" class="btn btn-primary">Login</button>
							</p>
						</fieldset>
					</form>
				</div>
				<!--/span-->
			</div>
			</form>
			<!--/row-->
		</div>
		<!--/fluid-row-->

	</div>
	<!--/.fluid-container-->

	<!-- external javascript -->

	<script src="bower_components/bootstrap/dist/js/bootstrap.min.js"></script>

	<!-- library for cookie management -->
	<script src="js/jquery.cookie.js"></script>
	<!-- calender plugin -->
	<script src='bower_components/moment/min/moment.min.js'></script>
	<script src='bower_components/fullcalendar/dist/fullcalendar.min.js'></script>
	<!-- data table plugin -->
	<script src='js/jquery.dataTables.min.js'></script>

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
