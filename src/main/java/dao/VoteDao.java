package dao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

import common.DBUtils;
import vo.CandidateVo;
import vo.RankVo;
import vo.VoteListVo;
import vo.VoteVo;

public class VoteDao {
	public ArrayList<CandidateVo> getCandidateList() {
		ArrayList<CandidateVo> list = new ArrayList<CandidateVo>();
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			con = DBUtils.getConnection();
			ps = con.prepareStatement(
					"SELECT A.c_no, A.c_name, B.p_name,\r\n"
					+ "    DECODE(A.c_school, '1', '고졸', '2', '학사', '3', '석사', '4', '박사') c_school,\r\n"
					+ "    SUBSTR(A.c_jumin, 1, 6) || '-' || SUBSTR(A.c_jumin, 7, 7) c_jumin,\r\n"
					+ "    A.c_city,\r\n"
					+ "    B.p_tel1 || '-' || B.p_tel2 || '-' || B.p_tel3 tel\r\n"
					+ "FROM T3_candidate A, T3_party B\r\n"
					+ "WHERE A.p_code = B.p_code\r\n"
					+ "ORDER BY A.p_code"
			);
			rs = ps.executeQuery();
			while (rs.next()) {
				CandidateVo vo = new CandidateVo();
				vo.setC_no(rs.getString("c_no"));
				vo.setC_name(rs.getString("c_name"));
				vo.setP_name(rs.getString("p_name"));
				vo.setC_school(rs.getString("c_school"));
				vo.setC_jumin(rs.getString("c_jumin"));
				vo.setC_city(rs.getString("c_city"));
				vo.setTel(rs.getString("tel"));
				list.add(vo);
			}	// 역순으로 DB 연결 끊기
			rs.close();
			ps.close();
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}
	
	public ArrayList<VoteListVo> getVoteList() {
		ArrayList<VoteListVo> list = new ArrayList<VoteListVo>();
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			con = DBUtils.getConnection();
			ps = con.prepareStatement(
					"SELECT v_name,\r\n"
					+ "    '19' || SUBSTR(v_jumin, 1, 2) || '년 ' || SUBSTR(v_jumin, 3, 2) || '월 ' || SUBSTR(v_jumin, 5, 2) || '일' birth,\r\n"
					+ "    '만 ' || (2024-(TO_NUMBER('19' || SUBSTR(v_jumin, 1, 2)))) || '세' age,\r\n"
					+ "    DECODE(SUBSTR(v_jumin, 7, 1), '1', '남', '2', '여') gender,\r\n"
					+ "    c_no,\r\n"
					+ "    SUBSTR(v_time, 1, 2) || ':' || SUBSTR(v_time, 3, 2) v_time,\r\n"
					+ "    DECODE(v_confirm, 'Y', '확인', 'N', '미확인') v_confirm\r\n"
					+ "FROM T3_vote"
			);
			rs = ps.executeQuery();
			while (rs.next()) {
				VoteListVo vo = new VoteListVo();
				vo.setV_name(rs.getString("v_name"));
				vo.setBirth(rs.getString("birth"));
				vo.setAge(rs.getString("age"));
				vo.setGender(rs.getString("gender"));
				vo.setC_no(rs.getString("c_no"));
				vo.setV_time(rs.getString("v_time"));
				vo.setV_confirm(rs.getString("v_confirm"));
				list.add(vo);
			}
			rs.close();
			ps.close();
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}
	
	public int castVote(VoteVo vo) {
		int n = 0;
		
		Connection con = null;
		PreparedStatement ps = null;
		
		try {
			con  = DBUtils.getConnection();
			ps = con.prepareStatement("INSERT INTO T3_vote VALUES(?, ?, ?, ?, ?, ?)");
			ps.setString(1, vo.getV_jumin());
			ps.setString(2, vo.getV_name());
			ps.setString(3, vo.getC_no());
			ps.setString(4, vo.getV_time());
			ps.setString(5, vo.getV_area());
			ps.setString(6, vo.getV_confirm());
			
			n = ps.executeUpdate();
            if (n > 0) {
              n.comiit();
            }
              ps.close();
              con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return n;
	}
	
	public ArrayList<RankVo> rankList() {
		ArrayList<RankVo> list = new ArrayList<RankVo>();
		Connection con = null;
		PreparedStatement ps = null;
		ResultSet rs = null;
		
		try {
			con = DBUtils.getConnection();
			ps = con.prepareStatement(
					"SELECT A.c_no,\r\n"
					+ "    B.c_name,\r\n"
					+ "    C.p_name,\r\n"
					+ "    COUNT(A.c_no) total,\r\n"
					+ "    RANK() OVER(ORDER BY COUNT(A.c_no) DESC) RANK\r\n"
					+ "FROM T3_vote A, T3_candidate B, T3_party C\r\n"
					+ "WHERE A.c_no = B.c_no AND B.p_code = C.p_code AND A.v_confirm = 'Y'\r\n"
					+ "GROUP BY A.c_no, B.c_name, C.p_name\r\n"
					+ "ORDER BY RANK"
			);
			rs = ps.executeQuery();
			while (rs.next()) {
				RankVo vo = new RankVo();
				vo.setC_no(rs.getString("c_no"));
				vo.setC_name(rs.getString("c_name"));
				vo.setP_name(rs.getString("p_name"));
				vo.setTotal(rs.getInt("total"));
				vo.setRank(rs.getInt("rank"));
				list.add(vo);
			}
			rs.close();
			ps.close();
			con.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return list;
	}
	
	
	
	
	
	
	
	
}
