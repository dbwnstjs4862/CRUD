package Comment;

import java.sql.*;
import java.util.ArrayList;
import java.util.List;

public class CommentDAO {
    private Connection conn;

    public CommentDAO() {
        try {
            Class.forName("oracle.jdbc.driver.OracleDriver");
            conn = DriverManager.getConnection(
                "jdbc:oracle:thin:@localhost:1521:xe", "CRUD", "DURC"
            );
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // 댓글 저장
    public int insert(CommentDTO dto) {
        String sql = "INSERT INTO comments (comment_id, board_id, writer_id, content) " +
                     "VALUES (comments_seq.NEXTVAL, ?, ?, ?)";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, dto.getBoardId());
            ps.setInt(2, dto.getWriterId());
            ps.setString(3, dto.getContent());
            return ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    // 특정 게시글의 댓글 목록 조회
    public List<CommentDTO> getByBoardId(int boardId) {
        List<CommentDTO> list = new ArrayList<>();
        String sql = """
            SELECT c.comment_id, c.board_id, c.writer_id, c.content, c.created_at,
                   u.name AS writer_name
            FROM comments c
            JOIN users u ON c.writer_id = u.userid
            WHERE c.board_id = ?
            ORDER BY c.comment_id ASC
        """;

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, boardId);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                CommentDTO dto = new CommentDTO();
                dto.setCommentId(rs.getInt("comment_id"));
                dto.setBoardId(rs.getInt("board_id"));
                dto.setWriterId(rs.getInt("writer_id"));
                dto.setContent(rs.getString("content"));
                dto.setCreatedAt(rs.getString("created_at"));
                dto.setWriterName(rs.getString("writer_name"));
                list.add(dto);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public int update(int commentId, String content) {
        String sql = "UPDATE comments SET content = ? WHERE comment_id = ?";

        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setString(1, content);
            ps.setInt(2, commentId);
            return ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public int delete(int commentId) {
        String sql = "DELETE FROM comments WHERE comment_id = ?";
        try (PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, commentId);
            return ps.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }
}
