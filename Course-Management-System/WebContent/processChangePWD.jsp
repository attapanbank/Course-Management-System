<%@page import="java.sql.*"%>
<%@page import="java.io.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title></title>
<script src="dist/sweetalert-dev.js"></script>
<link rel="stylesheet" href="dist/sweetalert.css">
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
</head>

<body>
	<%
		String username = request.getParameter("username");
		String oldpassword = request.getParameter("oldpassword");
		String newpassword = request.getParameter("newpassword");
		String confirmpass = request.getParameter("confirmpassword");
		String firstname = request.getParameter("firstname");
		String lastname = request.getParameter("lastname");
		String selectmajor = request.getParameter("selectmajor");
		Object strUserID = session.getAttribute("sUserID");
		Connection con = null;
		Statement stmt = null;
		String pass = "";
		int id = 0;
		String type = null ;
		String tAdmin = "Admin";
		String tTeacher = "Teacher";
		String tTA = "Teacher Assistance";
		String tCo = "Coordinater";
		try {
			Class.forName("com.mysql.jdbc.Driver");
			String url = "jdbc:mysql://localhost:3306/cms";
			con = DriverManager.getConnection(url, "root", "root");
			stmt = con.createStatement();
			ResultSet rs = stmt.executeQuery("select * from user where password= '"
							+ oldpassword + "'and userID ='"+strUserID +"'");
			if (rs.next()) {
				pass = rs.getString("password");
				
				
			}
			
			// For check user type
			String quString = "select * from user where userID ='"+strUserID+"'";
			ResultSet rs2 = stmt.executeQuery(quString);
			while(rs2.next()){
				type = rs2.getString("usertype");
			}
			
		
			
			if (newpassword.equals(confirmpass)) {
				if (pass.equals(oldpassword)) {
					stmt = con.createStatement();
					int i = stmt.executeUpdate("update user set username = '"+ username + "',password = '"+ newpassword + "', firstname = '"+ firstname + "', lastname = '"+ lastname + "',major ='" + selectmajor+ "' where userID = '" + strUserID+ "'"); 
	%>
	<div class="alert alert-success">
		<button type="button" class="close" data-dismiss="alert">&times;</button>
		<strong>Save Complete!</strong> The System will auto redirect to Login
		page.
	</div>
	<%
		out.print("<META HTTP-EQUIV=\"Refresh\" CONTENT=\"4;URL=LoginCMS.jsp\">");
					
				} else  {%>
	
					<div class="alert alert-danger">
		<button type="button" class="close" data-dismiss="alert">&times;</button>
		<strong>Save Fail!</strong> Your old password was wrong.
	</div>
					
			<% 
			
			// TO Redirect for Mul page authorize
			if(type.equals(tTeacher)){
				out.print("<META HTTP-EQUIV=\"Refresh\" CONTENT=\"4;URL=Teacher_Profile.jsp\">");
				
			}else if(type.equals(tAdmin)){
				out.print("<META HTTP-EQUIV=\"Refresh\" CONTENT=\"4;URL=Admin_Profile.jsp\">");
				
			}else if(type.equals(tTA)){
				out.print("<META HTTP-EQUIV=\"Refresh\" CONTENT=\"4;URL=Teacher_Assistance_Profile.jsp\">");
			}else if(type.equals(tCo)){
				out.print("<META HTTP-EQUIV=\"Refresh\" CONTENT=\"4;URL=Coordinator_Profile.jsp\">");
				
			}else{
				out.print("<META HTTP-EQUIV=\"Refresh\" CONTENT=\"4;URL=LoginCMS.jsp\">");
			}
			
			
				}
				
				stmt.close();
				con.close();
				
				
			}
		} catch (Exception e) {
			out.println(e);
		}
	%>
</body>
</html>