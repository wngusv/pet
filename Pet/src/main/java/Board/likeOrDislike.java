package Board;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Util.MyWebContextListener;
import org.json.JSONObject; // JSON 라이브러리

@WebServlet("/likeOrDislike.do")
public class likeOrDislike extends HttpServlet {

	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		HttpSession session = req.getSession();
		String userId = (String) session.getAttribute("userId");

		if (userId != null) {
			String commentNumStr = req.getParameter("commentNum");
			String postIdxStr = req.getParameter("postIdx");

			System.out.println("commentNum: " + commentNumStr); // 로그 출력
			System.out.println("postIdx: " + postIdxStr); // 로그 출력

			int num = Integer.parseInt(req.getParameter("commentNum")); // 댓글 pk
			String type = req.getParameter("reactionType"); 
			int postIdx = Integer.parseInt(req.getParameter("postIdx")); // 게시글 Idx

			// 데이터베이스 연결과 로직을 처리합니다.
			String checkSql = "SELECT * FROM comment_likeordislike WHERE num = ? AND id = ?";

			try (Connection conn = MyWebContextListener.getConnection();
					PreparedStatement checkStmt = conn.prepareStatement(checkSql)) {

				checkStmt.setInt(1, num);
				checkStmt.setString(2, userId);

				try (ResultSet rs = checkStmt.executeQuery()) {
					if (rs.next()) {
						String existingType = rs.getString("type");
						// Null 체크
						if (existingType == null || existingType.equals(type)) {
							// 추천/비추천이 없거나 같은 타입이면 삭제
							String deleteSql = "DELETE FROM comment_likeordislike WHERE num = ? AND id = ?";
							try (PreparedStatement deleteStmt = conn.prepareStatement(deleteSql)) {
								deleteStmt.setInt(1, num);
								deleteStmt.setString(2, userId);
								deleteStmt.executeUpdate();
							}
						} else {
							// 다른 타입이면 업데이트
							String updateSql = "UPDATE comment_likeordislike SET type = ? WHERE num = ? AND id = ?";
							try (PreparedStatement updateStmt = conn.prepareStatement(updateSql)) {
								updateStmt.setString(1, type);
								updateStmt.setInt(2, num);
								updateStmt.setString(3, userId);
								updateStmt.executeUpdate();
							}
						}
					} else {
						// 추천/비추천이 없다면, 새로 추가
						String insertSql = "INSERT INTO comment_likeordislike (num, id, type) VALUES (?, ?, ?)";
						try (PreparedStatement insertStmt = conn.prepareStatement(insertSql)) {
							insertStmt.setInt(1, num);
							insertStmt.setString(2, userId);
							insertStmt.setString(3, type);
							insertStmt.executeUpdate();
						}
					}
					String likeCountSql = "UPDATE comment_content\r\n"
							+ "SET `like` = (SELECT COUNT(*)\r\n"
							+ "              FROM comment_likeordislike\r\n"
							+ "              WHERE comment_likeordislike.num = comment_content.num AND type = '좋아요');";
					String dislikeCountSql =  "UPDATE comment_content\r\n"
							+ "SET `dislike` = (SELECT COUNT(*)\r\n"
							+ "                 FROM comment_likeordislike\r\n"
							+ "                 WHERE comment_likeordislike.num = comment_content.num AND type = '싫어요')";
					try (PreparedStatement pstmt1 = conn.prepareStatement(likeCountSql);
							PreparedStatement pstmt2 = conn.prepareStatement(dislikeCountSql);) {
						pstmt1.executeUpdate();
						pstmt2.executeUpdate();
						
						// 최신 카운트 조회
						int newLikeCount = 0;
						int newDislikeCount = 0;
						String countQuery = "SELECT `like`, `dislike` FROM comment_content WHERE num = ?";
						try (PreparedStatement countStmt = conn.prepareStatement(countQuery)) {
						    countStmt.setInt(1, num);
						    try (ResultSet countRs = countStmt.executeQuery()) {
						        if (countRs.next()) {
						            newLikeCount = countRs.getInt("like");
						            newDislikeCount = countRs.getInt("dislike");
						        }
						    }
						}

						// JSON 형식으로 응답 반환
						resp.setContentType("application/json");
						resp.setCharacterEncoding("UTF-8");
						JSONObject jsonResponse = new JSONObject();
						jsonResponse.put("status", "success");
						jsonResponse.put("newLikeCount", newLikeCount);
						jsonResponse.put("newDislikeCount", newDislikeCount);
						resp.getWriter().write(jsonResponse.toString());

					}
				}

			} catch (SQLException e) {
				e.printStackTrace();
			}

		} else {
			// 로그인하지 않은 경우, 로그인 페이지나 메시지 표시 등의 처리
			// 예: 로그인 페이지로 리다이렉트
			resp.sendRedirect("login.jsp");
		}
	}

}
