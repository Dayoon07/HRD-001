<%@page import="vo.CandidateVo"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.VoteDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	VoteDao dao = new VoteDao();
	ArrayList<CandidateVo> list = dao.getCandidateList();
%>
<jsp:include page="/master/header.jsp" />

	<section>
		<h2>후보조회</h2>
		
		<table>
			<tr>
				<td>후보조회</td>
				<td>성명</td>
				<td>소속정당</td>
				<td>학력</td>
				<td>주민번호</td>
				<td>지역구</td>
				<td>대표전화</td>
			</tr>
			<%
				if (list != null) {
					for (CandidateVo vo : list) {
			%>
			<tr>
				<td><%= vo.getC_no() %></td>
				<td><%= vo.getC_name() %></td>
				<td><%= vo.getP_name() %></td>
				<td><%= vo.getC_school() %></td>
				<td><%= vo.getC_jumin() %></td>
				<td><%= vo.getC_city() %></td>
				<td><%= vo.getTel() %></td>
			</tr>
			<%
					}
				} else out.print("<tr><td colspan='7'>조회된 자료가 없습니다.</td></tr>");
			%>
		</table>
	</section>

<jsp:include page="/master/footer.jsp" />