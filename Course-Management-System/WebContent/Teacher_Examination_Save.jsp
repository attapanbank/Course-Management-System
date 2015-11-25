<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.sql.*"%>
	<%@page import="java.io.InputStream"%>
<%@page import="java.util.Properties"%>


<script type="text/javascript">
	function closeWindow() {
		setTimeout(function() {
			window.close();
		}, 2000);
	}
	window.onload = closeWindow();
</script>
<%
	request.setCharacterEncoding("UTF-8");

	try {
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
		String courseID = request.getParameter("coursesurveyID");

		String cosName = null;
		Object strUserID = session.getAttribute("sUserID");

		String year = request.getParameter("year");
		String semester = request.getParameter("semester");

		String cosCode = request.getParameter("courseCode");
		String sFirstname = String.valueOf(session
				.getAttribute("sFirstname"));
		String sLastname = String.valueOf(session
				.getAttribute("sLastname"));

		String chkBoxWrittingMid = request
				.getParameter("chkBoxWrittingMid");
		String chkBoxMultiMid = request.getParameter("chkBoxMultiMid");
		String chkBoxOffMidNoMid = request
				.getParameter("chkBoxOffMidNoMid");

		String chkBoxWrittingFinal = request
				.getParameter("chkBoxWrittingFinal");
		String chkBoxMultiFinal = request
				.getParameter("chkBoxMultiFinal");
		String chkBoxOffFinalNoFinal = request
				.getParameter("chkBoxOffFinalNoFinal");

		String reasonMid = request.getParameter("reasonMid");
		String reasonFinal = request.getParameter("reasonFinal");

		String offMid = null;
		String noMid = null;
		String offFinal = null;
		String noFinal = null;

		String COFFS = "Off Schedule";
		String CNHV = "Not have";

		if (chkBoxOffMidNoMid != null) {
			if (chkBoxOffMidNoMid.equals(COFFS)) {
				offMid = "Off Schedule";
			} else if (chkBoxOffMidNoMid.equals(CNHV)) {
				noMid = "Not have";
			}
		}
		if (chkBoxOffFinalNoFinal != null) {
			if (chkBoxOffFinalNoFinal.equals(COFFS)) {
				offFinal = "Off Schedule";
			} else if (chkBoxOffFinalNoFinal.equals(CNHV)) {
				noFinal = "Not have";
			}
		}
		
		out.print("Save complete");

		String cosCodeHave = null;
		String examSurveyID = "";
		String queryString = "SELECT * FROM cms.examsurvey WHERE courseCode ='"
				+ cosCode
				+ "' AND year = '"
				+ year
				+ "' AND '"
				+ semester + "' ";
		ResultSet rsCheckUpdate = stmt.executeQuery(queryString);
		while (rsCheckUpdate.next()) {

			examSurveyID = rsCheckUpdate.getString("examSurveyID");
			cosCodeHave = rsCheckUpdate.getString("courseCode");

		}

		// Update or edit exammination
		if (cosCode.equals(cosCodeHave)) {
			if (chkBoxWrittingMid != null && chkBoxMultiMid != null
					&& chkBoxWrittingFinal != null
					&& chkBoxMultiFinal != null) {
				int i = stmt
						.executeUpdate("UPDATE examsurvey SET courseCode ='"
								+ cosCodeHave
								+ "',midtermType = 'MD',finalType = 'MD',reasonMid ='"
								+ reasonMid
								+ "',reasonFinal = '"
								+ reasonFinal
								+ "' where examSurveyID ='"
								+ examSurveyID + "' ");
			} else if (chkBoxWrittingMid != null
					&& chkBoxMultiMid != null
					&& chkBoxWrittingFinal != null
					&& chkBoxMultiFinal == null) {
				int i = stmt
						.executeUpdate("UPDATE examsurvey SET courseCode ='"
								+ cosCodeHave
								+ "',midtermType = 'MD',finalType = '"+chkBoxWrittingFinal+"',reasonMid ='"
								+ reasonMid
								+ "',reasonFinal = '"
								+ reasonFinal
								+ "' where examSurveyID ='"
								+ examSurveyID + "' ");

			} else if (chkBoxWrittingMid != null
					&& chkBoxMultiMid != null
					&& chkBoxMultiFinal != null
					&& chkBoxWrittingFinal == null) {
				int i = stmt
						.executeUpdate("UPDATE examsurvey SET courseCode ='"
								+ cosCodeHave
								+ "',midtermType = 'MD',finalType = '"+chkBoxWrittingFinal+"',reasonMid ='"
								+ reasonMid
								+ "',reasonFinal = '"
								+ reasonFinal
								+ "' where examSurveyID ='"
								+ examSurveyID + "' ");

			} else if (chkBoxWrittingMid != null
					&& chkBoxMultiMid != null && noFinal != null) {
				int i = stmt
						.executeUpdate("UPDATE examsurvey SET courseCode ='"
								+ cosCodeHave
								+ "',midtermType = 'MD',finalType = '"+noFinal+"',reasonMid ='"
								+ reasonMid
								+ "',reasonFinal = '"
								+ reasonFinal
								+ "' where examSurveyID ='"
								+ examSurveyID + "' ");

			} else if (chkBoxWrittingMid != null
					&& chkBoxMultiMid != null && offFinal != null) {
				int i = stmt
						.executeUpdate("UPDATE examsurvey SET courseCode ='"
								+ cosCodeHave
								+ "',midtermType = 'MD',finalType = '"+offFinal+"',reasonMid ='"
								+ reasonMid
								+ "',reasonFinal = '"
								+ reasonFinal
								+ "' where examSurveyID ='"
								+ examSurveyID + "' ");

			} else if (chkBoxWrittingMid != null
					&& chkBoxMultiMid != null && reasonFinal != null) {
				int i = stmt
						.executeUpdate("UPDATE examsurvey SET courseCode ='"
								+ cosCodeHave
								+ "',midtermType = 'MD',finalType = 'Not have',reasonMid ='"
								+ reasonMid
								+ "',reasonFinal = '"
								+ reasonFinal
								+ "' where examSurveyID ='"
								+ examSurveyID + "' ");

			} else if (chkBoxWrittingFinal != null
					&& chkBoxMultiFinal != null
					&& chkBoxWrittingMid != null) {
				int i = stmt
						.executeUpdate("UPDATE examsurvey SET courseCode ='"
								+ cosCodeHave
								+ "',midtermType = '"+chkBoxWrittingMid+"',finalType = 'MD',reasonMid ='"
								+ reasonMid
								+ "',reasonFinal = '"
								+ reasonFinal
								+ "' where examSurveyID ='"
								+ examSurveyID + "' ");
			} else if (chkBoxWrittingFinal != null
					&& chkBoxMultiFinal != null
					&& chkBoxMultiMid != null) {
				int i = stmt
						.executeUpdate("UPDATE examsurvey SET courseCode ='"
								+ cosCodeHave
								+ "',midtermType = '"+chkBoxMultiMid+"',finalType = 'MD',reasonMid ='"
								+ reasonMid
								+ "',reasonFinal = '"
								+ reasonFinal
								+ "' where examSurveyID ='"
								+ examSurveyID + "' ");
			} else if (chkBoxMultiFinal != null
					&& chkBoxWrittingFinal != null && offMid != null) {
				int i = stmt
						.executeUpdate("UPDATE examsurvey SET courseCode ='"
								+ cosCodeHave
								+ "',midtermType = '"+offMid+"',finalType = 'MD',reasonMid ='"
								+ reasonMid
								+ "',reasonFinal = '"
								+ reasonFinal
								+ "' where examSurveyID ='"
								+ examSurveyID + "' ");

			} else if (chkBoxMultiFinal != null
					&& chkBoxWrittingFinal != null && noMid != null) {
				int i = stmt
						.executeUpdate("UPDATE examsurvey SET courseCode ='"
								+ cosCodeHave
								+ "',midtermType = '"+noMid+"',finalType = 'MD',reasonMid ='"
								+ reasonMid
								+ "',reasonFinal = '"
								+ reasonFinal
								+ "' where examSurveyID ='"
								+ examSurveyID + "' ");

			} else if (chkBoxMultiFinal != null
					&& chkBoxWrittingFinal != null && reasonMid != null) {
				int i = stmt
						.executeUpdate("UPDATE examsurvey SET courseCode ='"
								+ cosCodeHave
								+ "',midtermType = 'Not have',finalType = 'MD',reasonMid ='"
								+ reasonMid
								+ "',reasonFinal = '"
								+ reasonFinal
								+ "' where examSurveyID ='"
								+ examSurveyID + "' ");

			} else if (chkBoxWrittingMid != null
					&& chkBoxWrittingFinal != null) {
				int i = stmt
						.executeUpdate("UPDATE examsurvey SET courseCode ='"
								+ cosCodeHave
								+ "',midtermType = '"+chkBoxWrittingMid+"',finalType = '"+chkBoxWrittingFinal+"',reasonMid ='"
								+ reasonMid
								+ "',reasonFinal = '"
								+ reasonFinal
								+ "' where examSurveyID ='"
								+ examSurveyID + "' ");

			} else if (chkBoxWrittingMid != null
					&& chkBoxMultiFinal != null) {
				int i = stmt
						.executeUpdate("UPDATE examsurvey SET courseCode ='"
								+ cosCodeHave
								+ "',midtermType = '"+chkBoxWrittingMid+"',finalType = '"+chkBoxMultiFinal+"',reasonMid ='"
								+ reasonMid
								+ "',reasonFinal = '"
								+ reasonFinal
								+ "' where examSurveyID ='"
								+ examSurveyID + "' ");


			} else if (chkBoxWrittingMid != null && offFinal != null) {
				int i = stmt
						.executeUpdate("UPDATE examsurvey SET courseCode ='"
								+ cosCodeHave
								+ "',midtermType = '"+chkBoxWrittingMid+"',finalType = '"+offFinal+"',reasonMid ='"
								+ reasonMid
								+ "',reasonFinal = '"
								+ reasonFinal
								+ "' where examSurveyID ='"
								+ examSurveyID + "' ");


			} else if (chkBoxWrittingMid != null && noFinal != null) {
				int i = stmt
						.executeUpdate("UPDATE examsurvey SET courseCode ='"
								+ cosCodeHave
								+ "',midtermType = '"+chkBoxWrittingMid+"',finalType = '"+noFinal+"',reasonMid ='"
								+ reasonMid
								+ "',reasonFinal = '"
								+ reasonFinal
								+ "' where examSurveyID ='"
								+ examSurveyID + "' ");


			} else if (chkBoxMultiMid != null
					&& chkBoxWrittingFinal != null) {
				int i = stmt
						.executeUpdate("UPDATE examsurvey SET courseCode ='"
								+ cosCodeHave
								+ "',midtermType = '"+chkBoxMultiFinal+"',finalType = '"+chkBoxWrittingFinal+"',reasonMid ='"
								+ reasonMid
								+ "',reasonFinal = '"
								+ reasonFinal
								+ "' where examSurveyID ='"
								+ examSurveyID + "' ");

			} else if (chkBoxMultiMid != null
					&& chkBoxMultiFinal != null) {
				int i = stmt
						.executeUpdate("UPDATE examsurvey SET courseCode ='"
								+ cosCodeHave
								+ "',midtermType = '"+chkBoxMultiMid+"',finalType = '"+chkBoxMultiFinal+"',reasonMid ='"
								+ reasonMid
								+ "',reasonFinal = '"
								+ reasonFinal
								+ "' where examSurveyID ='"
								+ examSurveyID + "' ");


			} else if (chkBoxMultiMid != null && offFinal != null) {
				int i = stmt
						.executeUpdate("UPDATE examsurvey SET courseCode ='"
								+ cosCodeHave
								+ "',midtermType = '"+chkBoxMultiMid+"',finalType = '"+offFinal+"',reasonMid ='"
								+ reasonMid
								+ "',reasonFinal = '"
								+ reasonFinal
								+ "' where examSurveyID ='"
								+ examSurveyID + "' ");


			} else if (chkBoxMultiMid != null && noFinal != null) {
				int i = stmt
						.executeUpdate("UPDATE examsurvey SET courseCode ='"
								+ cosCodeHave
								+ "',midtermType = '"+chkBoxMultiMid+"',finalType = '"+noFinal+"',reasonMid ='"
								+ reasonMid
								+ "',reasonFinal = '"
								+ reasonFinal
								+ "' where examSurveyID ='"
								+ examSurveyID + "' ");


			} else if (offMid != null && chkBoxWrittingFinal != null) {
				int i = stmt
						.executeUpdate("UPDATE examsurvey SET courseCode ='"
								+ cosCodeHave
								+ "',midtermType = '"+offMid+"',finalType = '"+chkBoxWrittingFinal+"',reasonMid ='"
								+ reasonMid
								+ "',reasonFinal = '"
								+ reasonFinal
								+ "' where examSurveyID ='"
								+ examSurveyID + "' ");


			} else if (noMid != null && chkBoxWrittingFinal != null) {
				int i = stmt
						.executeUpdate("UPDATE examsurvey SET courseCode ='"
								+ cosCodeHave
								+ "',midtermType = '"+noMid+"',finalType = '"+chkBoxWrittingFinal+"',reasonMid ='"
								+ reasonMid
								+ "',reasonFinal = '"
								+ reasonFinal
								+ "' where examSurveyID ='"
								+ examSurveyID + "' ");


			} else if (offMid != null && chkBoxMultiFinal != null) {
				int i = stmt
						.executeUpdate("UPDATE examsurvey SET courseCode ='"
								+ cosCodeHave
								+ "',midtermType = '"+offMid+"',finalType = '"+chkBoxMultiFinal+"',reasonMid ='"
								+ reasonMid
								+ "',reasonFinal = '"
								+ reasonFinal
								+ "' where examSurveyID ='"
								+ examSurveyID + "' ");


			} else if (noMid != null && chkBoxMultiFinal != null) {
				int i = stmt
						.executeUpdate("UPDATE examsurvey SET courseCode ='"
								+ cosCodeHave
								+ "',midtermType = '"+noMid+"',finalType = '"+chkBoxMultiFinal+"',reasonMid ='"
								+ reasonMid
								+ "',reasonFinal = '"
								+ reasonFinal
								+ "' where examSurveyID ='"
								+ examSurveyID + "' ");


			} else if (offMid != null && offFinal != null) {
				int i = stmt
						.executeUpdate("UPDATE examsurvey SET courseCode ='"
								+ cosCodeHave
								+ "',midtermType = '"+offMid+"',finalType = '"+offFinal+"',reasonMid ='"
								+ reasonMid
								+ "',reasonFinal = '"
								+ reasonFinal
								+ "' where examSurveyID ='"
								+ examSurveyID + "' ");


			} else if (offMid != null && noFinal != null) {
				int i = stmt
						.executeUpdate("UPDATE examsurvey SET courseCode ='"
								+ cosCodeHave
								+ "',midtermType = '"+offMid+"',finalType = '"+noFinal+"',reasonMid ='"
								+ reasonMid
								+ "',reasonFinal = '"
								+ reasonFinal
								+ "' where examSurveyID ='"
								+ examSurveyID + "' ");


			} else if (noMid != null && offFinal != null) {
				int i = stmt
						.executeUpdate("UPDATE examsurvey SET courseCode ='"
								+ cosCodeHave
								+ "',midtermType = '"+noMid+"',finalType = '"+offFinal+"',reasonMid ='"
								+ reasonMid
								+ "',reasonFinal = '"
								+ reasonFinal
								+ "' where examSurveyID ='"
								+ examSurveyID + "' ");

			} else if (noMid != null && noFinal != null) {
				int i = stmt
						.executeUpdate("UPDATE examsurvey SET courseCode ='"
								+ cosCodeHave
								+ "',midtermType = '"+noMid+"',finalType = '"+noFinal+"',reasonMid ='"
								+ reasonMid
								+ "',reasonFinal = '"
								+ reasonFinal
								+ "' where examSurveyID ='"
								+ examSurveyID + "' ");


			} else if (chkBoxWrittingMid == null
					&& chkBoxMultiMid == null && offMid == null
					&& chkBoxWrittingFinal == null
					&& chkBoxMultiFinal == null && offFinal == null) {
				int i = stmt
						.executeUpdate("UPDATE examsurvey SET courseCode ='"
								+ cosCodeHave
								+ "',midtermType = 'Not have',finalType = 'Not have',reasonMid ='"
								+ reasonMid
								+ "',reasonFinal = '"
								+ reasonFinal
								+ "' where examSurveyID ='"
								+ examSurveyID + "' ");


			} else if (chkBoxWrittingMid == null
					&& chkBoxMultiMid == null && noMid == null
					&& chkBoxWrittingFinal == null
					&& chkBoxMultiFinal == null && noFinal == null) {
				int i = stmt
						.executeUpdate("UPDATE examsurvey SET courseCode ='"
								+ cosCodeHave
								+ "',midtermType = 'Not have',finalType = 'Not have',reasonMid ='"
								+ reasonMid
								+ "',reasonFinal = '"
								+ reasonFinal
								+ "' where examSurveyID ='"
								+ examSurveyID + "' ");


			} else if (chkBoxWrittingMid != null
					&& chkBoxMultiMid == null && offMid == null
					&& reasonFinal != null) {
				int i = stmt
						.executeUpdate("UPDATE examsurvey SET courseCode ='"
								+ cosCodeHave
								+ "',midtermType = '"+chkBoxWrittingMid+"',finalType = 'Not have',reasonMid ='"
								+ reasonMid
								+ "',reasonFinal = '"
								+ reasonFinal
								+ "' where examSurveyID ='"
								+ examSurveyID + "' ");


			} else if (chkBoxWrittingMid != null
					&& chkBoxMultiMid == null && noMid == null
					&& reasonFinal != null) {
				int i = stmt
						.executeUpdate("UPDATE examsurvey SET courseCode ='"
								+ cosCodeHave
								+ "',midtermType = '"+chkBoxWrittingMid+"',finalType = 'Not have',reasonMid ='"
								+ reasonMid
								+ "',reasonFinal = '"
								+ reasonFinal
								+ "' where examSurveyID ='"
								+ examSurveyID + "' ");


			} else if (chkBoxWrittingMid == null
					&& chkBoxMultiMid != null && offMid == null
					&& reasonFinal != null) {
				int i = stmt
						.executeUpdate("UPDATE examsurvey SET courseCode ='"
								+ cosCodeHave
								+ "',midtermType = '"+chkBoxMultiMid+"',finalType = 'Not have',reasonMid ='"
								+ reasonMid
								+ "',reasonFinal = '"
								+ reasonFinal
								+ "' where examSurveyID ='"
								+ examSurveyID + "' ");


			} else if (chkBoxWrittingMid == null
					&& chkBoxMultiMid != null && noMid == null
					&& reasonFinal != null) {
				int i = stmt
						.executeUpdate("UPDATE examsurvey SET courseCode ='"
								+ cosCodeHave
								+ "',midtermType = '"+chkBoxMultiMid+"',finalType = 'Not have',reasonMid ='"
								+ reasonMid
								+ "',reasonFinal = '"
								+ reasonFinal
								+ "' where examSurveyID ='"
								+ examSurveyID + "' ");


			} else if (chkBoxWrittingMid == null
					&& chkBoxMultiMid == null && offMid != null
					&& reasonFinal != null) {
				int i = stmt
						.executeUpdate("UPDATE examsurvey SET courseCode ='"
								+ cosCodeHave
								+ "',midtermType = '"+offMid+"',finalType = 'Not have',reasonMid ='"
								+ reasonMid
								+ "',reasonFinal = '"
								+ reasonFinal
								+ "' where examSurveyID ='"
								+ examSurveyID + "' ");


			} else if (chkBoxWrittingMid == null
					&& chkBoxMultiMid == null && noMid != null
					&& reasonFinal != null) {
				int i = stmt
						.executeUpdate("UPDATE examsurvey SET courseCode ='"
								+ cosCodeHave
								+ "',midtermType = '"+noMid+"',finalType = 'Not have',reasonMid ='"
								+ reasonMid
								+ "',reasonFinal = '"
								+ reasonFinal
								+ "' where examSurveyID ='"
								+ examSurveyID + "' ");


			} else if (chkBoxWrittingFinal != null
					&& chkBoxMultiFinal == null && offFinal == null
					&& reasonMid != null) {
				int i = stmt
						.executeUpdate("UPDATE examsurvey SET courseCode ='"
								+ cosCodeHave
								+ "',midtermType = 'Not have',finalType = '"+chkBoxWrittingFinal+"',reasonMid ='"
								+ reasonMid
								+ "',reasonFinal = '"
								+ reasonFinal
								+ "' where examSurveyID ='"
								+ examSurveyID + "' ");


			} else if (chkBoxWrittingFinal != null
					&& chkBoxMultiFinal == null && noFinal == null
					&& reasonMid != null) {
				int i = stmt
						.executeUpdate("UPDATE examsurvey SET courseCode ='"
								+ cosCodeHave
								+ "',midtermType = 'Not have',finalType = '"+chkBoxWrittingFinal+"',reasonMid ='"
								+ reasonMid
								+ "',reasonFinal = '"
								+ reasonFinal
								+ "' where examSurveyID ='"
								+ examSurveyID + "' ");


			} else if (chkBoxWrittingFinal == null
					&& chkBoxMultiFinal != null && offFinal == null
					&& reasonMid != null) {
				int i = stmt
						.executeUpdate("UPDATE examsurvey SET courseCode ='"
								+ cosCodeHave
								+ "',midtermType = 'Not have',finalType = '"+chkBoxMultiFinal+"',reasonMid ='"
								+ reasonMid
								+ "',reasonFinal = '"
								+ reasonFinal
								+ "' where examSurveyID ='"
								+ examSurveyID + "' ");


			} else if (chkBoxWrittingFinal == null
					&& chkBoxMultiFinal != null && noFinal == null
					&& reasonMid != null) {
				int i = stmt
						.executeUpdate("UPDATE examsurvey SET courseCode ='"
								+ cosCodeHave
								+ "',midtermType = 'Not have',finalType = '"+chkBoxMultiFinal+"',reasonMid ='"
								+ reasonMid
								+ "',reasonFinal = '"
								+ reasonFinal
								+ "' where examSurveyID ='"
								+ examSurveyID + "' ");


			} else if (chkBoxWrittingFinal == null
					&& chkBoxMultiFinal == null && offFinal != null
					&& reasonMid != null) {
				int i = stmt
						.executeUpdate("UPDATE examsurvey SET courseCode ='"
								+ cosCodeHave
								+ "',midtermType = 'Not have',finalType = '"+offFinal+"',reasonMid ='"
								+ reasonMid
								+ "',reasonFinal = '"
								+ reasonFinal
								+ "' where examSurveyID ='"
								+ examSurveyID + "' ");


			} else if (chkBoxWrittingFinal == null
					&& chkBoxMultiFinal == null && noFinal != null
					&& reasonMid != null) {
				int i = stmt
						.executeUpdate("UPDATE examsurvey SET courseCode ='"
								+ cosCodeHave
								+ "',midtermType = 'Not have',finalType = '"+noFinal+"',reasonMid ='"
								+ reasonMid
								+ "',reasonFinal = '"
								+ reasonFinal
								+ "' where examSurveyID ='"
								+ examSurveyID + "' ");

			}
		} else {

			if (chkBoxWrittingMid != null && chkBoxMultiMid != null
					&& chkBoxWrittingFinal != null
					&& chkBoxMultiFinal != null) {

				String QueryString = "INSERT INTO examsurvey (courseCode, midtermType, finalType, reasonMid,reasonFinal,year,semester) VALUES ('"
						+ cosCode
						+ "', '"
						+ "MD"
						+ "', '"
						+ "MD"
						+ "' , '"
						+ reasonMid
						+ "', '"
						+ reasonFinal
						+ "', '" + year + "', '" + semester + "')";
				stmt.executeUpdate(QueryString);
			} else if (chkBoxWrittingMid != null
					&& chkBoxMultiMid != null
					&& chkBoxWrittingFinal != null
					&& chkBoxMultiFinal == null) {
				String QueryString = "INSERT INTO examsurvey (courseCode, midtermType, finalType, reasonMid,reasonFinal,year,semester) VALUES ('"
						+ cosCode
						+ "', '"
						+ "MD"
						+ "',  '"
						+ chkBoxWrittingFinal
						+ "', '"
						+ reasonMid
						+ "', '"
						+ reasonFinal
						+ "', '"
						+ year
						+ "', '"
						+ semester + "')";
				stmt.executeUpdate(QueryString);

			} else if (chkBoxWrittingMid != null
					&& chkBoxMultiMid != null
					&& chkBoxMultiFinal != null
					&& chkBoxWrittingFinal == null) {
				String QueryString = "INSERT INTO examsurvey (courseCode,  midtermType, finalType, reasonMid,reasonFinal,year,semester) VALUES ('"
						+ cosCode
						+ "',  '"
						+ "MD"
						+ "',  '"
						+ chkBoxMultiFinal
						+ "', '"
						+ reasonMid
						+ "', '"
						+ reasonFinal
						+ "', '"
						+ year
						+ "', '"
						+ semester + "')";
				stmt.executeUpdate(QueryString);

			} else if (chkBoxWrittingMid != null
					&& chkBoxMultiMid != null && noFinal != null) {
				String QueryString = "INSERT INTO examsurvey (courseCode,  midtermType, finalType, reasonMid,reasonFinal,year,semester) VALUES ('"
						+ cosCode
						+ "', '"
						+ "MD"
						+ "',  '"
						+ noFinal
						+ "', '"
						+ reasonMid
						+ "', '"
						+ reasonFinal
						+ "', '" + year + "', '" + semester + "')";
				stmt.executeUpdate(QueryString);

			} else if (chkBoxWrittingMid != null
					&& chkBoxMultiMid != null && offFinal != null) {
				String QueryString = "INSERT INTO examsurvey (courseCode,  midtermType, finalType, reasonMid,reasonFinal,year,semester) VALUES ('"
						+ cosCode
						+ "', '"
						+ "MD"
						+ "',  '"
						+ "Off Schedule"
						+ "', '"
						+ reasonMid
						+ "', '"
						+ reasonFinal
						+ "', '"
						+ year
						+ "', '"
						+ semester + "')";
				stmt.executeUpdate(QueryString);

			} else if (chkBoxWrittingMid != null
					&& chkBoxMultiMid != null && reasonFinal != null) {
				String QueryString = "INSERT INTO examsurvey (courseCode,  midtermType, finalType, reasonMid,reasonFinal,year,semester) VALUES ('"
						+ cosCode
						+ "', '"
						+ "MD"
						+ "',  '"
						+ "Not have"
						+ "', '"
						+ reasonMid
						+ "', '"
						+ reasonFinal
						+ "', '"
						+ year
						+ "', '"
						+ semester + "')";
				stmt.executeUpdate(QueryString);
			} else if (chkBoxWrittingFinal != null
					&& chkBoxMultiFinal != null
					&& chkBoxWrittingMid != null) {
				String QueryString = "INSERT INTO examsurvey (courseCode,  midtermType, finalType, reasonMid,reasonFinal,year,semester) VALUES ('"
						+ cosCode
						+ "', '"
						+ chkBoxWrittingMid
						+ "',  '"
						+ "MD"
						+ "', '"
						+ reasonMid
						+ "', '"
						+ reasonFinal
						+ "', '"
						+ year
						+ "', '"
						+ semester + "')";
				stmt.executeUpdate(QueryString);

			} else if (chkBoxWrittingFinal != null
					&& chkBoxMultiFinal != null
					&& chkBoxMultiMid != null) {
				String QueryString = "INSERT INTO examsurvey (courseCode,  midtermType, finalType, reasonMid,reasonFinal,year,semester) VALUES ('"
						+ cosCode
						+ "','"
						+ chkBoxMultiMid
						+ "',  '"
						+ "MD"
						+ "', '"
						+ reasonMid
						+ "', '"
						+ reasonFinal
						+ "', '"
						+ year
						+ "', '"
						+ semester + "')";
				stmt.executeUpdate(QueryString);

			} else if (chkBoxMultiFinal != null
					&& chkBoxWrittingFinal != null && offMid != null) {
				String QueryString = "INSERT INTO examsurvey (courseCode,  midtermType, finalType, reasonMid,reasonFinal,year,semester) VALUES ('"
						+ cosCode
						+ "',  '"
						+ offMid
						+ "',  '"
						+ "MD"
						+ "', '"
						+ reasonMid
						+ "', '"
						+ reasonFinal
						+ "', '" + year + "', '" + semester + "')";
				stmt.executeUpdate(QueryString);
			} else if (chkBoxMultiFinal != null
					&& chkBoxWrittingFinal != null && noMid != null) {
				String QueryString = "INSERT INTO examsurvey (courseCode,  midtermType, finalType, reasonMid,reasonFinal,year,semester) VALUES ('"
						+ cosCode
						+ "',  '"
						+ noMid
						+ "',  '"
						+ "MD"
						+ "', '"
						+ reasonMid
						+ "', '"
						+ reasonFinal
						+ "', '" + year + "', '" + semester + "')";
				stmt.executeUpdate(QueryString);
			} else if (chkBoxMultiFinal != null
					&& chkBoxWrittingFinal != null && reasonMid != null) {
				String QueryString = "INSERT INTO examsurvey (courseCode,  midtermType, finalType, reasonMid,reasonFinal,year,semester) VALUES ('"
						+ cosCode
						+ "', '"
						+ "Not have"
						+ "',  '"
						+ "MD"
						+ "', '"
						+ reasonMid
						+ "', '"
						+ reasonFinal
						+ "', '"
						+ year
						+ "', '"
						+ semester + "')";
				stmt.executeUpdate(QueryString);
			} else if (chkBoxWrittingMid != null
					&& chkBoxWrittingFinal != null) {
				String QueryString = "INSERT INTO examsurvey (courseCode,  midtermType, finalType, reasonMid,reasonFinal,year,semester) VALUES ('"
						+ cosCode
						+ "', '"
						+ chkBoxWrittingMid
						+ "',  '"
						+ chkBoxWrittingFinal
						+ "', '"
						+ reasonMid
						+ "', '"
						+ reasonFinal
						+ "', '"
						+ year + "', '" + semester + "')";
				stmt.executeUpdate(QueryString);

			} else if (chkBoxWrittingMid != null
					&& chkBoxMultiFinal != null) {
				String QueryString = "INSERT INTO examsurvey (courseCode,  midtermType, finalType, reasonMid,reasonFinal,year,semester) VALUES ('"
						+ cosCode
						+ "', '"
						+ chkBoxWrittingMid
						+ "',  '"
						+ chkBoxMultiFinal
						+ "', '"
						+ reasonMid
						+ "','"
						+ reasonFinal
						+ "', '"
						+ year + "', '" + semester + "')";
				stmt.executeUpdate(QueryString);
			} else if (chkBoxWrittingMid != null && offFinal != null) {
				String QueryString = "INSERT INTO examsurvey (courseCode,  midtermType, finalType, reasonMid,reasonFinal,year,semester) VALUES ('"
						+ cosCode
						+ "', '"
						+ chkBoxWrittingMid
						+ "',  '"
						+ offFinal
						+ "', '"
						+ reasonMid
						+ "', '"
						+ reasonFinal
						+ "', '"
						+ year
						+ "', '"
						+ semester + "')";
				stmt.executeUpdate(QueryString);
			} else if (chkBoxWrittingMid != null && noFinal != null) {
				String QueryString = "INSERT INTO examsurvey (courseCode,  midtermType, finalType, reasonMid,reasonFinal,year,semester) VALUES ('"
						+ cosCode
						+ "', '"
						+ chkBoxWrittingMid
						+ "',  '"
						+ noFinal
						+ "', '"
						+ reasonMid
						+ "', '"
						+ reasonFinal
						+ "', '"
						+ year
						+ "', '"
						+ semester + "')";
				stmt.executeUpdate(QueryString);
			} else if (chkBoxMultiMid != null
					&& chkBoxWrittingFinal != null) {
				String QueryString = "INSERT INTO examsurvey (courseCode,  midtermType, finalType, reasonMid,reasonFinal,year,semester) VALUES ('"
						+ cosCode
						+ "', '"
						+ chkBoxMultiMid
						+ "',  '"
						+ chkBoxWrittingFinal
						+ "', '"
						+ reasonMid
						+ "', '"
						+ reasonFinal
						+ "', '"
						+ year
						+ "', '"
						+ semester + "')";
				stmt.executeUpdate(QueryString);

			} else if (chkBoxMultiMid != null
					&& chkBoxMultiFinal != null) {
				String QueryString = "INSERT INTO examsurvey (courseCode,  midtermType, finalType, reasonMid,reasonFinal,year,semester) VALUES ('"
						+ cosCode
						+ "','"
						+ chkBoxMultiMid
						+ "',  '"
						+ chkBoxMultiFinal
						+ "', '"
						+ reasonMid
						+ "', '"
						+ reasonFinal
						+ "', '"
						+ year
						+ "', '"
						+ semester + "')";
				stmt.executeUpdate(QueryString);

			} else if (chkBoxMultiMid != null && offFinal != null) {
				String QueryString = "INSERT INTO examsurvey (courseCode,  midtermType, finalType, reasonMid,reasonFinal,year,semester) VALUES ('"
						+ cosCode
						+ "',  '"
						+ chkBoxMultiMid
						+ "',  '"
						+ offFinal
						+ "', '"
						+ reasonMid
						+ "', '"
						+ reasonFinal
						+ "', '"
						+ year
						+ "', '"
						+ semester + "')";
				stmt.executeUpdate(QueryString);

			} else if (chkBoxMultiMid != null && noFinal != null) {
				String QueryString = "INSERT INTO examsurvey (courseCode,  midtermType, finalType, reasonMid,reasonFinal,year,semester) VALUES ('"
						+ cosCode
						+ "',  '"
						+ chkBoxMultiMid
						+ "',  '"
						+ noFinal
						+ "', '"
						+ reasonMid
						+ "', '"
						+ reasonFinal
						+ "', '"
						+ year
						+ "', '"
						+ semester + "')";
				stmt.executeUpdate(QueryString);

			} else if (offMid != null && chkBoxWrittingFinal != null) {
				String QueryString = "INSERT INTO examsurvey (courseCode,  midtermType, finalType, reasonMid,reasonFinal,year,semester) VALUES ('"
						+ cosCode
						+ "',  '"
						+ offMid
						+ "',  '"
						+ chkBoxWrittingFinal
						+ "', '"
						+ reasonMid
						+ "', '"
						+ reasonFinal
						+ "', '"
						+ year
						+ "', '"
						+ semester + "')";
				stmt.executeUpdate(QueryString);

			} else if (noMid != null && chkBoxWrittingFinal != null) {
				String QueryString = "INSERT INTO examsurvey (courseCode,  midtermType, finalType, reasonMid,reasonFinal,year,semester) VALUES ('"
						+ cosCode
						+ "',  '"
						+ noMid
						+ "',  '"
						+ chkBoxWrittingFinal
						+ "', '"
						+ reasonMid
						+ "', '"
						+ reasonFinal
						+ "', '"
						+ year
						+ "', '"
						+ semester + "')";
				stmt.executeUpdate(QueryString);

			} else if (offMid != null && chkBoxMultiFinal != null) {
				String QueryString = "INSERT INTO examsurvey (courseCode,  midtermType, finalType, reasonMid,reasonFinal,year,semester) VALUES ('"
						+ cosCode
						+ "',  '"
						+ offMid
						+ "',  '"
						+ chkBoxMultiFinal
						+ "', '"
						+ reasonMid
						+ "', '"
						+ reasonFinal
						+ "', '"
						+ year
						+ "', '"
						+ semester + "')";
				stmt.executeUpdate(QueryString);

			} else if (noMid != null && chkBoxMultiFinal != null) {
				String QueryString = "INSERT INTO examsurvey (courseCode,  midtermType, finalType, reasonMid,reasonFinal,year,semester) VALUES ('"
						+ cosCode
						+ "',  '"
						+ noMid
						+ "',  '"
						+ chkBoxMultiFinal
						+ "', '"
						+ reasonMid
						+ "', '"
						+ reasonFinal
						+ "', '"
						+ year
						+ "', '"
						+ semester + "')";
				stmt.executeUpdate(QueryString);

			} else if (offMid != null && offFinal != null) {
				String QueryString = "INSERT INTO examsurvey (courseCode,  midtermType, finalType, reasonMid,reasonFinal,year,semester) VALUES ('"
						+ cosCode
						+ "',  '"
						+ offMid
						+ "',  '"
						+ offFinal
						+ "', '"
						+ reasonMid
						+ "', '"
						+ reasonFinal
						+ "', '"
						+ year
						+ "', '"
						+ semester + "')";
				stmt.executeUpdate(QueryString);

			} else if (offMid != null && noFinal != null) {
				String QueryString = "INSERT INTO examsurvey (courseCode,  midtermType, finalType, reasonMid,reasonFinal,year,semester) VALUES ('"
						+ cosCode
						+ "',  '"
						+ offMid
						+ "',  '"
						+ noFinal
						+ "', '"
						+ reasonMid
						+ "', '"
						+ reasonFinal
						+ "', '"
						+ year
						+ "', '"
						+ semester + "')";
				stmt.executeUpdate(QueryString);

			} else if (noMid != null && offFinal != null) {
				String QueryString = "INSERT INTO examsurvey (courseCode,  midtermType, finalType, reasonMid,reasonFinal,year,semester) VALUES ('"
						+ cosCode
						+ "',  '"
						+ noMid
						+ "',  '"
						+ offFinal
						+ "', '"
						+ reasonMid
						+ "', '"
						+ reasonFinal
						+ "', '"
						+ year
						+ "', '"
						+ semester + "')";
				stmt.executeUpdate(QueryString);

			} else if (noMid != null && noFinal != null) {
				String QueryString = "INSERT INTO examsurvey (courseCode,  midtermType, finalType, reasonMid,reasonFinal,year,semester) VALUES ('"
						+ cosCode
						+ "',  '"
						+ noMid
						+ "',  '"
						+ noFinal
						+ "', '"
						+ reasonMid
						+ "', '"
						+ reasonFinal
						+ "', '" + year + "', '" + semester + "')";
				stmt.executeUpdate(QueryString);

			} else if (chkBoxWrittingMid == null
					&& chkBoxMultiMid == null && offMid == null
					&& chkBoxWrittingFinal == null
					&& chkBoxMultiFinal == null && offFinal == null) {
				String QueryString = "INSERT INTO examsurvey (courseCode,  midtermType, finalType, reasonMid,reasonFinal,year,semester) VALUES ('"
						+ cosCode
						+ "',  '"
						+ "Not have"
						+ "',  '"
						+ "Not have"
						+ "', '"
						+ reasonMid
						+ "', '"
						+ reasonFinal
						+ "', '"
						+ year
						+ "', '"
						+ semester + "')";
				stmt.executeUpdate(QueryString);
			} else if (chkBoxWrittingMid == null
					&& chkBoxMultiMid == null && noMid == null
					&& chkBoxWrittingFinal == null
					&& chkBoxMultiFinal == null && noFinal == null) {
				String QueryString = "INSERT INTO examsurvey (courseCode,  midtermType, finalType, reasonMid,reasonFinal,year,semester) VALUES ('"
						+ cosCode
						+ "',  '"
						+ "Not have"
						+ "',  '"
						+ "Not have"
						+ "', '"
						+ reasonMid
						+ "', '"
						+ reasonFinal
						+ "', '"
						+ year
						+ "', '"
						+ semester + "')";
				stmt.executeUpdate(QueryString);
			} else if (chkBoxWrittingMid != null
					&& chkBoxMultiMid == null && offMid == null
					&& reasonFinal != null) {
				String QueryString = "INSERT INTO examsurvey (courseCode,  midtermType, finalType, reasonMid,reasonFinal,year,semester) VALUES ('"
						+ cosCode
						+ "',  '"
						+ chkBoxWrittingMid
						+ "',  '"
						+ "Not have"
						+ "', '"
						+ reasonMid
						+ "', '"
						+ reasonFinal
						+ "', '"
						+ year
						+ "', '"
						+ semester + "')";
				stmt.executeUpdate(QueryString);
			} else if (chkBoxWrittingMid != null
					&& chkBoxMultiMid == null && noMid == null
					&& reasonFinal != null) {
				String QueryString = "INSERT INTO examsurvey (courseCode,  midtermType, finalType, reasonMid,reasonFinal,year,semester) VALUES ('"
						+ cosCode
						+ "',  '"
						+ chkBoxWrittingMid
						+ "',  '"
						+ "Not have"
						+ "', '"
						+ reasonMid
						+ "', '"
						+ reasonFinal
						+ "', '"
						+ year
						+ "', '"
						+ semester + "')";
				stmt.executeUpdate(QueryString);
			} else if (chkBoxWrittingMid == null
					&& chkBoxMultiMid != null && offMid == null
					&& reasonFinal != null) {
				String QueryString = "INSERT INTO examsurvey (courseCode,  midtermType, finalType, reasonMid,reasonFinal,year,semester) VALUES ('"
						+ cosCode
						+ "',  '"
						+ chkBoxMultiMid
						+ "',  '"
						+ "Not have"
						+ "', '"
						+ reasonMid
						+ "', '"
						+ reasonFinal
						+ "', '"
						+ year
						+ "', '"
						+ semester + "')";
				stmt.executeUpdate(QueryString);
			} else if (chkBoxWrittingMid == null
					&& chkBoxMultiMid != null && noMid == null
					&& reasonFinal != null) {
				String QueryString = "INSERT INTO examsurvey (courseCode,  midtermType, finalType, reasonMid,reasonFinal,year,semester) VALUES ('"
						+ cosCode
						+ "',  '"
						+ chkBoxMultiMid
						+ "',  '"
						+ "Not have"
						+ "', '"
						+ reasonMid
						+ "', '"
						+ reasonFinal
						+ "', '"
						+ year
						+ "', '"
						+ semester + "')";
				stmt.executeUpdate(QueryString);
			} else if (chkBoxWrittingMid == null
					&& chkBoxMultiMid == null && offMid != null
					&& reasonFinal != null) {
				String QueryString = "INSERT INTO examsurvey (courseCode,  midtermType, finalType, reasonMid,reasonFinal,year,semester) VALUES ('"
						+ cosCode
						+ "',  '"
						+ offMid
						+ "',  '"
						+ "Not have"
						+ "', '"
						+ reasonMid
						+ "', '"
						+ reasonFinal
						+ "', '"
						+ year
						+ "', '"
						+ semester + "')";
				stmt.executeUpdate(QueryString);
			} else if (chkBoxWrittingMid == null
					&& chkBoxMultiMid == null && noMid != null
					&& reasonFinal != null) {
				String QueryString = "INSERT INTO examsurvey (courseCode,  midtermType, finalType, reasonMid,reasonFinal,year,semester) VALUES ('"
						+ cosCode
						+ "',  '"
						+ noMid
						+ "',  '"
						+ "Not have"
						+ "', '"
						+ reasonMid
						+ "', '"
						+ reasonFinal
						+ "', '"
						+ year
						+ "', '"
						+ semester + "')";
				stmt.executeUpdate(QueryString);
			} else if (chkBoxWrittingFinal != null
					&& chkBoxMultiFinal == null && offFinal == null
					&& reasonMid != null) {
				String QueryString = "INSERT INTO examsurvey (courseCode,  midtermType, finalType, reasonMid,reasonFinal,year,semester) VALUES ('"
						+ cosCode
						+ "',  '"
						+ "Not have"
						+ "',  '"
						+ chkBoxWrittingFinal
						+ "', '"
						+ reasonMid
						+ "', '"
						+ reasonFinal
						+ "', '"
						+ year
						+ "', '"
						+ semester + "')";
				stmt.executeUpdate(QueryString);
			} else if (chkBoxWrittingFinal != null
					&& chkBoxMultiFinal == null && noFinal == null
					&& reasonMid != null) {
				String QueryString = "INSERT INTO examsurvey (courseCode,  midtermType, finalType, reasonMid,reasonFinal,year,semester) VALUES ('"
						+ cosCode
						+ "',  '"
						+ "Not have"
						+ "',  '"
						+ chkBoxWrittingFinal
						+ "', '"
						+ reasonMid
						+ "', '"
						+ reasonFinal
						+ "', '"
						+ year
						+ "', '"
						+ semester + "')";
				stmt.executeUpdate(QueryString);
			} else if (chkBoxWrittingFinal == null
					&& chkBoxMultiFinal != null && offFinal == null
					&& reasonMid != null) {
				String QueryString = "INSERT INTO examsurvey (courseCode,  midtermType, finalType, reasonMid,reasonFinal,year,semester) VALUES ('"
						+ cosCode
						+ "',  '"
						+ "Not have"
						+ "',  '"
						+ chkBoxMultiFinal
						+ "', '"
						+ reasonMid
						+ "', '"
						+ reasonFinal
						+ "', '"
						+ year
						+ "', '"
						+ semester + "')";
				stmt.executeUpdate(QueryString);
			} else if (chkBoxWrittingFinal == null
					&& chkBoxMultiFinal != null && noFinal == null
					&& reasonMid != null) {
				String QueryString = "INSERT INTO examsurvey (courseCode,  midtermType, finalType, reasonMid,reasonFinal,year,semester) VALUES ('"
						+ cosCode
						+ "',  '"
						+ "Not have"
						+ "',  '"
						+ chkBoxMultiFinal
						+ "', '"
						+ reasonMid
						+ "', '"
						+ reasonFinal
						+ "', '"
						+ year
						+ "', '"
						+ semester + "')";
				stmt.executeUpdate(QueryString);
			} else if (chkBoxWrittingFinal == null
					&& chkBoxMultiFinal == null && offFinal != null
					&& reasonMid != null) {
				String QueryString = "INSERT INTO examsurvey (courseCode, midtermType, finalType, reasonMid,reasonFinal,year,semester) VALUES ('"
						+ cosCode
						+ "',  '"
						+ "Not have"
						+ "',  '"
						+ offFinal
						+ "', '"
						+ reasonMid
						+ "', '"
						+ reasonFinal
						+ "', '"
						+ year
						+ "', '"
						+ semester + "')";
				stmt.executeUpdate(QueryString);
			} else if (chkBoxWrittingFinal == null
					&& chkBoxMultiFinal == null && noFinal != null
					&& reasonMid != null) {
				String QueryString = "INSERT INTO examsurvey (courseCode, midtermType, finalType, reasonMid,reasonFinal,year,semester) VALUES ('"
						+ cosCode
						+ "',  '"
						+ "Not have"
						+ "',  '"
						+ noFinal
						+ "', '"
						+ reasonMid
						+ "', '"
						+ reasonFinal
						+ "', '"
						+ year
						+ "', '"
						+ semester + "')";
				stmt.executeUpdate(QueryString);
			}
		}
		stmt.close();
		con.close();
	} catch (Exception e) {
		out.println(e);
	}

	//out.print("<META HTTP-EQUIV=\"Refresh\" CONTENT=\"0;URL=Teacher_Exam.jsp\">");
%>