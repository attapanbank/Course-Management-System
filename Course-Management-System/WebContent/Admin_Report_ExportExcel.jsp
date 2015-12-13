<%@ page language="java" contentType="text/html; charset=utf-8"
	import="java.sql.*" pageEncoding="utf-8"%>

<%@page import="java.io.*"%>
<%@page import="java.util.Properties"%>
<%@page import="org.apache.poi.hssf.usermodel.*"%>
<%@page import="org.apache.poi.hssf.util.HSSFColor"%>
<%@page import="org.apache.poi.ss.usermodel.CellStyle"%>
<%@page import="org.apache.poi.ss.util.CellRangeAddress"%>

<%
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

<%
	String year = request.getParameter("year");
	String term = request.getParameter("term");
	String reporttype = request.getParameter("reporttype");
	System.out.println(reporttype);

	if (reporttype.equals("surveysortbyteacher")) {
		System.out.println(1);
		/* String filename = "C:/Users/MahaloBankupu/Desktop/candidate "
				+ year + " " + term + ".xls"; */

		try {
			Class.forName(readdriver);
			con = DriverManager.getConnection(url, readuser, readpass);

			HSSFWorkbook wb = new HSSFWorkbook();
			HSSFSheet sheet = wb.createSheet("new sheet");

			// Set Style
			CellStyle style = wb.createCellStyle();
			style.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
			style.setAlignment(HSSFCellStyle.ALIGN_CENTER);

			CellStyle stylecoursename = wb.createCellStyle();
			stylecoursename
					.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
			stylecoursename.setAlignment(HSSFCellStyle.ALIGN_LEFT);

			// Set ColumnWidth
			sheet.setColumnWidth(1, 8000);
			sheet.setColumnWidth(2, 3000);
			sheet.setColumnWidth(3, 15000);
			sheet.setColumnWidth(4, 3000);

			// Create Row
			HSSFRow row0 = sheet.createRow(0);

			row0.setHeightInPoints((2 * sheet
					.getDefaultRowHeightInPoints()));

			// Create cell
			HSSFCell cell0_0 = row0.createCell(0);
			HSSFCell cell0_1 = row0.createCell(1);
			HSSFCell cell0_2 = row0.createCell(2);
			HSSFCell cell0_3 = row0.createCell(3);
			HSSFCell cell0_4 = row0.createCell(4);

			// Add Header Text
			cell0_0.setCellValue("ลำดับ");
			cell0_1.setCellValue("Candidates");
			cell0_2.setCellValue("รหัส\nรายวิชา");
			cell0_3.setCellValue("ชื่อรายวิชา");
			cell0_4.setCellValue("หน่วยกิต");

			// Add Vertical Align
			cell0_0.setCellStyle(style);
			cell0_1.setCellStyle(style);
			cell0_2.setCellStyle(style);
			cell0_3.setCellStyle(stylecoursename);
			cell0_4.setCellStyle(style);

			// End Header

			// Get Data
			stmt = con.createStatement();
			String Querycandidate = "SELECT * FROM course_survey INNER JOIN user ON course_survey.userID = user.userID WHERE course_survey.year = '"
					+ year
					+ "' AND course_survey.semester = '"
					+ term
					+ "' GROUP BY course_survey.userID ORDER BY course_survey.courseCode";
			ResultSet rscandidate = stmt.executeQuery(Querycandidate);
			int countrow = 1;
			int count = 0;
			while (rscandidate.next()) {
				count++;
				HSSFRow rowdata = sheet.createRow(countrow);
				HSSFCell cell0 = rowdata.createCell(0);
				HSSFCell cell1 = rowdata.createCell(1);

				cell0.setCellValue(count);
				cell1.setCellValue(rscandidate
						.getString("user.firstname")
						+ " "
						+ rscandidate.getString("user.lastname"));

				cell0.setCellStyle(style);
				cell1.setCellStyle(stylecoursename);

				// Get Length
				stmt = con.createStatement();
				String Querylength = "SELECT * FROM course_survey INNER JOIN user ON course_survey.userID = user.userID INNER JOIN course ON course_survey.courseCode = course.courseCode WHERE course_survey.year = '"
						+ year
						+ "' AND course_survey.semester = '"
						+ term
						+ "' AND course_survey.userID = '"
						+ rscandidate.getString("course_survey.userID")
						+ "' ORDER BY course_survey.courseCode";
				ResultSet rslength = stmt.executeQuery(Querylength);
				rslength.last();
				int numcourse = rslength.getRow();

				// Merge Cell
				sheet.addMergedRegion(new CellRangeAddress(countrow,
						(numcourse + countrow) - 1, 0, 0));
				sheet.addMergedRegion(new CellRangeAddress(countrow,
						(numcourse + countrow) - 1, 1, 1));

				// Get Course Detail
				int countcourse = countrow;
				stmt = con.createStatement();
				ResultSet rscourse = stmt.executeQuery(Querylength);
				while (rscourse.next()) {
					HSSFCell cell2 = rowdata.createCell(2);
					HSSFCell cell3 = rowdata.createCell(3);
					HSSFCell cell4 = rowdata.createCell(4);

					cell2.setCellValue(rscourse
							.getString("course_survey.courseCode"));
					cell3.setCellValue(rscourse
							.getString("course.courseName"));
					cell4.setCellValue(rscourse
							.getString("course.credit"));

					cell2.setCellStyle(style);
					cell4.setCellStyle(style);

					countcourse++;

					rowdata = sheet.createRow(countcourse);
				}

				countrow = (numcourse + countrow) - 1;
				countrow++;
			}

			/* // Write the output to a file
			FileOutputStream fileOut = new FileOutputStream(filename);
			wb.write(fileOut);
			fileOut.close(); */

			// write it as an excel attachment
			ByteArrayOutputStream outByteStream = new ByteArrayOutputStream();
			wb.write(outByteStream);
			byte[] outArray = outByteStream.toByteArray();
			response.setContentType("application/ms-excel");
			response.setContentLength(outArray.length);
			response.setHeader("Expires:", "0"); // eliminates browser caching
			response.setHeader("Content-Disposition",
					"attachment; filename=candidate " + year + " "
							+ term + ".xls");
			OutputStream outStream = response.getOutputStream();
			outStream.write(outArray);
			outStream.flush();

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (Exception e) {

		}
	} else if (reporttype.equals("surveysortbycourse")) {
		System.out.println(2);
		int intyear = Integer.parseInt(year);
		int intterm = Integer.parseInt(term);

		/* String filename = "C:/Users/MahaloBankupu/Desktop/course "
				+ year + " " + term + ".xls"; */

		try {
			Class.forName(readdriver);
			con = DriverManager.getConnection(url, readuser, readpass);

			HSSFWorkbook wb = new HSSFWorkbook();
			HSSFSheet sheet = wb.createSheet("new sheet");

			// Set Style
			CellStyle style = wb.createCellStyle();
			style.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
			style.setAlignment(HSSFCellStyle.ALIGN_CENTER);

			CellStyle stylecoursename = wb.createCellStyle();
			stylecoursename
					.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
			stylecoursename.setAlignment(HSSFCellStyle.ALIGN_LEFT);

			// Set ColumnWidth
			sheet.setColumnWidth(1, 3000);
			sheet.setColumnWidth(2, 15000);
			sheet.setColumnWidth(3, 3000);
			sheet.setColumnWidth(4, 3000);
			sheet.setColumnWidth(5, 3000);
			sheet.setColumnWidth(6, 8000);
			sheet.setColumnWidth(7, 8000);
			sheet.setColumnWidth(8, 10000);

			// Create Row
			HSSFRow row0 = sheet.createRow(0);

			row0.setHeightInPoints((2 * sheet
					.getDefaultRowHeightInPoints()));

			// Create cell
			HSSFCell cell0_0 = row0.createCell(0);
			HSSFCell cell0_1 = row0.createCell(1);
			HSSFCell cell0_2 = row0.createCell(2);
			HSSFCell cell0_3 = row0.createCell(3);
			HSSFCell cell0_4 = row0.createCell(4);
			HSSFCell cell0_5 = row0.createCell(5);
			HSSFCell cell0_6 = row0.createCell(6);
			HSSFCell cell0_7 = row0.createCell(7);
			HSSFCell cell0_8 = row0.createCell(8);

			// Add Header Text
			cell0_0.setCellValue("ลำดับ");
			cell0_1.setCellValue("รหัส\nรายวิชา");
			cell0_2.setCellValue("ชื่อรายวิชา");
			cell0_3.setCellValue("หน่วยกิต");
			cell0_4.setCellValue("นักศึกษา\nสาขาวิชา");
			cell0_5.setCellValue("จำนวน\nนักศึกษา");
			cell0_6.setCellValue("อาจารย์ผู้สอนเดิม");
			cell0_7.setCellValue("Candidates");
			cell0_8.setCellValue("หมายเหตุ");

			// Add Vertical Align
			cell0_0.setCellStyle(style);
			cell0_1.setCellStyle(style);
			cell0_2.setCellStyle(stylecoursename);
			cell0_3.setCellStyle(style);
			cell0_4.setCellStyle(style);
			cell0_5.setCellStyle(style);
			cell0_6.setCellStyle(style);
			cell0_7.setCellStyle(style);
			cell0_8.setCellStyle(style);

			// End Header

			// Get Old Semester to use in Candidate Last Semester
			if (intterm == 1) {
				intyear = intyear - 1;
				intterm = 2;
				System.out.println(intyear + " " + intterm);
			} else if (intterm == 2) {
				intterm = 1;
				System.out.println(intyear + " " + intterm);
			}

			// Get Data
			stmt = con.createStatement();
			String Querycourse = "SELECT * FROM courseplan INNER JOIN course ON courseplan.courseCode = course.courseCode WHERE courseplan.year = '"
					+ year
					+ "' AND courseplan.semester = '"
					+ term
					+ "' GROUP BY courseplan.courseCode ORDER BY courseplan.courseCode";
			ResultSet rscourse = stmt.executeQuery(Querycourse);
			int countrow = 1;
			int count = 0;
			while (rscourse.next()) {
				count++;
				HSSFRow rowdata = sheet.createRow(countrow);
				HSSFCell cell0 = rowdata.createCell(0);
				HSSFCell cell1 = rowdata.createCell(1);
				HSSFCell cell2 = rowdata.createCell(2);
				HSSFCell cell3 = rowdata.createCell(3);

				cell0.setCellValue(count);
				cell1.setCellValue(rscourse
						.getString("courseplan.courseCode"));
				cell2.setCellValue(rscourse
						.getString("course.courseName"));
				cell3.setCellValue(rscourse.getString("course.credit"));

				cell0.setCellStyle(style);
				cell1.setCellStyle(style);
				cell2.setCellStyle(stylecoursename);
				cell3.setCellStyle(style);

				stmt = con.createStatement();
				String Querylength = "SELECT * FROM courseplan INNER JOIN course ON courseplan.courseCode = course.courseCode WHERE courseplan.year = '"
						+ year
						+ "' AND courseplan.semester = '"
						+ term
						+ "' AND courseplan.courseCode = '"
						+ rscourse.getString("courseplan.courseCode")
						+ "'";
				ResultSet rslength = stmt.executeQuery(Querylength);
				rslength.last();
				int nummajor = rslength.getRow();

				// Merge Cell
				sheet.addMergedRegion(new CellRangeAddress(countrow,
						(nummajor + countrow) - 1, 0, 0));
				sheet.addMergedRegion(new CellRangeAddress(countrow,
						(nummajor + countrow) - 1, 1, 1));
				sheet.addMergedRegion(new CellRangeAddress(countrow,
						(nummajor + countrow) - 1, 2, 2));
				sheet.addMergedRegion(new CellRangeAddress(countrow,
						(nummajor + countrow) - 1, 3, 3));
				sheet.addMergedRegion(new CellRangeAddress(countrow,
						(nummajor + countrow) - 1, 6, 6));
				sheet.addMergedRegion(new CellRangeAddress(countrow,
						(nummajor + countrow) - 1, 7, 7));

				int countmajor = countrow;
				stmt = con.createStatement();
				ResultSet rsmajor = stmt.executeQuery(Querylength);
				while (rsmajor.next()) {
					HSSFCell cell4 = rowdata.createCell(4);
					HSSFCell cell5 = rowdata.createCell(5);
					HSSFCell cell6 = rowdata.createCell(6);
					HSSFCell cell7 = rowdata.createCell(7);

					cell4.setCellValue(rsmajor
							.getString("courseplan.major"));
					cell5.setCellValue(rsmajor
							.getString("courseplan.numberofstudent"));

					cell4.setCellStyle(style);
					cell5.setCellStyle(style);

					countmajor++;

					// Get old selected teacher
					stmt = con.createStatement();
					String QueryOldSelected = "SELECT * FROM candidate INNER JOIN section ON candidate.sectionID = section.sectionID INNER JOIN currentcourse ON section.currentcourseID = currentcourse.currentcourseID INNER JOIN user ON user.userID = candidate.userID WHERE currentcourse.year = '"
							+ intyear
							+ "' AND currentcourse.semester = '"
							+ intterm
							+ "' AND currentcourse.courseCode = '"
							+ rscourse
									.getString("courseplan.courseCode")
							+ "' GROUP BY candidate.userID ORDER BY user.usertype";
					StringBuilder sb = new StringBuilder();
					ResultSet rscountselected = stmt
							.executeQuery(QueryOldSelected);
					rscountselected.last();
					int countselected = rscountselected.getRow();
					String str[] = new String[countselected];
					ResultSet rsselected = stmt
							.executeQuery(QueryOldSelected);
					int countselected2 = 0;
					while (rsselected.next()) {
						str[countselected2] = rsselected
								.getString("user.firstname")
								+ " "
								+ rsselected.getString("user.lastname")
								+ " "
								+ "("
								+ rsselected.getString("user.usertype")
								+ ")";
						countselected2++;
					}
					/*rowdata.setHeightInPoints((countselected2 * sheet
							.getDefaultRowHeightInPoints()));*/
					for (int i = 0; i < str.length; i++) {
						if (i == str.length - 1) {
							sb.append(str[i]);
						} else {
							sb.append(str[i] + "\n");
						}
					}
					cell6.setCellValue(sb.toString());

					// End Get old selected teacher

					// Get Candidate
					stmt = con.createStatement();
					String Querycandidate = "SELECT * FROM course_survey INNER JOIN courseplan ON courseplan.courseCode = course_survey.courseCode INNER JOIN user ON course_survey.userID = user.userID WHERE course_survey.year = '"
							+ year
							+ "' AND course_survey.semester = '"
							+ term
							+ "' AND courseplan.year = '"
							+ year
							+ "' AND courseplan.semester = '"
							+ term
							+ "' AND course_survey.courseCode = '"
							+ rscourse
									.getString("courseplan.courseCode")
							+ "' GROUP BY course_survey.userID";

					StringBuilder sb2 = new StringBuilder();
					ResultSet rscountcandidate = stmt
							.executeQuery(Querycandidate);
					rscountcandidate.last();
					int countcandidate = rscountcandidate.getRow();
					String str2[] = new String[countcandidate];
					ResultSet rscandidate = stmt
							.executeQuery(Querycandidate);
					int countcandidate2 = 0;
					while (rscandidate.next()) {
						str2[countcandidate2] = rscandidate
								.getString("user.firstname")
								+ " "
								+ rscandidate
										.getString("user.lastname")
								+ " "
								+ "("
								+ rscandidate
										.getString("user.usertype")
								+ ")";
						countcandidate2++;
					}
					/*rowdata.setHeightInPoints((countcandidate2 * sheet
							.getDefaultRowHeightInPoints()));*/

					for (int i = 0; i < str2.length; i++) {
						if (i == str2.length - 1) {
							sb2.append(str2[i]);
						} else {
							sb2.append(str2[i] + "\n");
						}
					}
					cell7.setCellValue(sb2.toString());

					// End Get Candidate

					// Set rowdata height for old select and candidate

					if (countselected2 > countcandidate2) {
						rowdata.setHeightInPoints((countselected2 * sheet
								.getDefaultRowHeightInPoints()));
					} else {
						rowdata.setHeightInPoints((countcandidate2 * sheet
								.getDefaultRowHeightInPoints()));
					}

					cell6.setCellStyle(stylecoursename);
					cell7.setCellStyle(stylecoursename);

					rowdata = sheet.createRow(countmajor);
				}

				countrow = (nummajor + countrow) - 1;
				countrow++;
			}

			/* // Write the output to a file
			FileOutputStream fileOut = new FileOutputStream(filename);
			wb.write(fileOut);
			fileOut.close(); */

			// write it as an excel attachment
			ByteArrayOutputStream outByteStream = new ByteArrayOutputStream();
			wb.write(outByteStream);
			byte[] outArray = outByteStream.toByteArray();
			response.setContentType("application/ms-excel");
			response.setContentLength(outArray.length);
			response.setHeader("Expires:", "0"); // eliminates browser caching
			response.setHeader("Content-Disposition",
					"attachment; filename=course " + year + " " + term
							+ ".xls");
			OutputStream outStream = response.getOutputStream();
			outStream.write(outArray);
			outStream.flush();

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (Exception e) {

		}
	} else if (reporttype.equals("candidate+workload")) {
		System.out.println(3);

		/* String filename = "C:/Users/MahaloBankupu/Desktop/workload " + year + " "
				+ term + ".xls"; */

		try {

			Class.forName(readdriver);
			con = DriverManager.getConnection(url, readuser, readpass);

			HSSFWorkbook wb = new HSSFWorkbook();
			HSSFSheet sheet = wb.createSheet("new sheet");

			// Set Style
			CellStyle style = wb.createCellStyle();
			style.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
			style.setAlignment(HSSFCellStyle.ALIGN_CENTER);

			CellStyle stylecoursename = wb.createCellStyle();
			stylecoursename
					.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
			stylecoursename.setAlignment(HSSFCellStyle.ALIGN_LEFT);

			CellStyle styledata = wb.createCellStyle();
			styledata.setVerticalAlignment(HSSFCellStyle.VERTICAL_TOP);
			styledata.setAlignment(HSSFCellStyle.ALIGN_CENTER);

			//style.setBorderBottom(HSSFCellStyle.BORDER_THIN);
			//style.setBorderTop(HSSFCellStyle.BORDER_THIN);
			//style.setBorderRight(HSSFCellStyle.BORDER_THIN);
			//style.setBorderLeft(HSSFCellStyle.BORDER_THIN);

			// Set ColumnWidth
			sheet.setColumnWidth(1, 10000);
			sheet.setColumnWidth(2, 3000);
			sheet.setColumnWidth(3, 15000);
			sheet.setColumnWidth(5, 3000);
			sheet.setColumnWidth(14, 3000);

			// Create Row
			HSSFRow row0 = sheet.createRow(0);
			HSSFRow row1 = sheet.createRow(1);
			HSSFRow row2 = sheet.createRow(2);
			HSSFRow row3 = sheet.createRow(3);

			// Create cell
			HSSFCell cell0_0 = row0.createCell(0);

			HSSFCell cell1_5 = row1.createCell(5);
			HSSFCell cell1_8 = row1.createCell(8);
			HSSFCell cell1_11 = row1.createCell(11);
			HSSFCell cell1_13 = row1.createCell(13);

			HSSFCell cell2_0 = row2.createCell(0);
			HSSFCell cell2_1 = row2.createCell(1);
			HSSFCell cell2_2 = row2.createCell(2);
			HSSFCell cell2_5 = row2.createCell(5);
			HSSFCell cell2_6 = row2.createCell(6);
			HSSFCell cell2_7 = row2.createCell(7);
			HSSFCell cell2_8 = row2.createCell(8);
			HSSFCell cell2_9 = row2.createCell(9);
			HSSFCell cell2_10 = row2.createCell(10);
			HSSFCell cell2_11 = row2.createCell(11);
			HSSFCell cell2_12 = row2.createCell(12);
			HSSFCell cell2_13 = row2.createCell(13);
			HSSFCell cell2_14 = row2.createCell(14);

			HSSFCell cell3_2 = row3.createCell(2);
			HSSFCell cell3_3 = row3.createCell(3);
			HSSFCell cell3_4 = row3.createCell(4);

			// Add Header Text
			cell0_0.setCellValue("Teaching Workload Semester " + term
					+ "/" + year);
			cell1_5.setCellValue("Lecture");
			cell1_8.setCellValue("Lab");
			cell1_11.setCellValue("(Lec+Lab)/Week");
			cell1_13.setCellValue("Total");
			cell2_0.setCellValue("No.");
			cell2_1.setCellValue("Lecturer");
			cell2_2.setCellValue("Course");
			cell2_5.setCellValue("#of\nLec");
			cell2_6.setCellValue("#of\nLecturer");
			cell2_7.setCellValue("hour /\nLec sec");
			cell2_8.setCellValue("#of\nLab");
			cell2_9.setCellValue("#of\nLecturer");
			cell2_10.setCellValue("hour /\nLab");
			cell2_11.setCellValue("hours");
			cell2_12.setCellValue("workload");
			cell2_13.setCellValue("Hours /\nweek");
			cell2_14.setCellValue("Workload /\nweek");
			cell3_2.setCellValue("Code");
			cell3_3.setCellValue("Name");
			cell3_4.setCellValue("Credit");

			// Add Vertical Align
			cell0_0.setCellStyle(stylecoursename);
			cell1_5.setCellStyle(style);
			cell1_8.setCellStyle(style);
			cell1_11.setCellStyle(style);
			cell1_13.setCellStyle(style);
			cell2_0.setCellStyle(stylecoursename);
			cell2_1.setCellStyle(stylecoursename);
			cell2_2.setCellStyle(style);
			cell2_5.setCellStyle(style);
			cell2_6.setCellStyle(style);
			cell2_7.setCellStyle(style);
			cell2_8.setCellStyle(style);
			cell2_9.setCellStyle(style);
			cell2_10.setCellStyle(style);
			cell2_11.setCellStyle(style);
			cell2_12.setCellStyle(style);
			cell2_13.setCellStyle(style);
			cell2_14.setCellStyle(style);
			cell3_2.setCellStyle(style);
			cell3_3.setCellStyle(style);
			cell3_4.setCellStyle(style);

			sheet.addMergedRegion(new CellRangeAddress(0, 0, 0, 14));
			sheet.addMergedRegion(new CellRangeAddress(1, 1, 0, 4));
			sheet.addMergedRegion(new CellRangeAddress(1, 1, 5, 7));
			sheet.addMergedRegion(new CellRangeAddress(1, 1, 8, 10));
			sheet.addMergedRegion(new CellRangeAddress(1, 1, 11, 12));
			sheet.addMergedRegion(new CellRangeAddress(1, 1, 13, 14));
			sheet.addMergedRegion(new CellRangeAddress(2, 2, 2, 4));
			sheet.addMergedRegion(new CellRangeAddress(2, 3, 0, 0));
			sheet.addMergedRegion(new CellRangeAddress(2, 3, 1, 1));
			sheet.addMergedRegion(new CellRangeAddress(2, 3, 5, 5));
			sheet.addMergedRegion(new CellRangeAddress(2, 3, 6, 6));
			sheet.addMergedRegion(new CellRangeAddress(2, 3, 7, 7));
			sheet.addMergedRegion(new CellRangeAddress(2, 3, 8, 8));
			sheet.addMergedRegion(new CellRangeAddress(2, 3, 9, 9));
			sheet.addMergedRegion(new CellRangeAddress(2, 3, 10, 10));
			sheet.addMergedRegion(new CellRangeAddress(2, 3, 11, 11));
			sheet.addMergedRegion(new CellRangeAddress(2, 3, 12, 12));
			sheet.addMergedRegion(new CellRangeAddress(2, 3, 13, 13));
			sheet.addMergedRegion(new CellRangeAddress(2, 3, 14, 14));

			// End Header

			// Get Data

			int countno = 1;
			int countrow = 4;

			// Get teacher and teachera assistance
			stmt = con.createStatement();
			String Query = "SELECT * FROM candidate inner  join section on candidate.sectionID = section.sectionID inner join currentcourse on section.currentcourseID = currentcourse.currentcourseID inner join user on candidate.userID = user.userID where currentcourse.year = '"
					+ year
					+ "' and currentcourse.semester = '"
					+ term
					+ "'and (user.usertype = 'Teaching Assistance' or user.usertype = 'Teacher') group by candidate.userID ;";
			ResultSet rstecher = stmt.executeQuery(Query);

			while (rstecher.next()) {

				// for the calculate the workload
				int of_lec = 0;
				int of_lecturers = 0;
				int of_lab = 0;
				int of_lablecturers = 0;
				double wlLect = 0;
				double wlLab = 0;

				int hourAll = 0;
				double result = 0;

				int totalHourPerWeek = 0;
				double totalWorkload = 0;

				HSSFRow rowdata = sheet.createRow(countrow);
				HSSFCell cell0 = rowdata.createCell(0);
				HSSFCell cell1 = rowdata.createCell(1);

				// for check user id in the row
				String userID = rstecher.getString("userID");

				cell0.setCellValue(countno);
				cell1.setCellValue(rstecher.getString("user.firstname")
						+ " " + rstecher.getString("user.lastname"));

				cell0.setCellStyle(stylecoursename);
				cell1.setCellStyle(stylecoursename);

				// Loop course and credit with user id to check the course
				String qCourse = "SELECT * FROM section inner join candidate inner join currentcourse inner join course on userID = '"
						+ userID
						+ "' and currentcourse.courseCode = course.courseCode and section.currentcourseID = currentcourse.currentcourseID and currentcourse.year = '"
						+ year
						+ "' and currentcourse.semester = '"
						+ term
						+ "'  and  section.sectionID = candidate.sectionID  group by currentcourse.courseCode;";

				stmt = con.createStatement();
				ResultSet rscourselength = stmt.executeQuery(qCourse);
				rscourselength.last();
				int courselength = rscourselength.getRow();

				// count the loop in each calculate
				int counthourperweek = 0;
				int countworkload = 0;
				int hourperweek[] = new int[courselength];
				double workload[] = new double[courselength];

				sheet.addMergedRegion(new CellRangeAddress(countrow,
						(courselength + countrow) - 1, 0, 0));
				sheet.addMergedRegion(new CellRangeAddress(countrow,
						(courselength + countrow) - 1, 1, 1));

				// merge cell at hour/week and workload/week
				sheet.addMergedRegion(new CellRangeAddress(countrow,
						(courselength + countrow) - 1, 13, 13));
				sheet.addMergedRegion(new CellRangeAddress(countrow,
						(courselength + countrow) - 1, 14, 14));

				int countcourse = countrow;
				ResultSet rscourse = stmt.executeQuery(qCourse);
				while (rscourse.next()) {
					HSSFCell cell2 = rowdata.createCell(2);
					HSSFCell cell3 = rowdata.createCell(3);
					HSSFCell cell4 = rowdata.createCell(4);

					cell2.setCellValue(rscourse
							.getString("course.courseCode"));
					cell3.setCellValue(rscourse
							.getString("course.courseName"));
					cell4.setCellValue(rscourse
							.getString("course.credit"));

					cell2.setCellStyle(style);
					cell3.setCellStyle(stylecoursename);
					cell4.setCellStyle(style);

					String credit = rscourse.getString("course.credit");
					String courseCode = rscourse
							.getString("course.courseCode");
					String courseName = rscourse
							.getString("course.courseName");

					// Spilte credit for the calculated

					String[] parts = credit.split("[\\s()]", 4);

					String creditSplit = parts[0];
					String splitnext = parts[2];

					String[] partstwo = splitnext.split("-", 3);
					String lect = partstwo[0];
					String lab = partstwo[1];
					String self = partstwo[2];

					// change string to int
					int lect_of_hour = Integer.parseInt(lect);
					int lab_of_hour = Integer.parseInt(lab);

					// Skip of_lec calculate the course
					if (courseName.equalsIgnoreCase("Senior Project 2")
							|| courseName
									.equalsIgnoreCase("Co-operative Education")
							|| courseName
									.equalsIgnoreCase("Senior Project 1")) {

					} else {
						if (lect_of_hour == 0) {
							HSSFCell cell5 = rowdata.createCell(5);
							cell5.setCellValue(" ");
							cell5.setCellStyle(style);

						} else {

							// Count of lec
							stmt = con.createStatement();
									String qOfLec = "SELECT * FROM section inner join candidate inner join currentcourse inner join course where userID = '"
											+ userID
											+ "' and currentcourse.courseCode = course.courseCode and section.currentcourseID = currentcourse.currentcourseID and currentcourse.year = '"
											+ year
											+ "' and currentcourse.semester = '"
											+ term
											+ "' and  section.sectionID = candidate.sectionID and candidate.teachtype = 'Lect' and currentcourse.courseCode = '"
											+ courseCode
											+ "'  group by section.sectionlect   ";
									ResultSet rsOfLec = stmt.executeQuery(qOfLec);
									rsOfLec.last();
									of_lec = rsOfLec.getRow();

							HSSFCell cell5 = rowdata.createCell(5);
							cell5.setCellValue(of_lec);
							cell5.setCellStyle(style);

						}
					}

					// Find number of lectuers in course
					stmt = con.createStatement();
							String qOfLectures = "SELECT * FROM section inner join candidate inner join currentcourse inner join course where currentcourse.courseCode = course.courseCode and section.currentcourseID = currentcourse.currentcourseID and currentcourse.year = '"
									+ year
									+ "' and currentcourse.semester = '"
									+ term
									+ "' and  section.sectionID = candidate.sectionID and candidate.teachtype = 'Lect' and currentcourse.courseCode = '"
									+ courseCode
									+ "' and candidate.userID = '"
									+ userID
									+ "' group by candidate.userID ";
							ResultSet rsOfLectures = stmt.executeQuery(qOfLectures);

							rsOfLectures.last();
							of_lecturers = rsOfLectures.getRow();
					HSSFCell cell6 = rowdata.createCell(6);
					cell6.setCellValue(of_lecturers);
					cell6.setCellStyle(style);

					// skip lec of hour 
					if (courseName.equalsIgnoreCase("Senior Project 2")
							|| courseName
									.equalsIgnoreCase("Co-operative Education")
							|| courseName
									.equalsIgnoreCase("Senior Project 1")) {
						HSSFCell cell7 = rowdata.createCell(7);
						cell7.setCellValue(" ");

					} else {

						HSSFCell cell7 = rowdata.createCell(7);
						cell7.setCellValue(lect_of_hour);
						cell7.setCellStyle(style);

					}

					// skip the course
					if (courseName.equalsIgnoreCase("Senior Project 2")
							|| courseName
									.equalsIgnoreCase("Co-operative Education")
							|| courseName
									.equalsIgnoreCase("Senior Project 1")) {

					} else {

						if (lab_of_hour == 0) {
							HSSFCell cell8 = rowdata.createCell(8);
							cell8.setCellValue(" ");
							cell8.setCellStyle(style);
						} else {

							// find of the lab
							stmt = con.createStatement();
									String qOfLec = "SELECT COUNT(*) AS rowcount FROM section inner join candidate inner join currentcourse inner join course where userID = '"
											+ userID
											+ "' and currentcourse.courseCode = course.courseCode and section.currentcourseID = currentcourse.currentcourseID and currentcourse.year = '"
											+ year
											+ "' and currentcourse.semester = '"
											+ term
											+ "' and  section.sectionID = candidate.sectionID and candidate.teachtype = 'Lab' and currentcourse.courseCode = '"
											+ courseCode + "'  ";
									ResultSet rsOfLec = stmt.executeQuery(qOfLec);

									rsOfLec.next();
									of_lab = rsOfLec.getInt("rowcount");
							HSSFCell cell8 = rowdata.createCell(8);
							cell8.setCellValue(of_lab);
							cell8.setCellStyle(style);

						}
					}

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
								+ courseCode
								+ "' and user.usertype = 'Teacher' and candidate.userID = '"
								+ userID + "' group by candidate.userID;  ";
						ResultSet rsOfLec2 = stmt.executeQuery(qOfLecturesLab);
						rsOfLec2.last();
						of_lablecturers = rsOfLec2.getRow();
						while (rsOfLec2.next()) {
							String a = rsOfLec2
									.getString("currentcourse.courseCode");

						}

						//out.print(of_lablecturers);

					} else if (userType.equals("Teaching Assistance")) {
						// หาจำนวน อ. ท่ีสอนใน Lab นั้น
						stmt = con.createStatement();
						String qOfLecturesLab = "SELECT * FROM section inner join candidate inner join currentcourse inner join course inner join user where currentcourse.courseCode = course.courseCode and section.currentcourseID = currentcourse.currentcourseID and currentcourse.year = '"
								+ year
								+ "' and currentcourse.semester = '"
								+ term
								+ "' and  section.sectionID = candidate.sectionID  and candidate.teachtype = 'Lab' and currentcourse.courseCode = '"
								+ courseCode
								+ "' and user.usertype = 'Teaching Assistance' and candidate.userID = '"
								+ userID + "'  group by candidate.userID;  ";
						ResultSet rsOfLec2 = stmt.executeQuery(qOfLecturesLab);
						rsOfLec2.last();
						of_lablecturers = rsOfLec2.getRow();
						while (rsOfLec2.next()) {
							String a = rsOfLec2
									.getString("currentcourse.courseCode");

						}

					//	out.print(of_lablecturers);

					}

					HSSFCell cell9 = rowdata.createCell(9);
					cell9.setCellValue(of_lablecturers);
					cell9.setCellStyle(style);

					if (courseName.equalsIgnoreCase("Senior Project 2")
							|| courseName
									.equalsIgnoreCase("Co-operative Education")
							|| courseName
									.equalsIgnoreCase("Senior Project 1")) {

						HSSFCell cell10 = rowdata.createCell(10);
						cell10.setCellValue(" ");

					} else {

						HSSFCell cell10 = rowdata.createCell(10);
						cell10.setCellValue(lab_of_hour);
						cell10.setCellStyle(style);

					}

					if (courseName.equalsIgnoreCase("Senior Project 2")
							|| courseName
									.equalsIgnoreCase("Co-operative Education")
							|| courseName
									.equalsIgnoreCase("Senior Project 1")) {

						HSSFCell cell11 = rowdata.createCell(11);
						cell11.setCellValue("0");
						cell11.setCellStyle(style);
						counthourperweek++;

					} else {

						
						int of_lec_all_hour = 0;
						int of_lab_all_hour = 0;
						of_lec_all_hour = lect_of_hour * of_lec;
						of_lab_all_hour = lab_of_hour * of_lab;
						hourAll = of_lec_all_hour + of_lab_all_hour;

						hourperweek[counthourperweek] = hourAll;
						counthourperweek++;

						HSSFCell cell11 = rowdata.createCell(11);

						cell11.setCellValue(hourAll);
						cell11.setCellStyle(style);
					}

					// calculate the workload
					try {

						// ignore some course
						if (courseName
								.equalsIgnoreCase("Senior Project 2")
								|| courseName
										.equalsIgnoreCase("Co-operative Education")
								|| courseName
										.equalsIgnoreCase("Senior Project 1")) {

							HSSFCell cell12 = rowdata.createCell(12);

							cell12.setCellValue("0");
							cell12.setCellStyle(style);
							countworkload++;

						} else {

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
									+ courseCode + "' group by section.sectionlect ;";
							ResultSet rsfindCourse = stmt.executeQuery(findthecourse);
							while (rsfindCourse.next()) {
								courseStack = rsfindCourse.getString("course.courseName");
								count++;
							}
							
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
								workload[countworkload] = Sumworkload;

								HSSFCell cell12 = rowdata
										.createCell(12);
								cell12.setCellValue(finalResult);
								cell12.setCellStyle(style);

								// IF LECT NOT HAVE LECTURERS BUT LAB HAVE LECTURERS
							}else if (of_lecturers == 0 && of_lablecturers != 0) {
								// Cal Lab wl
								workloadLab = (of_lab * lab_of_hour * 0.5)
										/ of_lablecturers;

								Sumworkload = workloadLab + workloadLectSum;

								String finalResult = String.format("%.2f", Sumworkload);
								workload[countworkload] = Sumworkload;

								HSSFCell cell12 = rowdata
										.createCell(12);
								cell12.setCellValue(finalResult);
								cell12.setCellStyle(style);

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
								workload[countworkload] = Sumworkload;
								HSSFCell cell12 = rowdata
										.createCell(12);
								cell12.setCellValue(finalResult);
								cell12.setCellStyle(style);
								
							}// IF LECT AND LAB NOT CALCULATE
							else if (of_lecturers == 0 && of_lablecturers == 0) {
								Sumworkload = workloadLab + workloadLectSum;

								String finalResult = String.format("%.2f", Sumworkload);
								workload[countworkload] = Sumworkload;
								HSSFCell cell12 = rowdata
										.createCell(12);
								cell12.setCellValue(finalResult);
								cell12.setCellStyle(style);

							}
							countworkload++;
							
							/* if (of_lecturers != 0
									&& of_lablecturers != 0) {

								// calculate the teacher teach in same corse more the 1 section
								if (of_lecturers >= 2) {
									// for lecture
									wlLect = (of_lec * lect_of_hour * 0.5)
											/ of_lecturers;
									// one section
								} else {
									wlLect = (of_lec * lect_of_hour)
											/ of_lecturers;

								}

								// for lab

								wlLab = (of_lab * lab_of_hour * 0.5)
										/ of_lablecturers;

								result = wlLab + wlLect;
								String finalResult = String.format(
										"%.2f", result);
								workload[countworkload] = result;

								HSSFCell cell12 = rowdata
										.createCell(12);
								cell12.setCellValue(finalResult);
								cell12.setCellStyle(style);

							} else if (of_lecturers == 0
									&& of_lablecturers != 0) {
								// for lab
								wlLab = (of_lab * lab_of_hour * 0.5)
										/ of_lablecturers;

								result = wlLab + wlLect;
								String finalResult = String.format(
										"%.2f", result);

								workload[countworkload] = result;

								HSSFCell cell12 = rowdata
										.createCell(12);
								cell12.setCellValue(finalResult);
								cell12.setCellStyle(style);

							} else if (of_lecturers != 0
									&& of_lablecturers == 0) {
								if (of_lecturers >= 2) {
									// for lecture
									wlLect = (of_lec * lect_of_hour * 0.5)
											/ of_lecturers;
								} else {
									wlLect = (of_lec * lect_of_hour)
											/ of_lecturers;
								}

								result = wlLab + wlLect;
								String finalResult = String.format(
										"%.2f", result);
								workload[countworkload] = result;
								HSSFCell cell12 = rowdata
										.createCell(12);
								cell12.setCellValue(finalResult);
								cell12.setCellStyle(style);
							} else if (of_lecturers == 0
									&& of_lablecturers == 0) {
								// no calculate
								result = wlLab + wlLect;
								String finalResult = String.format(
										"%.2f", result);
								workload[countworkload] = result;
								HSSFCell cell12 = rowdata
										.createCell(12);
								cell12.setCellValue(finalResult);
								cell12.setCellStyle(style);
							}
 */
							//countworkload++;

						}
					} catch (ArithmeticException e) {
						System.out.print(e);
					} catch (NumberFormatException e) {
						System.out.print(e);
					} catch (Exception e) {
						System.out.print(e);
					}

					// some hour per week
					if (hourperweek.length == counthourperweek) {

						for (int i = 0; i < hourperweek.length; i++) {
							totalHourPerWeek = hourperweek[i]
									+ totalHourPerWeek;
						}

						//sheet.getRow(countcourse-counthourperweek+1).createCell(13).setCellValue(totalHourPerWeek);
						HSSFRow row = sheet.getRow(countcourse
								- counthourperweek + 1);
						HSSFCell cell = row.createCell(13);
						cell.setCellValue(totalHourPerWeek);
						cell.setCellStyle(style);

					}

					// sum workload per week
					if (workload.length == countworkload) {
						for (int i = 0; i < workload.length; i++) {
							totalWorkload = workload[i] + totalWorkload;
						}
						String finalResult = String.format("%.2f",
								totalWorkload);

						//sheet.getRow(countcourse-counthourperweek+1).createCell(14).setCellValue(finalResult);
						HSSFRow row = sheet.getRow(countcourse
								- counthourperweek + 1);
						HSSFCell cell = row.createCell(14);
						cell.setCellValue(finalResult);
						cell.setCellStyle(style);

					}

					countcourse++;
					rowdata = sheet.createRow(countcourse);
				}

				countrow = (courselength + countrow) - 1;
				countno++;
				countrow++;
			}

			/* // Write the output to a file
			FileOutputStream fileOut = new FileOutputStream(filename);
			wb.write(fileOut);
			fileOut.close(); */

			// write it as an excel attachment
			ByteArrayOutputStream outByteStream = new ByteArrayOutputStream();
			wb.write(outByteStream);
			byte[] outArray = outByteStream.toByteArray();
			response.setContentType("application/ms-excel");
			response.setContentLength(outArray.length);
			response.setHeader("Expires:", "0"); // eliminates browser caching
			response.setHeader("Content-Disposition",
					"attachment; filename=workload " + year + " "
							+ term + ".xls");
			OutputStream outStream = response.getOutputStream();
			outStream.write(outArray);
			outStream.flush();

		} catch (SQLException e) {

		} catch (ClassNotFoundException e) {

		} catch (Exception e) {

		}

	} else if (reporttype.equals("candidate+exam")) {
		System.out.println(4);
		/* String filename = "C:/Users/MahaloBankupu/Desktop/ExamReport "
				+ year + " " + term + ".xls"; */

		try {
			Class.forName(readdriver);
			con = DriverManager.getConnection(url, readuser, readpass);

			HSSFWorkbook wb = new HSSFWorkbook();
			HSSFSheet sheet = wb.createSheet("new sheet");

			// Set Style
			CellStyle style = wb.createCellStyle();
			style.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
			style.setAlignment(HSSFCellStyle.ALIGN_CENTER);

			CellStyle stylecoursename = wb.createCellStyle();
			stylecoursename
					.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
			stylecoursename.setAlignment(HSSFCellStyle.ALIGN_LEFT);

			CellStyle styledata = wb.createCellStyle();
			styledata.setVerticalAlignment(HSSFCellStyle.VERTICAL_TOP);
			styledata.setAlignment(HSSFCellStyle.ALIGN_CENTER);

			CellStyle styledata2 = wb.createCellStyle();
			styledata2
					.setVerticalAlignment(HSSFCellStyle.VERTICAL_BOTTOM);
			styledata2.setAlignment(HSSFCellStyle.ALIGN_CENTER);

			// Set ColumnWidth
			sheet.setColumnWidth(1, 3000);
			sheet.setColumnWidth(2, 15000);
			sheet.setColumnWidth(8, 10000);
			sheet.setColumnWidth(9, 10000);
			sheet.setColumnWidth(10, 10000);

			// Create Row
			HSSFRow row0 = sheet.createRow(0);
			HSSFRow row1 = sheet.createRow(1);
			HSSFRow row2 = sheet.createRow(2);

			// Create cell
			HSSFCell cell0_0 = row0.createCell(0);
			HSSFCell cell0_1 = row0.createCell(1);
			HSSFCell cell0_2 = row0.createCell(2);
			HSSFCell cell0_3 = row0.createCell(3);
			HSSFCell cell0_4 = row0.createCell(4);
			HSSFCell cell0_5 = row0.createCell(5);
			HSSFCell cell0_6 = row0.createCell(6);
			HSSFCell cell0_8 = row0.createCell(8);
			HSSFCell cell0_9 = row0.createCell(9);
			HSSFCell cell0_10 = row0.createCell(10);
			HSSFCell cell0_11 = row0.createCell(11);

			HSSFCell cell1_11 = row1.createCell(11);
			HSSFCell cell1_12 = row1.createCell(12);
			HSSFCell cell1_14 = row1.createCell(14);
			HSSFCell cell1_15 = row1.createCell(15);

			HSSFCell cell2_6 = row2.createCell(6);
			HSSFCell cell2_7 = row2.createCell(7);
			HSSFCell cell2_12 = row2.createCell(12);
			HSSFCell cell2_13 = row2.createCell(13);
			HSSFCell cell2_15 = row2.createCell(15);
			HSSFCell cell2_16 = row2.createCell(16);

			// Add Header Text
			cell0_0.setCellValue("ลำดับ");
			cell0_1.setCellValue("รหัส\nรายวิชา");
			cell0_2.setCellValue("ชื่อรายวิชา");
			cell0_3.setCellValue("หน่วยกิต");
			cell0_4.setCellValue("นักศึกษา\nสาขาวิชา");
			cell0_5.setCellValue("จำนวน\nนักศึกษา");
			cell0_6.setCellValue("SECTION");
			cell0_8.setCellValue("อาจารย์ผู้สอน");
			cell0_9.setCellValue("อาจารย์ผู้ประสานงานรายวิชา");
			cell0_10.setCellValue("หมายเหตุ");
			cell0_11.setCellValue("จัดสอบโดยส่วนกลาง");
			cell1_11.setCellValue("กลาง\nภาค");
			cell1_12.setCellValue("ประเภทข้อสอบ");
			cell1_14.setCellValue("ปลาย\nภาค");
			cell1_15.setCellValue("ประเภทข้อสอบ");
			cell2_6.setCellValue("LECT");
			cell2_7.setCellValue("LAB");
			cell2_12.setCellValue("อัตนัย");
			cell2_13.setCellValue("ปรนัย");
			cell2_15.setCellValue("อัตนัย");
			cell2_16.setCellValue("ปรนัย");

			// Add Vertical Align
			cell0_0.setCellStyle(style);
			cell0_1.setCellStyle(style);
			cell0_2.setCellStyle(stylecoursename);
			cell0_3.setCellStyle(style);
			cell0_4.setCellStyle(style);
			cell0_5.setCellStyle(style);
			cell0_6.setCellStyle(style);
			cell0_8.setCellStyle(style);
			cell0_9.setCellStyle(style);
			cell0_10.setCellStyle(style);
			cell0_11.setCellStyle(style);
			cell1_11.setCellStyle(style);
			cell1_12.setCellStyle(style);
			cell1_14.setCellStyle(style);
			cell1_15.setCellStyle(style);
			cell2_6.setCellStyle(style);
			cell2_7.setCellStyle(style);
			cell2_12.setCellStyle(style);
			cell2_13.setCellStyle(style);
			cell2_15.setCellStyle(style);
			cell2_16.setCellStyle(style);

			sheet.addMergedRegion(new CellRangeAddress(0, 2, 0, 0));
			sheet.addMergedRegion(new CellRangeAddress(0, 2, 1, 1));
			sheet.addMergedRegion(new CellRangeAddress(0, 2, 2, 2));
			sheet.addMergedRegion(new CellRangeAddress(0, 2, 3, 3));
			sheet.addMergedRegion(new CellRangeAddress(0, 2, 4, 4));
			sheet.addMergedRegion(new CellRangeAddress(0, 2, 5, 5));
			sheet.addMergedRegion(new CellRangeAddress(0, 1, 6, 7));
			sheet.addMergedRegion(new CellRangeAddress(0, 2, 8, 8));
			sheet.addMergedRegion(new CellRangeAddress(0, 2, 9, 9));
			sheet.addMergedRegion(new CellRangeAddress(0, 2, 10, 10));
			sheet.addMergedRegion(new CellRangeAddress(0, 0, 11, 16));
			sheet.addMergedRegion(new CellRangeAddress(1, 2, 11, 11));
			sheet.addMergedRegion(new CellRangeAddress(1, 1, 12, 13));
			sheet.addMergedRegion(new CellRangeAddress(1, 2, 14, 14));
			sheet.addMergedRegion(new CellRangeAddress(1, 1, 15, 16));

			// End Header

			// Get Data
			stmt = con.createStatement();
			String Query1 = "SELECT currentcourse.courseCode, course.courseName, course.credit, candidate.userID FROM candidate INNER JOIN section ON candidate.sectionID = section.sectionID INNER JOIN currentcourse ON currentcourse.currentcourseID = section.currentcourseID INNER JOIN course ON course.courseCode = currentcourse.courseCode WHERE currentcourse.year = '"
					+ year
					+ "' AND currentcourse.semester = '"
					+ term
					+ "' GROUP BY course.courseCode";
			ResultSet rs = stmt.executeQuery(Query1);
			int countrow = 3;
			int count = 0;
			while (rs.next()) {
				count++;
				HSSFRow rowdata = sheet.createRow(countrow);
				HSSFCell cell0 = rowdata.createCell(0);
				HSSFCell cell1 = rowdata.createCell(1);
				HSSFCell cell2 = rowdata.createCell(2);
				HSSFCell cell3 = rowdata.createCell(3);
				HSSFCell cell9 = rowdata.createCell(9);
				HSSFCell cell11 = rowdata.createCell(11);
				HSSFCell cell12 = rowdata.createCell(12);
				HSSFCell cell13 = rowdata.createCell(13);
				HSSFCell cell14 = rowdata.createCell(14);
				HSSFCell cell15 = rowdata.createCell(15);
				HSSFCell cell16 = rowdata.createCell(16);

				cell0.setCellValue(count);
				cell1.setCellValue(rs
						.getString("currentcourse.courseCode"));
				cell2.setCellValue(rs.getString("course.courseName"));
				cell3.setCellValue(rs.getString("course.credit"));

				cell0.setCellStyle(styledata);

				stmt = con.createStatement();
				String Querylength = "SELECT * FROM section INNER JOIN candidate ON candidate.sectionID = section.sectionID INNER JOIN user ON candidate.userID = user.userID INNER JOIN currentcourse ON currentcourse.currentcourseID = section.currentcourseID WHERE currentcourse.courseCode = '"
						+ rs.getString("currentcourse.courseCode")
						+ "'  AND currentcourse.year = '"
						+ year
						+ "' AND currentcourse.semester = '"
						+ term
						+ "' GROUP BY section.sectionID";
				ResultSet rs2 = stmt.executeQuery(Querylength);
				rs2.last();
				int numsec = rs2.getRow();

				//Merge Cell
				sheet.addMergedRegion(new CellRangeAddress(countrow,
						(numsec + countrow) - 1, 0, 0));
				sheet.addMergedRegion(new CellRangeAddress(countrow,
						(numsec + countrow) - 1, 1, 1));
				sheet.addMergedRegion(new CellRangeAddress(countrow,
						(numsec + countrow) - 1, 2, 2));
				sheet.addMergedRegion(new CellRangeAddress(countrow,
						(numsec + countrow) - 1, 3, 3));
				sheet.addMergedRegion(new CellRangeAddress(countrow,
						(numsec + countrow) - 1, 9, 9));
				sheet.addMergedRegion(new CellRangeAddress(countrow,
						(numsec + countrow) - 1, 11, 11));
				sheet.addMergedRegion(new CellRangeAddress(countrow,
						(numsec + countrow) - 1, 12, 12));
				sheet.addMergedRegion(new CellRangeAddress(countrow,
						(numsec + countrow) - 1, 13, 13));
				sheet.addMergedRegion(new CellRangeAddress(countrow,
						(numsec + countrow) - 1, 14, 14));
				sheet.addMergedRegion(new CellRangeAddress(countrow,
						(numsec + countrow) - 1, 15, 15));
				sheet.addMergedRegion(new CellRangeAddress(countrow,
						(numsec + countrow) - 1, 16, 16));

				int countsec = countrow;
				stmt = con.createStatement();
				ResultSet rs3 = stmt.executeQuery(Querylength);
				while (rs3.next()) {
					HSSFCell cell4 = rowdata.createCell(4);
					HSSFCell cell5 = rowdata.createCell(5);
					HSSFCell cell6 = rowdata.createCell(6);
					HSSFCell cell7 = rowdata.createCell(7);
					HSSFCell cell8 = rowdata.createCell(8);
					HSSFCell cell10 = rowdata.createCell(10);

					cell4.setCellValue(rs3.getString("section.major"));
					cell5.setCellValue(rs3
							.getString("section.numberofstudent"));

					// Check null Lect and Lab
					String lect = "";
					if (rs3.getString("section.sectionlect").equals("")) {
						lect = "-";
					} else {
						lect = rs3.getString("section.sectionlect");
					}

					String lab = "";
					if (rs3.getString("section.sectionlab").equals("")) {
						lab = "-";
					} else {
						lab = rs3.getString("section.sectionlab");
					}

					cell6.setCellValue(lect);
					cell7.setCellValue(lab);

					// Get Candidate
					// Ref
					// http://stackoverflow.com/questions/13024425/putting-a-value-in-a-single-cell-through-loop-using-poi-in-java
					stmt = con.createStatement();
					String QueryCandidate = "SELECT * FROM candidate INNER JOIN section ON candidate.sectionID = section.sectionID INNER JOIN currentcourse ON currentcourse.currentcourseID = section.currentcourseID INNER JOIN user ON user.userID = candidate.userID WHERE currentcourse.courseCode = '"
							+ rs3.getString("currentcourse.courseCode")
							+ "' AND currentcourse.year = '"
							+ year
							+ "' AND currentcourse.semester = '"
							+ term
							+ "' AND section.sectionID = '"
							+ rs3.getString("section.sectionID")
							+ "' GROUP BY candidate.userID ORDER BY user.usertype";
					StringBuilder sb = new StringBuilder();
					ResultSet rscountcandidate = stmt
							.executeQuery(QueryCandidate);
					rscountcandidate.last();
					int countcandidate = rscountcandidate.getRow();
					String str[] = new String[countcandidate];
					ResultSet rs5 = stmt.executeQuery(QueryCandidate);
					int countcandidate2 = 0;
					while (rs5.next()) {
						str[countcandidate2] = rs5
								.getString("user.firstname")
								+ " "
								+ rs5.getString("user.lastname")
								+ " "
								+ "("
								+ rs5.getString("user.usertype")
								+ ")";
						countcandidate2++;
					}
					rowdata.setHeightInPoints((countcandidate2 * sheet
							.getDefaultRowHeightInPoints()));
					for (int i = 0; i < str.length; i++) {
						if (i == str.length - 1) {
							sb.append(str[i]);
						} else {
							sb.append(str[i] + "\n");
						}
					}
					cell8.setCellValue(sb.toString());
					// End Get Candidate

					cell4.setCellStyle(styledata2);
					cell5.setCellStyle(styledata2);
					cell6.setCellStyle(styledata2);
					cell7.setCellStyle(styledata2);

					countsec++;

					rowdata = sheet.createRow(countsec);
				}

				// Select Course Co
				String userid = "";
				stmt = con.createStatement();
				String Querycourseco = "SELECT * FROM currentcourse WHERE year = '"
						+ year
						+ "' AND semester = '"
						+ term
						+ "' AND courseCode = '"
						+ rs.getString("currentcourse.courseCode")
						+ "'";
				ResultSet rsco = stmt.executeQuery(Querycourseco);
				if (rsco.next()) {
					userid = rsco
							.getString("currentcourse.courseco_userID");
				}
				String Queryname = "SELECT * FROM user where userID = '"
						+ userid + "'";
				ResultSet rsname = stmt.executeQuery(Queryname);
				if (rsname.next()) {
					cell9.setCellValue(rsname
							.getString("user.firstname")
							+ " "
							+ rsname.getString("user.lastname"));
				}
				//End Course Co

				// Exam
				stmt = con.createStatement();
				String QueryExam = "SELECT * FROM examsurvey WHERE year = '"
						+ year
						+ "' AND semester = '"
						+ term
						+ "' AND courseCode = '"
						+ rs.getString("currentcourse.courseCode")
						+ "'";
				ResultSet rsexam = stmt.executeQuery(QueryExam);
				if (rsexam.next()) {

					String midtermtype = rsexam
							.getString("examsurvey.midtermType");

					if (midtermtype.equals("Multiple Choice")) {
						cell11.setCellValue("/");
						cell12.setCellValue("X");
						cell13.setCellValue("/");
					} else if (midtermtype.equals("Writing")) {
						cell11.setCellValue("/");
						cell12.setCellValue("/");
						cell13.setCellValue("X");
					} else if (midtermtype.equals("MD")) {
						cell11.setCellValue("/");
						cell12.setCellValue("/");
						cell13.setCellValue("/");
					} else if (midtermtype.equals("Off Schedule")) {
						cell11.setCellValue("X");
						cell12.setCellValue("X");
						cell13.setCellValue("X");
					} else if (midtermtype.equals("Not have")) {
						cell11.setCellValue("X");
						cell12.setCellValue("X");
						cell13.setCellValue("X");
					}

					String finaltype = rsexam
							.getString("examsurvey.finalType");

					if (finaltype.equals("Multiple Choice")) {
						cell14.setCellValue("/");
						cell15.setCellValue("X");
						cell16.setCellValue("/");
					} else if (finaltype.equals("Writing")) {
						cell14.setCellValue("/");
						cell15.setCellValue("/");
						cell16.setCellValue("X");
					} else if (finaltype.equals("MD")) {
						cell14.setCellValue("/");
						cell15.setCellValue("/");
						cell16.setCellValue("/");
					} else if (finaltype.equals("Off Schedule")) {
						cell14.setCellValue("X");
						cell15.setCellValue("X");
						cell16.setCellValue("X");
					} else if (finaltype.equals("Not have")) {
						cell14.setCellValue("X");
						cell15.setCellValue("X");
						cell16.setCellValue("X");
					}
				}

				cell11.setCellStyle(style);
				cell12.setCellStyle(style);
				cell13.setCellStyle(style);
				cell14.setCellStyle(style);
				cell15.setCellStyle(style);
				cell16.setCellStyle(style);

				// End Exam

				countrow = (numsec + countrow) - 1;
				countrow++;
			}

			/* // Write the output to a file
			FileOutputStream fileOut = new FileOutputStream(filename);
			wb.write(fileOut);
			fileOut.close(); */

			// write it as an excel attachment
			ByteArrayOutputStream outByteStream = new ByteArrayOutputStream();
			wb.write(outByteStream);
			byte[] outArray = outByteStream.toByteArray();
			response.setContentType("application/ms-excel");
			response.setContentLength(outArray.length);
			response.setHeader("Expires:", "0"); // eliminates browser caching
			response.setHeader("Content-Disposition",
					"attachment; filename=ExamReport " + year + " "
							+ term + ".xls");
			OutputStream outStream = response.getOutputStream();
			outStream.write(outArray);
			outStream.flush();

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (Exception e) {

		}
	} else if (reporttype.equals("off/noexam")) {
		System.out.println(5);
		/* String filename = "C:/Users/MahaloBankupu/Desktop/offschedulenoexam "
				+ year + " " + term + ".xls"; */

		try {

			Class.forName(readdriver);
			con = DriverManager.getConnection(url, readuser, readpass);

			HSSFWorkbook wb = new HSSFWorkbook();
			HSSFSheet sheet = wb.createSheet("new sheet");

			// Set Style
			CellStyle style = wb.createCellStyle();
			style.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
			style.setAlignment(HSSFCellStyle.ALIGN_CENTER);

			CellStyle stylecoursename = wb.createCellStyle();
			stylecoursename
					.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);
			stylecoursename.setAlignment(HSSFCellStyle.ALIGN_LEFT);

			CellStyle styledata = wb.createCellStyle();
			styledata.setVerticalAlignment(HSSFCellStyle.VERTICAL_TOP);
			styledata.setAlignment(HSSFCellStyle.ALIGN_CENTER);

			// Set ColumnWidth
			sheet.setColumnWidth(0, 3000);
			sheet.setColumnWidth(1, 15000);
			sheet.setColumnWidth(2, 9000);
			sheet.setColumnWidth(3, 9000);
			sheet.setColumnWidth(4, 6000);
			sheet.setColumnWidth(5, 9000);
			sheet.setColumnWidth(6, 6000);
			sheet.setColumnWidth(7, 9000);

			// Create Row
			HSSFRow row0 = sheet.createRow(0);

			row0.setHeightInPoints((2 * sheet
					.getDefaultRowHeightInPoints()));

			// Create cell
			HSSFCell cell0_0 = row0.createCell(0);
			HSSFCell cell0_1 = row0.createCell(1);
			HSSFCell cell0_2 = row0.createCell(2);
			HSSFCell cell0_3 = row0.createCell(3);
			HSSFCell cell0_4 = row0.createCell(4);
			HSSFCell cell0_5 = row0.createCell(5);
			HSSFCell cell0_6 = row0.createCell(6);
			HSSFCell cell0_7 = row0.createCell(7);

			// Add Header Text
			cell0_0.setCellValue("รหัส\nรายวิชา");
			cell0_1.setCellValue("ชื่อรายวิชา");
			cell0_2.setCellValue("อาจารย์ผู้สอน");
			cell0_3.setCellValue("อาจารย์ผู้ประสานงานรายวิชา");
			cell0_4.setCellValue("กลางภาค");
			cell0_5.setCellValue("เหตุผล (กลางภาค)");
			cell0_6.setCellValue("ปลายภาค");
			cell0_7.setCellValue("เหตุผล (ปลายภาค)");

			// Add Vertical Align
			cell0_0.setCellStyle(style);
			cell0_1.setCellStyle(stylecoursename);
			cell0_2.setCellStyle(style);
			cell0_3.setCellStyle(style);
			cell0_4.setCellStyle(style);
			cell0_5.setCellStyle(style);
			cell0_6.setCellStyle(style);
			cell0_7.setCellStyle(style);

			// End Header

			// Get Data
			stmt = con.createStatement();
			String QueryExamSurvey = "SELECT * FROM examsurvey INNER JOIN course ON examsurvey.courseCode = course.courseCode WHERE examsurvey.year = '"
					+ year
					+ "' AND examsurvey.semester = '"
					+ term
					+ "' AND ((examsurvey.midtermType = 'Not have' OR examsurvey.midtermType = 'Off Schedule') OR (examsurvey.finalType = 'Not have' OR examsurvey.finalType = 'Off Schedule'))";
			ResultSet rsexamsurvey = stmt.executeQuery(QueryExamSurvey);
			int countrow = 1;
			while (rsexamsurvey.next()) {

				HSSFRow rowdata = sheet.createRow(countrow);

				HSSFCell cell0 = rowdata.createCell(0);
				HSSFCell cell1 = rowdata.createCell(1);
				HSSFCell cell2 = rowdata.createCell(2);
				HSSFCell cell3 = rowdata.createCell(3);
				HSSFCell cell4 = rowdata.createCell(4);
				HSSFCell cell5 = rowdata.createCell(5);
				HSSFCell cell6 = rowdata.createCell(6);
				HSSFCell cell7 = rowdata.createCell(7);

				cell0.setCellValue(rsexamsurvey
						.getString("examsurvey.courseCode"));
				cell1.setCellValue(rsexamsurvey
						.getString("course.courseName"));

				// Get Candidate
				stmt = con.createStatement();
				String QueryCandidate = "SELECT * FROM candidate INNER JOIN section ON candidate.sectionID = section.sectionID INNER JOIN currentcourse ON currentcourse.currentcourseID = section.currentcourseID INNER JOIN user ON user.userID = candidate.userID WHERE currentcourse.courseCode = '"
						+ rsexamsurvey
								.getString("examsurvey.courseCode")
						+ "' AND currentcourse.year = '"
						+ year
						+ "' AND currentcourse.semester = '"
						+ term
						+ "' GROUP BY candidate.userID ORDER BY user.usertype";
				StringBuilder sb = new StringBuilder();
				ResultSet rscountcandidate = stmt
						.executeQuery(QueryCandidate);
				rscountcandidate.last();
				int countcandidate = rscountcandidate.getRow();
				String str[] = new String[countcandidate];
				ResultSet rscandidate = stmt
						.executeQuery(QueryCandidate);
				int countcandidate2 = 0;
				while (rscandidate.next()) {
					str[countcandidate2] = rscandidate
							.getString("user.firstname")
							+ " "
							+ rscandidate.getString("user.lastname")
							+ " "
							+ "("
							+ rscandidate.getString("user.usertype")
							+ ")";
					countcandidate2++;
				}
				rowdata.setHeightInPoints((countcandidate2 * sheet
						.getDefaultRowHeightInPoints()));
				for (int i = 0; i < str.length; i++) {
					if (i == str.length - 1) {
						sb.append(str[i]);
					} else {
						sb.append(str[i] + "\n");
					}
				}
				cell2.setCellValue(sb.toString());

				// Select Course Co
				String userid = "";
				stmt = con.createStatement();
				String Querycourseco = "SELECT * FROM currentcourse WHERE year = '"
						+ year
						+ "' AND semester = '"
						+ term
						+ "' AND courseCode = '"
						+ rsexamsurvey
								.getString("examsurvey.courseCode")
						+ "'";
				ResultSet rsco = stmt.executeQuery(Querycourseco);
				if (rsco.next()) {
					userid = rsco
							.getString("currentcourse.courseco_userID");
				}
				String Queryname = "SELECT * FROM user where userID = '"
						+ userid + "'";
				ResultSet rsname = stmt.executeQuery(Queryname);
				if (rsname.next()) {
					cell3.setCellValue(rsname
							.getString("user.firstname")
							+ " "
							+ rsname.getString("user.lastname"));
				}
				// End Course Co

				// Mid And Final Off/NoExam
				stmt = con.createStatement();
				String QueryExam = "SELECT * FROM examsurvey WHERE examsurvey.year = '"
						+ year
						+ "' AND examsurvey.semester = '"
						+ term
						+ "' AND examsurvey.courseCode = '"
						+ rsexamsurvey
								.getString("examsurvey.courseCode")
						+ "' AND ((examsurvey.midtermType = 'Not have' OR examsurvey.midtermType = 'Off Schedule') OR (examsurvey.finalType = 'Not have' OR examsurvey.finalType = 'Off Schedule'))";
				ResultSet rsexam = stmt.executeQuery(QueryExam);
				if (rsexam.next()) {

					String midtermtype = rsexam
							.getString("examsurvey.midtermType");

					if (midtermtype.equals("Multiple Choice")) {
						cell4.setCellValue("จัดสอบโดยส่วนกลาง");
						cell5.setCellValue("");
					} else if (midtermtype.equals("Writing")) {
						cell4.setCellValue("จัดสอบโดยส่วนกลาง");
						cell5.setCellValue("");
					} else if (midtermtype.equals("MD")) {
						cell4.setCellValue("จัดสอบโดยส่วนกลาง");
						cell5.setCellValue("");
					} else if (midtermtype.equals("Off Schedule")) {
						cell4.setCellValue("นอกตาราง");
						cell5.setCellValue(rsexam
								.getString("reasonMid"));
					} else if (midtermtype.equals("Not have")) {
						cell4.setCellValue("ไม่มีสอบ");
						cell5.setCellValue(rsexam
								.getString("reasonMid"));
					}

					String finaltype = rsexam
							.getString("examsurvey.finalType");

					if (finaltype.equals("Multiple Choice")) {
						cell6.setCellValue("จัดสอบโดยส่วนกลาง");
						cell7.setCellValue("");
					} else if (finaltype.equals("Writing")) {
						cell6.setCellValue("จัดสอบโดยส่วนกลาง");
						cell7.setCellValue("");
					} else if (finaltype.equals("MD")) {
						cell6.setCellValue("จัดสอบโดยส่วนกลาง");
						cell7.setCellValue("");
					} else if (finaltype.equals("Off Schedule")) {
						cell6.setCellValue("นอกตาราง");
						cell7.setCellValue(rsexam
								.getString("reasonFinal"));
					} else if (finaltype.equals("Not have")) {
						cell6.setCellValue("ไม่มีสอบ");
						cell7.setCellValue(rsexam
								.getString("reasonFinal"));
					}

					cell4.setCellStyle(styledata);
					cell6.setCellStyle(styledata);

				}

				countrow++;
			}

			// Write the output to a file
			/* FileOutputStream fileOut = new FileOutputStream(filename);
			wb.write(fileOut);
			fileOut.close(); */

			// write it as an excel attachment
			ByteArrayOutputStream outByteStream = new ByteArrayOutputStream();
			wb.write(outByteStream);
			byte[] outArray = outByteStream.toByteArray();
			response.setContentType("application/ms-excel");
			response.setContentLength(outArray.length);
			response.setHeader("Expires:", "0"); // eliminates browser caching
			response.setHeader("Content-Disposition",
					"attachment; filename=offschedulenoexam " + year
							+ " " + term + ".xls");
			OutputStream outStream = response.getOutputStream();
			outStream.write(outArray);
			outStream.flush();

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (Exception e) {

		}
	}

	response.sendRedirect("Admin_Report.jsp");
%>