<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ page import="java.io.*"%>

<%@ page import="java.sql.DriverManager"%>
<%@ page import=" java.sql.SQLException"%>

<%@ page import="  org.apache.poi.EncryptedDocumentException"%>
<%@ page
	import=" org.apache.poi.openxml4j.exceptions.InvalidFormatException"%>
<%@ page import=" org.apache.poi.ss.usermodel.Row"%>
<%@ page import=" org.apache.poi.ss.usermodel.Sheet"%>
<%@ page import="org.apache.poi.ss.usermodel.Workbook"%>
<%@ page import=" org.apache.poi.ss.usermodel.WorkbookFactory"%>

<%@ page import=" com.mysql.jdbc.Connection"%>
<%@ page import="com.mysql.jdbc.PreparedStatement"%>

<%@page import="java.io.InputStream"%>
<%@page import="java.util.Properties"%>


<%
	// Part upload file to the server
	String savePath = null; // decare the gobal for use all of this page

	//to get the content type information from JSP Request Header
	String contentType = request.getContentType();
	//here we are checking the content type is not equal to Null and

	if ((contentType != null)
			&& (contentType.indexOf("multipart/form-data") >= 0)) {
		DataInputStream in = new DataInputStream(
				request.getInputStream());
		//we are taking the length of Content type data
		int formDataLength = request.getContentLength();
		byte dataBytes[] = new byte[formDataLength];
		int byteRead = 0;
		int totalBytesRead = 0;
		//this loop converting the uploaded file into byte code
		while (totalBytesRead < formDataLength) {
			byteRead = in.read(dataBytes, totalBytesRead,
					formDataLength);
			totalBytesRead += byteRead;
		}
		String file = new String(dataBytes, "CP1256");

		//for saving the file name
		String saveFile = file
				.substring(file.indexOf("filename=\"") + 10);
		saveFile = saveFile.substring(0, saveFile.indexOf("\n"));
		saveFile = saveFile.substring(saveFile.lastIndexOf("\\") + 1,
				saveFile.indexOf("\""));
		int lastIndex = contentType.lastIndexOf("=");
		String boundary = contentType.substring(lastIndex + 1,
				contentType.length());
		int pos;

		//extracting the index of file 
		pos = file.indexOf("filename=\"");
		pos = file.indexOf("\n", pos) + 1;
		pos = file.indexOf("\n", pos) + 1;
		pos = file.indexOf("\n", pos) + 1;

		int boundaryLocation = file.indexOf(boundary, pos) - 4;
		int startPos = ((file.substring(0, pos)).getBytes("CP1256")).length;
		int endPos = ((file.substring(0, boundaryLocation))
				.getBytes("CP1256")).length;
		//"CP1256"
		// creating a new file with the same name and writing the content in new file

		savePath = application.getRealPath("\\fileUpload\\" + saveFile);

		System.out.println("Upload file Successfully.<br>");

		System.out.println("Save to : " + savePath);

		FileOutputStream fileOut = new FileOutputStream(savePath);
		fileOut.write(dataBytes, startPos, (endPos - startPos));
		fileOut.flush();
		fileOut.close();
	}

	// end Part upload file to the server

	InputStream stream = application
			.getResourceAsStream("/fileUpload/db.properties");
	Properties props = new Properties();
	props.load(stream);

	String readurl = props.getProperty("url");
	String readdriver = props.getProperty("driver");
	String readuser = props.getProperty("user");
	String readpass = props.getProperty("password");

	// Part take file to the database
	Class.forName(readdriver);
	String url = readurl;
	String username = readuser;
	String password = readpass;

	try {
		Connection con = (Connection) DriverManager.getConnection(url,
				username, password);

		System.out.println("Connecting database...");

		if (con != null) {
			System.out.println("Database Connected.");
		} else {
			System.out.println("Database Connect Failed.");
		}

		con.setAutoCommit(false);
		PreparedStatement pstm = null;
		File file = new File(savePath);
		Workbook wb = WorkbookFactory.create(file);
		Sheet sheet = wb.getSheetAt(0);
		Row row;

		String year = (String) session
				.getAttribute("UploadCoursePlanYear");
		String semester = (String) session
				.getAttribute("UploadCoursePlanTerm");

		for (int i = 1; i <= sheet.getLastRowNum(); i++) {
			row = sheet.getRow(i);
			int coursecode = (int) row.getCell(0).getNumericCellValue();
			String major = row.getCell(3).toString();
			int numberofstudent = (int) row.getCell(4)
					.getNumericCellValue();
			String sql = " INSERT INTO `cms`.`courseplan` (year, semester, courseCode, major, numberofstudent) VALUES ('"
					+ year
					+ "', '"
					+ semester
					+ "', '"
					+ coursecode
					+ "', '"
					+ major
					+ "', '"
					+ numberofstudent
					+ "'); ";
			pstm = (PreparedStatement) con.prepareStatement(sql);
			pstm.execute();
			System.out.println("Import rows " + i);
		}
		con.commit();
		wb.close();
		pstm.close();
		con.close();
	} catch (SQLException ex) {
		System.out.println(ex);
	} catch (IOException ioe) {
		System.out.println(ioe);
	} catch (EncryptedDocumentException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
		System.out.println("EncryptedDocumentException");
	} catch (InvalidFormatException e) {
		// TODO Auto-generated catch block
		e.printStackTrace();
		System.out.println("InvalidFormatException");
	} catch (Exception e) {
		request.setAttribute("errorupload",
				"Something wrong please check your file.");
		System.out.println("Exception e");
	}

	// end Part take file to the database

	// Part for delete file

	System.out.println("delete file..." + savePath);
	File deleteFile = new File(savePath);
	// check if the file  present or not
	if (deleteFile.exists()) {
		deleteFile.delete();
		System.out.println("file deleted");
	}

	// end Part for delete file
	//response.sendRedirect("Admin_CoursePlan.jsp");
	request.getRequestDispatcher("/Coordinator_FormStudyPlan.jsp").forward(
			request, response);
%>

