package com.koreait.mvc2.util;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.naming.NamingException;
import javax.sql.DataSource;
import java.sql.Connection;
import java.sql.SQLException;

public class DBUtil {
    private static DataSource ds;

    static {
        try{
            Context ctx = new InitialContext();
            Context env = (Context) ctx.lookup("java:comp/env");
            ds = (DataSource) env.lookup("jdbc/mydb"); // context.xml의 name
        }catch (NamingException e){
            e.printStackTrace();
        }
    }

    public static Connection getConnection() throws SQLException {
        return ds.getConnection();  // 커넥션 풀에서 하나를 꺼냄
    }

}