<%@page import="java.time.format.DateTimeFormatter"%>
<%@page import="java.util.ArrayList"%>
<%@page import="exam.dao.AttachfileDao"%>
<%@page import="exam.vo.AttachfileVo"%>
<%@page import="exam.dao.BoardDao"%>
<%@page import="java.time.LocalDateTime"%>
<%@page import="java.io.File"%>
<%@page import="java.util.UUID"%>
<%@page import="exam.vo.BoardVo"%>
<%@page import="org.apache.commons.fileupload.FileItem"%>
<%@page import="java.util.List"%>
<%@page import="org.apache.commons.fileupload.DiskFileUpload"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
// 공개폴더 사용시 - 애플리케이션 내장객체 
	String path = application.getRealPath("/upload");
// download.jsp사용시
	//String path = "C:/Users/it/Desktop/월~금/4차 4.22/MySQL/upload/";
	
	LocalDateTime dateTime = LocalDateTime.now(); // 오늘날짜 객체준비
	DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
	String strDate = dateTime.format(formatter); // 2020-06-16
	
	File dir = new File(path, strDate); // C:/Users/it/Desktop/월~금/4차 4.22/MySQL/upload/2020-06-16
	if (!dir.exists()) {
		dir.mkdir();
	}
	
	DiskFileUpload upload = new DiskFileUpload();
	
	upload.setSizeMax(1024 * 1024 * 20); // 업로드 용량제한(20MB)
	upload.setSizeThreshold(4096); // 메모리상에 저장할 최대크기
	upload.setRepositoryPath(path); //임시 업로드 폴더
		
	List<FileItem> list = upload.parseRequest(request); // 멀티파트 바이트 조립해서 파일아이템 리스트로 반환
	
	
	// DB객체 가져오기
	BoardDao dao = BoardDao.getInstance();
	AttachfileDao attachDao = AttachfileDao.getInstance();
	
	// 생성할 첨부파일Vo 담을 리스트 준비
	List<AttachfileVo> attachList = new ArrayList<>();
	
	// 삭제할 첨부파일 uuid 담을 리스트 준비
	List<String> delUuidList = new ArrayList<>();

	BoardVo vo = new BoardVo();
	String pageNum = "";
	
	// 텍스트 파라미터 작업
	for (FileItem item : list) {
		if (item.isFormField()) {
			if (item.getFieldName().equals("name")) {
				String name = item.getString("utf-8");
				vo.setName(name);
			} else if (item.getFieldName().equals("subject")) {
				vo.setSubject(item.getString("utf-8"));
			} else if (item.getFieldName().equals("content")) {
				vo.setContent(item.getString("utf-8"));
			} else if (item.getFieldName().equals("num")) { // 수정할 글번호 파라미터
				vo.setNum(Integer.parseInt(item.getString("utf-8")));
			} else if (item.getFieldName().equals("delfile")) {
				System.out.println("delfile: " + item.getString("utf-8"));
				
				String uuid = item.getString("utf-8");
				AttachfileVo attachVo = attachDao.getAttachfileByUuid(uuid);
				
				// 파일삭제
				File delFile = new File(attachVo.getUploadpath(), attachVo.getUuid() + "_" + attachVo.getFilename());
				if (delFile.exists()) {
					delFile.delete();
				}
				delUuidList.add(uuid);
			} else if (item.getFieldName().equals("pageNum")) {
				pageNum = item.getString("utf-8");
			}	
		}
	} // for
	
	// uuid에 해당하는 첨부파일 레코드들 삭제
	if (delUuidList.size() > 0) {
		attachDao.deleteAttachfileByUuids(delUuidList);
	}
	
	// 파일 업로드 작업
	for (FileItem item : list) {
		 if (!item.isFormField()) { // 파일
			// 파일이름이 있을때만 파일업로드 및 DB insert
			if (!item.getString("utf-8").equals("")) {
			//파일 생성//
				String filename = item.getName();
				
				// 익스플로러는 파일이름에 경로가 포함되있으므로
				// 순수 파일이름만 부분문자열로 가져오기
				int index = filename.lastIndexOf("\\") + 1;
				filename = filename.substring(index);
				
				// 파일명 중복 피하기 위해 파일이름 앞에 uuid 문자열 붙이기
				UUID uuid = UUID.randomUUID();
				String strUuid = uuid.toString();
				
				// 업로드(생성)할 파일이름
				String uploadFilename = strUuid + "_" + filename;
				
				// 생성할 파일정보 File 객체로 준비
				File file = new File(dir, uploadFilename);
				// 해당 경로에 해당 파일명으로 파일 생성(업로드 수행)
				item.write(file);
				
			//첨부파일 VO 작업//
				// 파일정보 담기위한 AttachfileVo 객체 생성
				AttachfileVo attachVo = new AttachfileVo();
				// 게시판 글번호 설정
				attachVo.setBno(vo.getNum());
				// 업로드 경로 설정
				attachVo.setUploadpath(dir.getPath());
				
				attachVo.setUuid(strUuid);
				attachVo.setFilename(filename);
				
				// 파일명 확장자가 이미지면 "I", 아니면 "O"
				String ext = filename.substring(filename.lastIndexOf(".") + 1);
				if (ext.equalsIgnoreCase("png")
						|| ext.equalsIgnoreCase("gif")
						|| ext.equalsIgnoreCase("jpg")
						|| ext.equalsIgnoreCase("jpeg")) {
					attachVo.setImage("I"); // Image type
				} else {
					attachVo.setImage("O"); // Other type
				}
				attachList.add(attachVo);
			} // if
		}
	} // for
	
	// board 테이블에 글 update하기
	dao.update(vo);
	// attachfile 테이블에 첨부파일정보 리스트 insert하기
	attachDao.insert(attachList);
%>

<script>
	alert('글수정 완료');
	location.href = '/fileBoard/fileContent.jsp?num=<%=vo.getNum() %>&pageNum=<%=pageNum %>';
</script>