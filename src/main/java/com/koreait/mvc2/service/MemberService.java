package com.koreait.mvc2.service;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.rmi.server.ServerCloneException;

public interface MemberService {
    void join(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException;
    void login(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException;
    void logout(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException;
    void modify(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException;
    void delete(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException;
}
