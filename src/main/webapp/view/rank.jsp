<%@page import="vo.RankVo"%>
<%@page import="java.util.ArrayList"%>
<%@page import="dao.VoteDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	VoteDao dao = new VoteDao();
	ArrayList<RankVo> list = dao.rankList();
%>
<jsp:include page="/master/header.jsp" />

	<section>
		<h2>후보자 등수 조회</h2>
		
		<table>
			<tr>
				<td>후보자 번호</td>
				<td>후보자 이름</td>
				<td>정당이름</td>
				<td>득표수</td>
				<td>등위</td>
			</tr>
			<%
				if (list != null) {
					for (RankVo vo : list) {
			%>
			<tr>
				<td><%= vo.getC_no() %></td>
				<td><%= vo.getC_name() %></td>
				<td><%= vo.getP_name() %></td>
				<td><%= vo.getTotal() %></td>
				<td><%= vo.getRank() %></td>
			</tr>
			<%
					}
				} else out.print("<tr><td colspan='5'>자료가 없습니다.</td></tr>");
			%>
		</table>
	</section>

<jsp:include page="/master/footer.jsp" />