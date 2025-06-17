package com.koreait.mvc2.service;

import com.koreait.mvc2.dao.BoardDAO;
import com.koreait.mvc2.dao.MemberDAO;
import com.koreait.mvc2.dto.BoardDTO;
import com.koreait.mvc2.dto.MemberDTO;
import com.koreait.mvc2.util.DBUtil;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class BoardServiceImpl implements BoardService{

    private BoardDAO dao = new BoardDAO();

    @Override
    public void post(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        MemberDTO user = (MemberDTO) session.getAttribute("user");

        BoardDTO dto = new BoardDTO();
        dto.setTitle(req.getParameter("title"));
        dto.setContent(req.getParameter("content"));
        dto.setUser_id(user.getUserid());
        boolean success = dao.insertPost(dto);
        resp.sendRedirect(req.getContextPath() + "/");
    }

    @Override
    public void list(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int page = 1;
        if (req.getParameter("page") != null) {
            try {
                page = Integer.parseInt(req.getParameter("page"));
            } catch (NumberFormatException e) {
                page = 1;
            }
        }

        int pageSize = 4;
        int start = (page - 1) * pageSize;

        List<BoardDTO> boardList = dao.selectByPage(start, pageSize);
        int totalCount = dao.countAll();
        int totalPages = (int) Math.ceil(totalCount / (double) pageSize);

        req.setAttribute("boardList", boardList);
        req.setAttribute("currentPage", page);
        req.setAttribute("totalPages", totalPages);

        req.getRequestDispatcher("/index.jsp").forward(req, resp); // redirect ❌
    }




    @Override
    public void specific(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int idx = Integer.parseInt(req.getParameter("idx"));

        dao.increaseViewCount(idx); // 🔥 조회수 증가!
        BoardDTO post = dao.selectByIdx(idx); // 게시글 데이터 불러오기

        req.setAttribute("post", post);

        // 내용 줄바꿈 처리
        String content = post.getContent().replace("\r\n", "<br>");
        req.setAttribute("convertedContent", content);

        req.getRequestDispatcher("/WEB-INF/views/specific.jsp").forward(req, resp);
    }



    @Override
    public void update(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int idx = Integer.parseInt(req.getParameter("idx"));
        String title = req.getParameter("title");
        String content = req.getParameter("content");

        BoardDTO dto = new BoardDTO();
        dto.setIdx(idx);
        dto.setTitle(title);
        dto.setContent(content);

        new BoardDAO().updatePost(dto);
        resp.sendRedirect("specific.board?idx=" + idx);
    }


    @Override
    public void remove(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int idx = Integer.parseInt(req.getParameter("idx")); // 게시글 번호 받아오기

        boolean isDeleted = dao.remove(idx); // DAO에서 삭제 처리
        if (isDeleted) {
            resp.sendRedirect("list.board"); // 삭제 후 목록으로 이동
        } else {
            req.setAttribute("error", "삭제 실패");
            req.getRequestDispatcher("/WEB-INF/views/error.jsp").forward(req, resp);
        }
    }

    @Override
    public void myBoard(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        HttpSession session = req.getSession();
        MemberDTO user = (MemberDTO) session.getAttribute("user");

        // 로그인 체크
        if (user == null) {
            req.setAttribute("message", "로그인 후 이용해주세요!");
            req.setAttribute("redirectUrl", "loginSignin.member");
            req.getRequestDispatcher("/WEB-INF/views/alert.jsp").forward(req, resp);
            return;
        }

        int page = 1;
        if (req.getParameter("page") != null) {
            try {
                page = Integer.parseInt(req.getParameter("page"));
            } catch (NumberFormatException e) {
                page = 1;
            }
        }

        int pageSize = 4;
        int start = (page - 1) * pageSize;

        List<BoardDTO> myPosts = dao.selectByUserIdWithPaging(user.getUserid(), start, pageSize);
        int totalCount = dao.countByUserId(user.getUserid());
        int totalPages = (int) Math.ceil(totalCount / (double) pageSize);

        req.setAttribute("myList", myPosts);
        req.setAttribute("currentPage", page);
        req.setAttribute("totalPages", totalPages);

        req.getRequestDispatcher("/WEB-INF/views/myBoard.jsp").forward(req, resp);
    }

    @Override
    public void popular(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int page = 1;
        if (req.getParameter("page") != null) {
            try {
                page = Integer.parseInt(req.getParameter("page"));
            } catch (NumberFormatException e) {
                page = 1;
            }
        }

        int pageSize = 4;
        int start = (page - 1) * pageSize;

        List<BoardDTO> list = dao.selectPopularPostsByPage(start, pageSize);
        int totalCount = dao.countPopularPosts();
        int totalPages = (int) Math.ceil(totalCount / (double) pageSize);

        req.setAttribute("boardList", list);
        req.setAttribute("currentPage", page);
        req.setAttribute("totalPages", totalPages);

        req.getRequestDispatcher("/WEB-INF/views/popular.jsp").forward(req, resp);
    }

    @Override
    public void notice(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        List<BoardDTO> noticeList = dao.selectNoticePosts();
        req.setAttribute("boardList", noticeList);
        req.getRequestDispatcher("/WEB-INF/views/notice.jsp").forward(req, resp);
    }
    @Override
    public void noticeDetail(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        int idx = Integer.parseInt(req.getParameter("idx"));
        BoardDTO dto = dao.selectOneNotice(idx);
        req.setAttribute("post", dto);
        req.getRequestDispatcher("/WEB-INF/views/specificNotice.jsp").forward(req, resp);
    }
    @Override
    public void searchPosts(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String query = req.getParameter("query");
        List<BoardDTO> result = dao.searchByContent(query);
        req.setAttribute("boardList", result);
        req.getRequestDispatcher("/WEB-INF/views/searchResult.jsp").forward(req, resp);
    }








}
