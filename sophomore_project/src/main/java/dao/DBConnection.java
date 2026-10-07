package dao;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

public class DBConnection {

    private static final String URL =
            "jdbc:oracle:thin:@localhost:1521:xe";
    
    
    // 자신의 오라클 아이디, 비밀번호로 바꾸기
    private static final String USER =
            "";

    private static final String PASSWORD =
            "";

    static {
        try {
            Class.forName("oracle.jdbc.OracleDriver");
            System.out.println("Oracle JDBC Driver 로드 성공");
        } catch (ClassNotFoundException e) {
            System.out.println("Oracle JDBC Driver 로드 실패");
            e.printStackTrace();
        }
    }

    public static Connection getConnection() throws SQLException {
        return DriverManager.getConnection(
                URL,
                USER,
                PASSWORD
        );
    }
}
