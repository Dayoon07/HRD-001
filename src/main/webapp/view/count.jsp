<%@page import="vo.VoteListVo"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.VoteDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	VoteDao dao = new VoteDao();
	ArrayList<VoteListVo> list = dao.getVoteList();
%>
<jsp:include page="/master/header.jsp" />

	<section>
		<h2>투표검수조회</h2>
		
		<table>
			<tr>
				<td>성명</td>
				<td>생년월일</td>
				<td>나이</td>
				<td>성별</td>
				<td>후보번호</td>
				<td>투표시간</td>
				<td>유권자확인</td>
			</tr>
			<%
			if (list != null) {
				for (VoteListVo vo : list) {
			%>
			<tr>
				<td><%= vo.getV_name() %></td>
				<td><%= vo.getBirth() %></td>
				<td><%= vo.getAge() %></td>
				<td><%= vo.getGender() %></td>
				<td><%= vo.getC_no() %></td>
				<td><%= vo.getV_time() %></td>
				<td><%= vo.getV_confirm() %></td>
			</tr>
			<%
				}
			}
			%>
		</table>
	</section>

<jsp:include page="/master/footer.jsp" />