package Board;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class BoardDAO {
    private Connection conn;

    public BoardDAO() {
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection(
                "jdbc:oracle:thin:@localhost:1521:xe", "CRUD", "DURC"
            );
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public int write(BoardDTO dto) {
        String sql = "INSERT INTO board (title, content, writer_id) VALUES (?, ?, ?)";
        try (PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, dto.getTitle());
            pstmt.setString(2, dto.getContent());
            pstmt.setInt(3, dto.getWriterId());
            return pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
    
    public List<BoardDTO> getAll() {
        List<BoardDTO> list = new ArrayList<>();
        String sql = """
        	    SELECT b.board_id, b.title, b.content, b.writer_id, b.created_at,
        	           u.name
        	    FROM board b
        	    JOIN users u ON b.writer_id = u.userid
        	    ORDER BY b.board_id DESC
        	""";


        try (PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {

            while (rs.next()) {
                BoardDTO dto = new BoardDTO();
                dto.setBoardId(rs.getInt("board_id"));
                dto.setTitle(rs.getString("title"));
                dto.setContent(rs.getString("content"));
                dto.setWriterName(rs.getString("name"));
                dto.setCreatedAt(rs.getString("created_at"));
                list.add(dto);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }
    
    public void close() {
        try {
            if (conn != null && !conn.isClosed()) {
                conn.close();
                System.out.println("BoardDAO 커넥션 종료");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public BoardDTO findById(int id) {
        BoardDTO dto = null;
        String sql = """
            SELECT b.board_id, b.title, b.content, b.writer_id, b.created_at,
                   u.username AS writer_name
            FROM board b
            JOIN users u ON b.writer_id = u.userid
            WHERE b.board_id = ?
        """;

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, id);
            ResultSet rs = ps.executeQuery();

            if (rs.next()) {
                dto = new BoardDTO();
                dto.setBoardId(rs.getInt("board_id"));
                dto.setTitle(rs.getString("title"));
                dto.setContent(rs.getString("content"));
                dto.setWriterId(rs.getInt("writer_id"));
                dto.setWriterName(rs.getString("writer_name")); // name 컬럼에서 가져온 작성자 이름
                dto.setCreatedAt(rs.getString("created_at"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return dto;
    }

    public int update(BoardDTO dto) {
        String sql = "UPDATE board SET title = ?, content = ? WHERE board_id = ?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, dto.getTitle());
            ps.setString(2, dto.getContent());
            ps.setInt(3, dto.getBoardId());
            return ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public int delete(int boardId) {
        String sql = "DELETE FROM board WHERE board_id = ?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, boardId);
            return ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }


}
