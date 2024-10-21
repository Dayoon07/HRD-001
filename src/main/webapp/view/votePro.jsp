<%@page import="dao.VoteDao"%>
<%@page import="vo.VoteVo"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	VoteVo vo = new VoteVo();
	VoteDao dao = new VoteDao();
	int n = 0;
	
	String v_jumin = request.getParameter("v_jumin");
	String v_name = request.getParameter("v_name");
	String c_no = request.getParameter("c_no");
	String v_time = request.getParameter("v_jumin");
	String v_area = request.getParameter("v_time");
	String v_confirm = request.getParameter("v_confirm");
	
	vo.setV_jumin(v_jumin);
	vo.setV_name(v_name);
	vo.setC_no(c_no);
	vo.setV_time(v_time);
	vo.setV_area(v_area);
	vo.setV_confirm(v_confirm);
	
	n = dao.castVote(vo);
	if (n > 0) {
%>
<script>
	alert("입력완료");
	location.href = "/index.jsp";
</script>
<%
	} else {
%>
<script>
	alert("입력실패");
	history.back();
</script>
<%
	}
%>