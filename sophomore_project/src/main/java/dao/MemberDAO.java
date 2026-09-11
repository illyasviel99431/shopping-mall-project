package dao;

import dto.Member;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class MemberDAO {


    // =====================================================
    // 로그인
    // =====================================================

    public Member login(String id, String password) {

        String sql =
                "SELECT id, password, name, gender, birth, " +
                "mail, phone, address, role " +
                "FROM member_illya " +
                "WHERE id = ? AND password = ?";

        try (
                Connection conn = DBConnection.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql)
        ) {

            pstmt.setString(1, id);
            pstmt.setString(2, password);

            try (ResultSet rs = pstmt.executeQuery()) {

                if (rs.next()) {

                    Member member = new Member();

                    member.setId(rs.getString("id"));
                    member.setPassword(rs.getString("password"));
                    member.setName(rs.getString("name"));
                    member.setGender(rs.getString("gender"));
                    member.setBirth(rs.getString("birth"));
                    member.setEmail(rs.getString("mail"));
                    member.setPhone(rs.getString("phone"));
                    member.setAddress(rs.getString("address"));
                    member.setRole(rs.getString("role"));

                    return member;
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }


    // =====================================================
    // ID로 회원 정보 가져오기
    // =====================================================

    public Member getMemberById(String id) {

        String sql =
                "SELECT id, password, name, gender, birth, " +
                "mail, phone, address, role " +
                "FROM member_illya " +
                "WHERE id = ?";

        try (
                Connection conn = DBConnection.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql)
        ) {

            pstmt.setString(1, id);

            try (ResultSet rs = pstmt.executeQuery()) {

                if (rs.next()) {

                    Member member = new Member();

                    member.setId(rs.getString("id"));
                    member.setPassword(rs.getString("password"));
                    member.setName(rs.getString("name"));
                    member.setGender(rs.getString("gender"));
                    member.setBirth(rs.getString("birth"));
                    member.setEmail(rs.getString("mail"));
                    member.setPhone(rs.getString("phone"));
                    member.setAddress(rs.getString("address"));
                    member.setRole(rs.getString("role"));

                    return member;
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return null;
    }


    // =====================================================
    // 회원가입
    // =====================================================

    public boolean insertMember(Member member) {

        String sql =
                "INSERT INTO member_illya " +
                "(id, password, name, gender, birth, mail, " +
                "phone, address, regist_day, mem_num, " +
                "logtime, updatetime, role) " +
                "VALUES (?, ?, ?, ?, ?, ?, ?, ?, " +
                "TO_CHAR(SYSDATE, 'YYYY-MM-DD HH24:MI:SS'), " +
                "member_seq.NEXTVAL, SYSDATE, SYSDATE, 'USER')";

        try (
                Connection conn = DBConnection.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql)
        ) {

            pstmt.setString(1, member.getId());
            pstmt.setString(2, member.getPassword());
            pstmt.setString(3, member.getName());
            pstmt.setString(4, member.getGender());
            pstmt.setString(5, member.getBirth());
            pstmt.setString(6, member.getEmail());
            pstmt.setString(7, member.getPhone());
            pstmt.setString(8, member.getAddress());

            int result = pstmt.executeUpdate();

            return result == 1;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }


    // =====================================================
    // 회원정보 수정
    // =====================================================

    public boolean updateMember(Member member) {

        String sql =
                "UPDATE member_illya SET " +
                "password = ?, " +
                "name = ?, " +
                "gender = ?, " +
                "birth = ?, " +
                "mail = ?, " +
                "phone = ?, " +
                "address = ?, " +
                "updatetime = SYSDATE " +
                "WHERE id = ?";

        try (
                Connection conn = DBConnection.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql)
        ) {

            pstmt.setString(1, member.getPassword());
            pstmt.setString(2, member.getName());
            pstmt.setString(3, member.getGender());
            pstmt.setString(4, member.getBirth());
            pstmt.setString(5, member.getEmail());
            pstmt.setString(6, member.getPhone());
            pstmt.setString(7, member.getAddress());
            pstmt.setString(8, member.getId());

            return pstmt.executeUpdate() == 1;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }


    // =====================================================
    // 회원 삭제
    // =====================================================

    public boolean deleteMember(String id, String password) {

        String sql =
                "DELETE FROM member_illya " +
                "WHERE id = ? AND password = ?";

        try (
                Connection conn = DBConnection.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql)
        ) {

            pstmt.setString(1, id);
            pstmt.setString(2, password);

            return pstmt.executeUpdate() == 1;

        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }


    // =====================================================
    // ID 중복 검사
    // =====================================================

    public boolean existsId(String id) {

        String sql =
                "SELECT COUNT(*) " +
                "FROM member_illya " +
                "WHERE id = ?";

        try (
                Connection conn = DBConnection.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql)
        ) {

            pstmt.setString(1, id);

            try (ResultSet rs = pstmt.executeQuery()) {

                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }


    // =====================================================
    // 이메일 중복 검사
    // =====================================================

    public boolean existsEmail(String email) {

        String sql =
                "SELECT COUNT(*) " +
                "FROM member_illya " +
                "WHERE mail = ?";

        try (
                Connection conn = DBConnection.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql)
        ) {

            pstmt.setString(1, email);

            try (ResultSet rs = pstmt.executeQuery()) {

                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }


    // =====================================================
    // 이메일 중복 검사
    // 자기 자신은 제외
    // =====================================================

    public boolean existsEmailExcept(String email, String id) {

        String sql =
                "SELECT COUNT(*) " +
                "FROM member_illya " +
                "WHERE mail = ? " +
                "AND id <> ?";

        try (
                Connection conn = DBConnection.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql)
        ) {

            pstmt.setString(1, email);
            pstmt.setString(2, id);

            try (ResultSet rs = pstmt.executeQuery()) {

                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }


    // =====================================================
    // 전화번호 중복 검사
    // =====================================================

    public boolean existsPhone(String phone) {

        String sql =
                "SELECT COUNT(*) " +
                "FROM member_illya " +
                "WHERE phone = ?";

        try (
                Connection conn = DBConnection.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql)
        ) {

            pstmt.setString(1, phone);

            try (ResultSet rs = pstmt.executeQuery()) {

                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }


    // =====================================================
    // 전화번호 중복 검사
    // 자기 자신은 제외
    // =====================================================

    public boolean existsPhoneExcept(String phone, String id) {

        String sql =
                "SELECT COUNT(*) " +
                "FROM member_illya " +
                "WHERE phone = ? " +
                "AND id <> ?";

        try (
                Connection conn = DBConnection.getConnection();
                PreparedStatement pstmt = conn.prepareStatement(sql)
        ) {

            pstmt.setString(1, phone);
            pstmt.setString(2, id);

            try (ResultSet rs = pstmt.executeQuery()) {

                if (rs.next()) {
                    return rs.getInt(1) > 0;
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
        }

        return false;
    }
}