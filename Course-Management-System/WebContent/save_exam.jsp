<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.sql.*"%>
<%
	request.setCharacterEncoding("UTF-8");

	try {
		Statement stmt;
		Connection con;
		String url = "jdbc:mysql://localhost:3306/cms";

		Class.forName("com.mysql.jdbc.Driver");
		con = DriverManager.getConnection(url, "root", "root");
		stmt = con.createStatement();
		String courseID = request.getParameter("coursesurveyID");

		String cosName = null;
		Object strUserID = session.getAttribute("sUserID");
		
		String year = request.getParameter("year");
		String semester = request.getParameter("semester");
		
		String cosCode = request.getParameter("courseCode");
		String sFirstname = String.valueOf(session.getAttribute("sFirstname"));
		String sLastname = String.valueOf(session.getAttribute("sLastname"));

		String chkBoxWrittingMid = request.getParameter("chkBoxWrittingMid");
		String chkBoxMultiMid = request.getParameter("chkBoxMultiMid");
		String chkBoxOffMid = request.getParameter("chkBoxOffMid");

		String chkBoxWrittingFinal = request.getParameter("chkBoxWrittingFinal");
		String chkBoxMultiFinal = request.getParameter("chkBoxMultiFinal");
		String chkBoxOffFinal = request.getParameter("chkBoxOffFinal");

		String reasonMid = request.getParameter("reasonMid");
		String reasonFinal = request.getParameter("reasonFinal");
		
		
		out.print(year);
		out.print(semester);
		out.print("Save complete");
		

		String cosCodeHave = null;
		String examSurveyID = "";
		String queryString = "SELECT * FROM cms.examsurvey WHERE courseCode ='"
				+ cosCode + "' AND userID = '" + strUserID + "' ";
		ResultSet rsCheckUpdate = stmt.executeQuery(queryString);
		while (rsCheckUpdate.next()) {

			examSurveyID = rsCheckUpdate.getString("examSurveyID");
			cosCodeHave = rsCheckUpdate.getString("courseCode");

		
		}

		// Update or edit exammination
		if (cosCode.equals(cosCodeHave)) {
			stmt = con.createStatement();

			
			// If user save midterm and final  to writting and multiple choice.
			
			if (chkBoxWrittingMid != null && chkBoxMultiMid != null
					&& chkBoxWrittingFinal != null && chkBoxMultiMid !=null) {
				int i = stmt
						.executeUpdate("UPDATE examsurvey SET courseCode ='"
								+ cosCodeHave
								+ "',userID = '"
								+ strUserID
								+ "',midtermType = 'MD',finalType = 'MD',reasonMid ='"
								+ reasonMid
								+ "',reasonFinal = '"
								+ reasonFinal
								+ "' where examSurveyID ='"
								+ examSurveyID + "' ");

			}
			// If user save midterm  to writting and multiple choice.
			else if (chkBoxWrittingMid != null && chkBoxMultiMid != null
					&& chkBoxWrittingFinal != null) {
				int i = stmt
						.executeUpdate("UPDATE examsurvey SET courseCode ='"
								+ cosCodeHave
								+ "',userID = '"
								+ strUserID
								+ "',midtermType = 'MD',finalType = '"
								+ chkBoxWrittingFinal
								+ "',reasonMid ='"
								+ reasonMid
								+ "',reasonFinal = '"
								+ reasonFinal
								+ "' where examSurveyID ='"
								+ examSurveyID + "' ");

			} else if (chkBoxWrittingMid != null
					&& chkBoxMultiMid != null
					&& chkBoxMultiFinal != null) {
				int i = stmt
						.executeUpdate("UPDATE examsurvey SET courseCode ='"
								+ cosCodeHave
								+ "',userID = '"
								+ strUserID
								+ "',midtermType = 'MD',finalType = '"
								+ chkBoxMultiFinal
								+ "',reasonMid ='"
								+ reasonMid
								+ "',reasonFinal = '"
								+ reasonFinal
								+ "' where examSurveyID ='"
								+ examSurveyID + "' ");

			} else if (chkBoxWrittingMid != null
					&& chkBoxMultiMid != null && chkBoxOffFinal != null) {
				int i = stmt
						.executeUpdate("UPDATE examsurvey SET courseCode ='"
								+ cosCodeHave
								+ "',userID = '"
								+ strUserID
								+ "',midtermType = 'MD',finalType = '"
								+ chkBoxOffFinal
								+ "',reasonMid ='"
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
								+ "',userID = '"
								+ strUserID
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
								+ "',userID = '"
								+ strUserID
								+ "',midtermType = '"
								+ chkBoxWrittingMid
								+ "',finalType = 'MD',reasonMid ='"
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
								+ "',userID = '"
								+ strUserID
								+ "',midtermType = '"
								+ chkBoxMultiMid
								+ "',finalType = 'MD',reasonMid ='"
								+ reasonMid
								+ "',reasonFinal = '"
								+ reasonFinal
								+ "' where examSurveyID ='"
								+ examSurveyID + "' ");

			} else if (chkBoxMultiFinal != null
					&& chkBoxWrittingFinal != null
					&& chkBoxOffMid != null) {
				int i = stmt
						.executeUpdate("UPDATE examsurvey SET courseCode ='"
								+ cosCodeHave
								+ "',userID = '"
								+ strUserID
								+ "',midtermType = '"
								+ chkBoxOffMid
								+ "',finalType = 'MD',reasonMid ='"
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
								+ "',userID = '"
								+ strUserID
								+ "',midtermType = 'Not have',finalType = 'MD' ,reasonMid ='"
								+ reasonMid
								+ "',reasonFinal = '"
								+ reasonFinal
								+ "'where examSurveyID ='"
								+ examSurveyID + "' ");

			} else if (chkBoxWrittingMid != null
					&& chkBoxWrittingFinal != null) {
				int i = stmt
						.executeUpdate("UPDATE examsurvey SET courseCode ='"
								+ cosCodeHave
								+ "',userID = '"
								+ strUserID
								+ "',midtermType = '"
								+ chkBoxWrittingMid
								+ "',finalType = '"
								+ chkBoxWrittingFinal
								+ "',reasonMid ='"
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
								+ "',userID = '"
								+ strUserID
								+ "',midtermType = '"
								+ chkBoxWrittingMid
								+ "',finalType = '"
								+ chkBoxMultiFinal
								+ "',reasonMid ='"
								+ reasonMid
								+ "',reasonFinal = '"
								+ reasonFinal
								+ "' where examSurveyID ='"
								+ examSurveyID + "' ");

			} else if (chkBoxWrittingMid != null
					&& chkBoxOffFinal != null) {
				int i = stmt
						.executeUpdate("UPDATE examsurvey SET courseCode ='"
								+ cosCodeHave
								+ "',userID = '"
								+ strUserID
								+ "',midtermType = '"
								+ chkBoxWrittingMid
								+ "',finalType = '"
								+ chkBoxOffFinal
								+ "',reasonMid ='"
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
								+ "',userID = '"
								+ strUserID
								+ "',midtermType = '"
								+ chkBoxMultiMid
								+ "',finalType = '"
								+ chkBoxWrittingFinal
								+ "',reasonMid ='"
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
								+ "',userID = '"
								+ strUserID
								+ "',midtermType = '"
								+ chkBoxMultiMid
								+ "',finalType = '"
								+ chkBoxMultiMid
								+ "',reasonMid ='"
								+ reasonMid
								+ "',reasonFinal = '"
								+ reasonFinal
								+ "' where examSurveyID ='"
								+ examSurveyID + "' ");

			} else if (chkBoxMultiMid != null && chkBoxOffFinal != null) {
				int i = stmt
						.executeUpdate("UPDATE examsurvey SET courseCode ='"
								+ cosCodeHave
								+ "',userID = '"
								+ strUserID
								+ "',midtermType = '"
								+ chkBoxMultiMid
								+ "',finalType = '"
								+ chkBoxOffFinal
								+ "',reasonMid ='"
								+ reasonMid
								+ "',reasonFinal = '"
								+ reasonFinal
								+ "' where examSurveyID ='"
								+ examSurveyID + "' ");

			} else if (chkBoxOffMid != null
					&& chkBoxWrittingFinal != null) {
				int i = stmt
						.executeUpdate("UPDATE examsurvey SET courseCode ='"
								+ cosCodeHave
								+ "',userID = '"
								+ strUserID
								+ "',midtermType = '"
								+ chkBoxOffMid
								+ "',finalType = '"
								+ chkBoxWrittingMid
								+ "',reasonMid ='"
								+ reasonMid
								+ "',reasonFinal = '"
								+ reasonFinal
								+ "' where examSurveyID ='"
								+ examSurveyID + "' ");

			} else if (chkBoxOffMid != null && chkBoxMultiFinal != null) {
				int i = stmt
						.executeUpdate("UPDATE examsurvey SET courseCode ='"
								+ cosCodeHave
								+ "',userID = '"
								+ strUserID
								+ "',midtermType = '"
								+ chkBoxOffMid
								+ "',finalType = '"
								+ chkBoxMultiMid
								+ "',reasonMid ='"
								+ reasonMid
								+ "',reasonFinal = '"
								+ reasonFinal
								+ "' where examSurveyID ='"
								+ examSurveyID + "' ");

			} else if (chkBoxOffMid != null && chkBoxOffFinal != null) {
				int i = stmt
						.executeUpdate("UPDATE examsurvey SET courseCode ='"
								+ cosCodeHave
								+ "',userID = '"
								+ strUserID
								+ "',midtermType = '"
								+ chkBoxOffMid
								+ "',finalType = '"
								+ chkBoxOffFinal
								+ "',reasonMid ='"
								+ reasonMid
								+ "',reasonFinal = '"
								+ reasonFinal
								+ "' where examSurveyID ='"
								+ examSurveyID + "' ");

			} else if (chkBoxWrittingMid == null
					&& chkBoxMultiMid == null 
					&& chkBoxOffMid == null
					&& chkBoxWrittingFinal == null
					&& chkBoxMultiFinal == null
					&& chkBoxOffFinal == null) {
				int i = stmt
						.executeUpdate("UPDATE examsurvey SET courseCode ='"
								+ cosCodeHave
								+ "',userID = '"
								+ strUserID
								+ "',midtermType = 'Not have',finalType = 'Not have',reasonMid ='"
								+ reasonMid
								+ "',reasonFinal = '"
								+ reasonFinal
								+ "' where examSurveyID ='"
								+ examSurveyID + "' ");
			} else if (chkBoxWrittingMid != null
					&& chkBoxMultiMid == null && chkBoxOffMid == null
					&& reasonFinal != null) {
				int i = stmt
						.executeUpdate("UPDATE examsurvey SET courseCode ='"
								+ cosCodeHave
								+ "',userID = '"
								+ strUserID
								+ "',midtermType = '"
								+ chkBoxWrittingMid
								+ "',finalType = 'Not have',reasonMid ='"
								+ reasonMid
								+ "',reasonFinal = '"
								+ reasonFinal
								+ "' where examSurveyID ='"
								+ examSurveyID + "' ");

			} else if (chkBoxWrittingMid == null
					&& chkBoxMultiMid != null && chkBoxOffMid == null
					&& reasonFinal != null) {
				int i = stmt
						.executeUpdate("UPDATE examsurvey SET courseCode ='"
								+ cosCodeHave
								+ "',userID = '"
								+ strUserID
								+ "',midtermType = '"
								+ chkBoxMultiMid
								+ "',finalType = 'Not have',reasonMid ='"
								+ reasonMid
								+ "',reasonFinal = '"
								+ reasonFinal
								+ "' where examSurveyID ='"
								+ examSurveyID + "' ");

			} else if (chkBoxWrittingMid == null
					&& chkBoxMultiMid == null && chkBoxOffMid != null
					&& reasonFinal != null) {
				int i = stmt
						.executeUpdate("UPDATE examsurvey SET courseCode ='"
								+ cosCodeHave
								+ "',userID = '"
								+ strUserID
								+ "',midtermType = '"
								+ chkBoxOffMid
								+ "',finalType = 'Not have',reasonMid ='"
								+ reasonMid
								+ "',reasonFinal = '"
								+ reasonFinal
								+ "' where examSurveyID ='"
								+ examSurveyID + "' ");
			} else if (chkBoxWrittingFinal != null
					&& chkBoxMultiFinal == null
					&& chkBoxOffFinal == null && reasonMid != null) {
				int i = stmt
						.executeUpdate("UPDATE examsurvey SET courseCode ='"
								+ cosCodeHave
								+ "',userID = '"
								+ strUserID
								+ "',midtermType = 'Not have',finalType = '"
								+ chkBoxWrittingFinal
								+ "',reasonMid ='"
								+ reasonMid
								+ "',reasonFinal = '"
								+ reasonFinal
								+ "' where examSurveyID ='"
								+ examSurveyID + "' ");

			} else if (chkBoxWrittingFinal == null
					&& chkBoxMultiFinal != null
					&& chkBoxOffFinal == null && reasonMid != null) {
				int i = stmt
						.executeUpdate("UPDATE examsurvey SET courseCode ='"
								+ cosCodeHave
								+ "',userID = '"
								+ strUserID
								+ "',midtermType = 'Not have',finalType = '"
								+ chkBoxMultiFinal
								+ "',reasonMid ='"
								+ reasonMid
								+ "',reasonFinal = '"
								+ reasonFinal
								+ "' where examSurveyID ='"
								+ examSurveyID + "' ");

			} else if (chkBoxWrittingFinal == null
					&& chkBoxMultiFinal == null
					&& chkBoxOffFinal != null && reasonMid != null) {
				int i = stmt
						.executeUpdate("UPDATE examsurvey SET courseCode ='"
								+ cosCodeHave
								+ "',userID = '"
								+ strUserID
								+ "',midtermType = 'Not have',finalType = '"
								+ chkBoxOffFinal
								+ "',reasonMid ='"
								+ reasonMid
								+ "',reasonFinal = '"
								+ reasonFinal
								+ "' where examSurveyID ='"
								+ examSurveyID + "' ");


			}

			// Add examination to database
		} else {

			if (chkBoxWrittingMid != null && chkBoxMultiMid != null
					&& chkBoxWrittingFinal != null) {
				String QueryString = "INSERT INTO examsurvey (courseCode, userID, midtermType, finalType, reasonMid,reasonFinal,year,semester) VALUES ('"
						+ cosCode
						+ "', '"
						+ strUserID
						+ "', '"
						+ "MD"
						+ "',  '"
						+ chkBoxWrittingFinal
						+ "', '"
						+ reasonMid + "', '" + reasonFinal + "', '" + year + "', '" + semester + "')";
				stmt.executeUpdate(QueryString);

			} else if (chkBoxWrittingMid != null
					&& chkBoxMultiMid != null
					&& chkBoxMultiFinal != null) {
				String QueryString = "INSERT INTO examsurvey (courseCode, userID, midtermType, finalType, reasonMid,reasonFinal,year,semester) VALUES ('"
						+ cosCode
						+ "', '"
						+ strUserID
						+ "', '"
						+ "MD"
						+ "',  '"
						+ chkBoxMultiFinal
						+ "', '"
						+ reasonMid + "', '" + reasonFinal + "', '" + year + "', '" + semester + "')";
				stmt.executeUpdate(QueryString);

			} else if (chkBoxWrittingMid != null
					&& chkBoxMultiMid != null && chkBoxOffFinal != null) {
				String QueryString = "INSERT INTO examsurvey (courseCode, userID, midtermType, finalType, reasonMid,reasonFinal,year,semester) VALUES ('"
						+ cosCode
						+ "', '"
						+ strUserID
						+ "', '"
						+ "MD"
						+ "',  '"
						+ chkBoxOffFinal
						+ "', '"
						+ reasonMid
						+ "', '" + reasonFinal + "', '" + year + "', '" + semester + "')";
				stmt.executeUpdate(QueryString);

			} else if (chkBoxWrittingMid != null
					&& chkBoxMultiMid != null && reasonFinal != null) {
				String QueryString = "INSERT INTO examsurvey (courseCode, userID, midtermType, finalType, reasonMid,reasonFinal,year,semester) VALUES ('"
						+ cosCode
						+ "', '"
						+ strUserID
						+ "', '"
						+ "MD"
						+ "',  '"
						+ "Not have"
						+ "', '"
						+ reasonMid
						+ "', '" + reasonFinal + "', '" + year + "', '" + semester + "')";
				stmt.executeUpdate(QueryString);
			} else if (chkBoxWrittingFinal != null
					&& chkBoxMultiFinal != null
					&& chkBoxWrittingMid != null) {
				String QueryString = "INSERT INTO examsurvey (courseCode, userID, midtermType, finalType, reasonMid,reasonFinal,year,semester) VALUES ('"
						+ cosCode
						+ "', '"
						+ strUserID
						+ "', '"
						+ chkBoxWrittingMid
						+ "',  '"
						+ "MD"
						+ "', '"
						+ reasonMid + "', '" + reasonFinal + "', '" + year + "', '" + semester + "')";
				stmt.executeUpdate(QueryString);

			} else if (chkBoxWrittingFinal != null
					&& chkBoxMultiFinal != null
					&& chkBoxMultiMid != null) {
				String QueryString = "INSERT INTO examsurvey (courseCode, userID, midtermType, finalType, reasonMid,reasonFinal,year,semester) VALUES ('"
						+ cosCode
						+ "', '"
						+ strUserID
						+ "', '"
						+ chkBoxMultiMid
						+ "',  '"
						+ "MD"
						+ "', '"
						+ reasonMid + "', '" + reasonFinal + "', '" + year + "', '" + semester + "')";
				stmt.executeUpdate(QueryString);

			} else if (chkBoxMultiFinal != null
					&& chkBoxWrittingFinal != null
					&& chkBoxOffMid != null) {
				String QueryString = "INSERT INTO examsurvey (courseCode, userID, midtermType, finalType, reasonMid,reasonFinal,year,semester) VALUES ('"
						+ cosCode
						+ "', '"
						+ strUserID
						+ "', '"
						+ chkBoxOffMid
						+ "',  '"
						+ "MD"
						+ "', '"
						+ reasonMid + "', '" + reasonFinal + "', '" + year + "', '" + semester + "')";
				stmt.executeUpdate(QueryString);
			} else if (chkBoxMultiFinal != null
					&& chkBoxWrittingFinal != null && reasonMid != null) {
				String QueryString = "INSERT INTO examsurvey (courseCode, userID, midtermType, finalType, reasonMid,reasonFinal,year,semester) VALUES ('"
						+ cosCode
						+ "', '"
						+ strUserID
						+ "', '"
						+ "Not have"
						+ "',  '"
						+ "MD"
						+ "', '"
						+ reasonMid + "', '" + reasonFinal + "', '" + year + "', '" + semester + "')";
				stmt.executeUpdate(QueryString);
			} else if (chkBoxWrittingMid != null
					&& chkBoxWrittingFinal != null) {
				String QueryString = "INSERT INTO examsurvey (courseCode, userID, midtermType, finalType, reasonMid,reasonFinal,year,semester) VALUES ('"
						+ cosCode
						+ "', '"
						+ strUserID
						+ "', '"
						+ chkBoxWrittingMid
						+ "',  '"
						+ chkBoxWrittingFinal
						+ "', '"
						+ reasonMid
						+ "', '" + reasonFinal + "', '" + year + "', '" + semester + "')";
				stmt.executeUpdate(QueryString);

			} else if (chkBoxWrittingMid != null
					&& chkBoxMultiFinal != null) {
				String QueryString = "INSERT INTO examsurvey (courseCode, userID, midtermType, finalType, reasonMid,reasonFinal,year,semester) VALUES ('"
						+ cosCode
						+ "', '"
						+ strUserID
						+ "', '"
						+ chkBoxWrittingMid
						+ "',  '"
						+ chkBoxMultiFinal
						+ "', '"
						+ reasonMid
						+ "','"
						+ reasonFinal + "', '" + year + "', '" + semester + "')";
				stmt.executeUpdate(QueryString);
			} else if (chkBoxWrittingMid != null
					&& chkBoxOffFinal != null) {
				String QueryString = "INSERT INTO examsurvey (courseCode, userID, midtermType, finalType, reasonMid,reasonFinal,year,semester) VALUES ('"
						+ cosCode
						+ "', '"
						+ strUserID
						+ "', '"
						+ chkBoxWrittingMid
						+ "',  '"
						+ chkBoxOffFinal
						+ "', '"
						+ reasonMid
						+ "', '"
						+ reasonFinal
						+ "', '" + year + "', '" + semester + "')";
				stmt.executeUpdate(QueryString);
			} else if (chkBoxMultiMid != null
					&& chkBoxWrittingFinal != null) {
				String QueryString = "INSERT INTO examsurvey (courseCode, userID, midtermType, finalType, reasonMid,reasonFinal,year,semester) VALUES ('"
						+ cosCode
						+ "', '"
						+ strUserID
						+ "', '"
						+ chkBoxMultiMid
						+ "',  '"
						+ chkBoxWrittingFinal
						+ "', '"
						+ reasonMid
						+ "', '" + reasonFinal + "', '" + year + "', '" + semester + "')";
				stmt.executeUpdate(QueryString);

			} else if (chkBoxMultiMid != null
					&& chkBoxMultiFinal != null) {
				String QueryString = "INSERT INTO examsurvey (courseCode, userID, midtermType, finalType, reasonMid,reasonFinal,year,semester) VALUES ('"
						+ cosCode
						+ "', '"
						+ strUserID
						+ "', '"
						+ chkBoxMultiMid
						+ "',  '"
						+ chkBoxMultiFinal
						+ "', '"
						+ reasonMid
						+ "', '"
						+ reasonFinal
						+ "', '" + year + "', '" + semester + "')";
				stmt.executeUpdate(QueryString);

			} else if (chkBoxMultiMid != null && chkBoxOffFinal != null) {
				String QueryString = "INSERT INTO examsurvey (courseCode, userID, midtermType, finalType, reasonMid,reasonFinal,year,semester) VALUES ('"
						+ cosCode
						+ "', '"
						+ strUserID
						+ "', '"
						+ chkBoxMultiMid
						+ "',  '"
						+ chkBoxOffFinal
						+ "', '"
						+ reasonMid
						+ "', '"
						+ reasonFinal
						+ "', '" + year + "', '" + semester + "')";
				stmt.executeUpdate(QueryString);

			} else if (chkBoxOffMid != null
					&& chkBoxWrittingFinal != null) {
				String QueryString = "INSERT INTO examsurvey (courseCode, userID, midtermType, finalType, reasonMid,reasonFinal,year,semester) VALUES ('"
						+ cosCode
						+ "', '"
						+ strUserID
						+ "', '"
						+ chkBoxOffMid
						+ "',  '"
						+ chkBoxWrittingFinal
						+ "', '"
						+ reasonMid
						+ "', '"
						+ reasonFinal
						+ "', '" + year + "', '" + semester + "')";
				stmt.executeUpdate(QueryString);

			} else if (chkBoxOffMid != null && chkBoxMultiFinal != null) {
				String QueryString = "INSERT INTO examsurvey (courseCode, userID, midtermType, finalType, reasonMid,reasonFinal,year,semester) VALUES ('"
						+ cosCode
						+ "', '"
						+ strUserID
						+ "', '"
						+ chkBoxOffMid
						+ "',  '"
						+ chkBoxMultiFinal
						+ "', '"
						+ reasonMid
						+ "', '"
						+ reasonFinal
						+ "', '" + year + "', '" + semester + "')";
				stmt.executeUpdate(QueryString);

			} else if (chkBoxOffMid != null && chkBoxOffFinal != null) {
				String QueryString = "INSERT INTO examsurvey (courseCode, userID, midtermType, finalType, reasonMid,reasonFinal,year,semester) VALUES ('"
						+ cosCode
						+ "', '"
						+ strUserID
						+ "', '"
						+ chkBoxOffMid
						+ "',  '"
						+ chkBoxOffFinal
						+ "', '"
						+ reasonMid
						+ "', '"
						+ reasonFinal
						+ "', '" + year + "', '" + semester + "')";
				stmt.executeUpdate(QueryString);

			} else if (chkBoxWrittingMid == null
					&& chkBoxMultiMid == null && chkBoxOffMid == null
					&& chkBoxWrittingFinal == null
					&& chkBoxMultiFinal == null
					&& chkBoxOffFinal == null) {
				String QueryString = "INSERT INTO examsurvey (courseCode, userID, midtermType, finalType, reasonMid,reasonFinal,year,semester) VALUES ('"
						+ cosCode
						+ "', '"
						+ strUserID
						+ "', '"
						+ "Not have"
						+ "',  '"
						+ "Not have"
						+ "', '"
						+ reasonMid + "', '" + reasonFinal + "', '" + year + "', '" + semester + "')";
				stmt.executeUpdate(QueryString);
			} else if (chkBoxWrittingMid != null
					&& chkBoxMultiMid == null && chkBoxOffMid == null
					&& reasonFinal != null) {
				String QueryString = "INSERT INTO examsurvey (courseCode, userID, midtermType, finalType, reasonMid,reasonFinal,year,semester) VALUES ('"
						+ cosCode
						+ "', '"
						+ strUserID
						+ "', '"
						+ chkBoxWrittingMid
						+ "',  '"
						+ "Not have"
						+ "', '"
						+ reasonMid
						+ "', '"
						+ reasonFinal
						+ "', '" + year + "', '" + semester + "')";
				stmt.executeUpdate(QueryString);
			} else if (chkBoxWrittingMid == null
					&& chkBoxMultiMid != null && chkBoxOffMid == null
					&& reasonFinal != null) {
				String QueryString = "INSERT INTO examsurvey (courseCode, userID, midtermType, finalType, reasonMid,reasonFinal,year,semester) VALUES ('"
						+ cosCode
						+ "', '"
						+ strUserID
						+ "', '"
						+ chkBoxMultiMid
						+ "',  '"
						+ "Not have"
						+ "', '"
						+ reasonMid
						+ "', '"
						+ reasonFinal
						+ "', '" + year + "', '" + semester + "')";
				stmt.executeUpdate(QueryString);
			} else if (chkBoxWrittingMid == null
					&& chkBoxMultiMid == null && chkBoxOffMid != null
					&& reasonFinal != null) {
				String QueryString = "INSERT INTO examsurvey (courseCode, userID, midtermType, finalType, reasonMid,reasonFinal,year,semester) VALUES ('"
						+ cosCode
						+ "', '"
						+ strUserID
						+ "', '"
						+ chkBoxOffMid
						+ "',  '"
						+ "Not have"
						+ "', '"
						+ reasonMid + "', '" + reasonFinal + "', '" + year + "', '" + semester + "')";
				stmt.executeUpdate(QueryString);
			} else if (chkBoxWrittingFinal != null
					&& chkBoxMultiFinal == null
					&& chkBoxOffFinal == null && reasonMid != null) {
				String QueryString = "INSERT INTO examsurvey (courseCode, userID, midtermType, finalType, reasonMid,reasonFinal,year,semester) VALUES ('"
						+ cosCode
						+ "', '"
						+ strUserID
						+ "', '"
						+ "Not have"
						+ "',  '"
						+ chkBoxWrittingFinal
						+ "', '"
						+ reasonMid
						+ "', '"
						+ reasonFinal
						+ "', '" + year + "', '" + semester + "')";
				stmt.executeUpdate(QueryString);
			} else if (chkBoxWrittingFinal == null
					&& chkBoxMultiFinal != null
					&& chkBoxOffFinal == null && reasonMid != null) {
				String QueryString = "INSERT INTO examsurvey (courseCode, userID, midtermType, finalType, reasonMid,reasonFinal,year,semester) VALUES ('"
						+ cosCode
						+ "', '"
						+ strUserID
						+ "', '"
						+ "Not have"
						+ "',  '"
						+ chkBoxMultiFinal
						+ "', '"
						+ reasonMid
						+ "', '"
						+ reasonFinal
						+ "', '" + year + "', '" + semester + "')";
				stmt.executeUpdate(QueryString);
			} else if (chkBoxWrittingFinal == null
					&& chkBoxMultiFinal == null
					&& chkBoxOffFinal != null && reasonMid != null) {
				String QueryString = "INSERT INTO examsurvey (courseCode, userID, midtermType, finalType, reasonMid,reasonFinal,year,semester) VALUES ('"
						+ cosCode
						+ "', '"
						+ strUserID
						+ "', '"
						+ "Not have"
						+ "',  '"
						+ chkBoxOffFinal
						+ "', '"
						+ reasonMid
						+ "', '"
						+ reasonFinal
						+ "', '" + year + "', '" + semester + "')";
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