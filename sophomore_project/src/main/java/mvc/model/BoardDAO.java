package mvc.model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import dao.DBConnection;

public class BoardDAO {

    private static final BoardDAO instance = new BoardDAO();

    private BoardDAO() {
    }

    public static BoardDAO getInstance() {
        return instance;
    }

    // =========================================================
    // 게시글 목록
    // =========================================================
    public List<BoardDTO> getBoardList(
            int page,
            int pageSize,
            String searchType,
            String keyword) {

        List<BoardDTO> list = new ArrayList<>();

        int startRow = (page - 1) * pageSize + 1;
        int endRow = page * pageSize;

        StringBuilder where = new StringBuilder();
        List<String> params = new ArrayList<>();

        if (keyword != null && !keyword.trim().isEmpty()) {

            keyword = keyword.trim();

            if ("subject".equals(searchType)) {

                where.append(
                    " WHERE UPPER(subject) LIKE UPPER(?) "
                );

                params.add("%" + keyword + "%");

            } else if ("content".equals(searchType)) {

                where.append(
                    " WHERE UPPER(content) LIKE UPPER(?) "
                );

                params.add("%" + keyword + "%");

            } else if ("name".equals(searchType)) {

                where.append(
                    " WHERE UPPER(name) LIKE UPPER(?) "
                );

                params.add("%" + keyword + "%");

            } else {

                where.append(
                    " WHERE UPPER(subject) LIKE UPPER(?) "
                    + " OR UPPER(content) LIKE UPPER(?) "
                );

                params.add("%" + keyword + "%");
                params.add("%" + keyword + "%");
            }
        }

        String sql =
            "SELECT num, id, name, subject, content, hit, ip, "
            + "regist_day, update_day "
            + "FROM ( "
            + "    SELECT b.*, "
            + "    ROW_NUMBER() OVER (ORDER BY num DESC) rn "
            + "    FROM board_illya b "
            + where
            + ") "
            + "WHERE rn BETWEEN ? AND ? "
            + "ORDER BY num DESC";

        try (
            Connection conn = DBConnection.getConnection();
            PreparedStatement pstmt =
                conn.prepareStatement(sql)
        ) {

            int index = 1;

            for (String param : params) {
                pstmt.setString(index++, param);
            }

            pstmt.setInt(index++, startRow);
            pstmt.setInt(index, endRow);

            try (ResultSet rs = pstmt.executeQuery()) {

                while (rs.next()) {

                    BoardDTO board = new BoardDTO();

                    board.setNum(rs.getInt("num"));
                    board.setId(rs.getString("id"));
                    board.setName(rs.getString("name"));
                    board.setSubject(rs.getString("subject"));
                    board.setContent(rs.getString("content"));
                    board.setHit(rs.getInt("hit"));
                    board.setIp(rs.getString("ip"));
                    board.setRegist_day(rs.getString("regist_day"));
                    board.setUpdate_day(rs.getString("update_day"));

                    list.add(board);
                }
            }

        } catch (Exception e) {

            e.printStackTrace();

            throw new RuntimeException(
                "게시글 목록 조회 중 오류가 발생했습니다.",
                e
            );
        }

        return list;
    }

    // =========================================================
    // 전체 게시글 수
    // =========================================================
    public int getBoardCount(
            String searchType,
            String keyword) {

        StringBuilder where = new StringBuilder();
        List<String> params = new ArrayList<>();

        if (keyword != null && !keyword.trim().isEmpty()) {

            keyword = keyword.trim();

            if ("subject".equals(searchType)) {

                where.append(
                    " WHERE UPPER(subject) LIKE UPPER(?) "
                );

                params.add("%" + keyword + "%");

            } else if ("content".equals(searchType)) {

                where.append(
                    " WHERE UPPER(content) LIKE UPPER(?) "
                );

                params.add("%" + keyword + "%");

            } else if ("name".equals(searchType)) {

                where.append(
                    " WHERE UPPER(name) LIKE UPPER(?) "
                );

                params.add("%" + keyword + "%");

            } else {

                where.append(
                    " WHERE UPPER(subject) LIKE UPPER(?) "
                    + " OR UPPER(content) LIKE UPPER(?) "
                );

                params.add("%" + keyword + "%");
                params.add("%" + keyword + "%");
            }
        }

        String sql =
            "SELECT COUNT(*) "
            + "FROM board_illya "
            + where;

        try (
            Connection conn = DBConnection.getConnection();
            PreparedStatement pstmt =
                conn.prepareStatement(sql)
        ) {

            for (int i = 0; i < params.size(); i++) {
                pstmt.setString(i + 1, params.get(i));
            }

            try (ResultSet rs = pstmt.executeQuery()) {

                if (rs.next()) {
                    return rs.getInt(1);
                }
            }

        } catch (Exception e) {

            e.printStackTrace();

            throw new RuntimeException(
                "게시글 수 조회 중 오류가 발생했습니다.",
                e
            );
        }

        return 0;
    }

    // =========================================================
    // 게시글 1개 조회
    // =========================================================
    public BoardDTO getBoard(int num) {

        String sql =
            "SELECT num, id, name, subject, content, hit, ip, "
            + "regist_day, update_day "
            + "FROM board_illya "
            + "WHERE num = ?";

        try (
            Connection conn = DBConnection.getConnection();
            PreparedStatement pstmt =
                conn.prepareStatement(sql)
        ) {

            pstmt.setInt(1, num);

            try (ResultSet rs = pstmt.executeQuery()) {

                if (rs.next()) {

                    BoardDTO board = new BoardDTO();

                    board.setNum(rs.getInt("num"));
                    board.setId(rs.getString("id"));
                    board.setName(rs.getString("name"));
                    board.setSubject(rs.getString("subject"));
                    board.setContent(rs.getString("content"));
                    board.setHit(rs.getInt("hit"));
                    board.setIp(rs.getString("ip"));
                    board.setRegist_day(rs.getString("regist_day"));
                    board.setUpdate_day(rs.getString("update_day"));

                    return board;
                }
            }

        } catch (Exception e) {

            e.printStackTrace();

            throw new RuntimeException(
                "게시글 조회 중 오류가 발생했습니다.",
                e
            );
        }

        return null;
    }

    // =========================================================
    // 조회수 증가
    // =========================================================
    public boolean increaseHit(int num) {

        String sql =
            "UPDATE board_illya "
            + "SET hit = NVL(hit, 0) + 1 "
            + "WHERE num = ?";

        try (
            Connection conn = DBConnection.getConnection();
            PreparedStatement pstmt =
                conn.prepareStatement(sql)
        ) {

            pstmt.setInt(1, num);

            return pstmt.executeUpdate() == 1;

        } catch (Exception e) {

            e.printStackTrace();

            throw new RuntimeException(
                "조회수 증가 중 오류가 발생했습니다.",
                e
            );
        }
    }

    // =========================================================
    // 게시글 작성
    // =========================================================
    public boolean insertBoard(BoardDTO board) {

        String sql =
            "INSERT INTO board_illya "
            + "(num, id, name, subject, content, hit, ip, "
            + "regist_day, update_day) "
            + "VALUES "
            + "(board_illya_seq.NEXTVAL, ?, ?, ?, ?, 0, ?, "
            + "SYSDATE, SYSDATE)";

        try (
            Connection conn = DBConnection.getConnection();
            PreparedStatement pstmt =
                conn.prepareStatement(sql)
        ) {

            pstmt.setString(1, board.getId());
            pstmt.setString(2, board.getName());
            pstmt.setString(3, board.getSubject());
            pstmt.setString(4, board.getContent());
            pstmt.setString(5, board.getIp());

            return pstmt.executeUpdate() == 1;

        } catch (Exception e) {

            e.printStackTrace();

            throw new RuntimeException(
                "게시글 등록 중 오류가 발생했습니다.",
                e
            );
        }
    }

    // =========================================================
    // 게시글 수정
    // =========================================================
    public boolean updateBoard(BoardDTO board) {

        String sql =
            "UPDATE board_illya "
            + "SET subject = ?, "
            + "content = ?, "
            + "update_day = SYSDATE "
            + "WHERE num = ?";

        try (
            Connection conn = DBConnection.getConnection();
            PreparedStatement pstmt =
                conn.prepareStatement(sql)
        ) {

            pstmt.setString(1, board.getSubject());
            pstmt.setString(2, board.getContent());
            pstmt.setInt(3, board.getNum());

            return pstmt.executeUpdate() == 1;

        } catch (Exception e) {

            e.printStackTrace();

            throw new RuntimeException(
                "게시글 수정 중 오류가 발생했습니다.",
                e
            );
        }
    }

    // =========================================================
    // 게시글 삭제
    // =========================================================
    public boolean deleteBoard(int num) {

        String sql =
            "DELETE FROM board_illya "
            + "WHERE num = ?";

        try (
            Connection conn = DBConnection.getConnection();
            PreparedStatement pstmt =
                conn.prepareStatement(sql)
        ) {

            pstmt.setInt(1, num);

            return pstmt.executeUpdate() == 1;

        } catch (Exception e) {

            e.printStackTrace();

            throw new RuntimeException(
                "게시글 삭제 중 오류가 발생했습니다.",
                e
            );
        }
    }
}