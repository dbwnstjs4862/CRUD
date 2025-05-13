package User;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.SQLIntegrityConstraintViolationException;

public class UserDAO {

	private static final String URL = "jdbc:oracle:thin:@localhost:1521:xe"; // DB 접속 URL
	private static final String USER = "CRUD"; // 오라클 사용자 계정
	private static final String PASSWORD = "DURC"; // 오라클 비밀번호

	private Connection conn;

	public UserDAO() {
		try {
			// 드라이버 로드
			Class.forName("oracle.jdbc.driver.OracleDriver");

			// DB 연결
			conn = DriverManager.getConnection(URL, USER, PASSWORD);
			System.out.println("DB 연결 성공");
		} catch (ClassNotFoundException e) {
			System.out.println("JDBC 드라이버 로드 실패: " + e.getMessage());
		} catch (SQLException e) {
			System.out.println("DB 연결 실패: " + e.getMessage());
		}
	}

	public Connection getConnection() {
		return conn;
	}

	// 사용 후 닫기 위한 메서드
	public void close() {
		try {
			if (conn != null && !conn.isClosed()) {
				conn.close();
				System.out.println("DB 연결 종료");
			}
		} catch (SQLException e) {
			System.out.println("DB 연결 종료 실패: " + e.getMessage());
		}
	}

	public int join(UserDTO user) {
	    String sql = "INSERT INTO users (username, password, name, age) VALUES (?, ?, ?, ?)";
	    try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
	        pstmt.setString(1, user.getUsername());
	        pstmt.setString(2, user.getPassword());
	        pstmt.setString(3, user.getName());
	        pstmt.setInt(4, user.getAge());
	        return pstmt.executeUpdate(); // 1 반환
	    } catch (SQLIntegrityConstraintViolationException e) {
	        System.out.println("❌ 중복된 username입니다: " + e.getMessage());
	        return -1; // username 중복
	    } catch (SQLException e) {
	        e.printStackTrace();
	        return 0; // 기타 오류
	    }
	}

	

	public UserDTO login(String id, String pw) {
	    String sql = "SELECT * FROM users WHERE username = ? AND password = ?";
	    try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
	        pstmt.setString(1, id);
	        pstmt.setString(2, pw);
	        ResultSet rs = pstmt.executeQuery();

	        if (rs.next()) {
	            UserDTO user = new UserDTO();
	            user.setUserId(rs.getInt("userid"));         // int PK
	            user.setUsername(rs.getString("username"));  // 아이디
	            user.setPassword(rs.getString("password"));  // 비번 (선택)
	            user.setName(rs.getString("name"));          // 기타 정보
	            user.setAge(rs.getInt("age"));
	            return user;
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return null; // 로그인 실패 시 null 반환
	}

	public boolean existsByUsername(String username) {
	    String sql = "SELECT COUNT(*) FROM users WHERE username = ?";
	    try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
	        pstmt.setString(1, username);
	        ResultSet rs = pstmt.executeQuery();
	        if (rs.next()) {
	            return rs.getInt(1) > 0;
	        }
	    } catch (Exception e) {
	        e.printStackTrace();
	    }
	    return false;
	}
}