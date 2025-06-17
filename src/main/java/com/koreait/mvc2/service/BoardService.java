package com.koreait.mvc2.service;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

public interface BoardService {
    void post(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException;
    void list(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException;
    void specific(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException;
    void update(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException;
    void remove(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException;
    void myBoard(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException;
    void popular(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException;
    void notice(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException;
    void noticeDetail(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException;
    void searchPosts(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException;

}
