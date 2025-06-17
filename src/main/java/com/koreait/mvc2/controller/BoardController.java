package com.koreait.mvc2.controller;

import com.koreait.mvc2.dao.BoardDAO;
import com.koreait.mvc2.dto.BoardDTO;
import com.koreait.mvc2.service.BoardService;
import com.koreait.mvc2.service.BoardServiceImpl;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("*.board")
public class BoardController extends HttpServlet {
    private static final long serialVersionUID = 1L;
    private BoardService service = new BoardServiceImpl();

    public BoardController() {}

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doAction(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        doAction(req, resp);
    }

    protected void doAction(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.setCharacterEncoding("UTF-8");
        String uri = req.getRequestURI();
        String context = req.getContextPath();
        String command = uri.substring(context.length());

        switch (command) {
            case "/write.board":
                req.getRequestDispatcher("/WEB-INF/views/write.jsp").forward(req, resp);
                break;
            case "/writeForm.board":
                service.post(req, resp);
                break;
            case "/list.board":
            case "/":
                BoardDAO popularDao = new BoardDAO();
                List<BoardDTO> popularList = popularDao.selectPopularPosts();  // ★ 이 메서드는 DAO에 따로 구현돼 있어야 함
                req.setAttribute("popularList", popularList);
                service.list(req, resp);
                break;
            case "/specific.board":
                int idx = Integer.parseInt(req.getParameter("idx"));
                BoardDAO dao = new BoardDAO();

                // 🔥 조회수 증가 먼저
                dao.increaseViewCount(idx);

                // 이후에 글 가져오기
                BoardDTO post = dao.selectByIdx(idx);

                // 줄바꿈 및 특수문자 처리
                String content = post.getContent()
                        .replaceAll("&", "&amp;")
                        .replaceAll("<", "&lt;")
                        .replaceAll(">", "&gt;")
                        .replaceAll("\"", "&quot;")
                        .replaceAll("\n", "<br/>");

                req.setAttribute("post", post);
                req.setAttribute("convertedContent", content);
                req.getRequestDispatcher("/WEB-INF/views/specific.jsp").forward(req, resp);
                break;

            case "/edit.board":
                int editIdx = Integer.parseInt(req.getParameter("idx"));
                BoardDTO editPost = new BoardDAO().selectByIdx(editIdx);
                req.setAttribute("post", editPost);
                req.getRequestDispatcher("/WEB-INF/views/write.jsp").forward(req, resp);
                break;
            case "/remove.board":
                service.remove(req, resp);
                break;
            case "/update.board":
                service.update(req, resp);
                break;
            case "/myBoard.board":
                service.myBoard(req, resp);
                break;
            case "/popular.board":
                service.popular(req, resp);
                break;
            case "/notice.board":
                service.notice(req, resp);
                break;
            case "/specific.notice":
                service.noticeDetail(req, resp);
                break;
            case "/search.board":
                service.searchPosts(req, resp);
                break;

            default:
                resp.sendError(HttpServletResponse.SC_NOT_FOUND);

        }
    }
}
