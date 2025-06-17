package com.koreait.mvc2.dao;

import com.koreait.mvc2.dto.BoardDTO;
import com.koreait.mvc2.util.DBUtil;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class BoardDAO {
    public boolean insertPost(BoardDTO board){
        String sql = """
                    insert into board (title, content, user_id) values(?, ?, ?)
                """;
        try(Connection conn = DBUtil.getConnection();
            PreparedStatement pstmt = conn.prepareStatement(sql)){
            pstmt.setString(1, board.getTitle());
            pstmt.setString(2, board.getContent());
            pstmt.setString(3, board.getUser_id());
            return pstmt.executeUpdate() == 1;
        }catch (Exception e){
            e.printStackTrace();
            return false;
        }
    }

    public BoardDTO selectByIdx(int idx) {
        BoardDTO dto = null;
        String sql = "SELECT * FROM board WHERE idx = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, idx);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                dto = new BoardDTO();
                dto.setIdx(rs.getInt("idx"));
                dto.setTitle(rs.getString("title"));
                dto.setContent(rs.getString("content"));
                dto.setUser_id(rs.getString("user_id"));
                dto.setRegdate(rs.getString("regdate"));
                dto.setView_count(rs.getInt("view_count"));
            }

        } catch (Exception e) {
            e.printStackTrace();
        }
        return dto;
    }

    public void updatePost(BoardDTO dto) {
        String sql = "UPDATE board SET title=?, content=? WHERE idx=?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, dto.getTitle());
            pstmt.setString(2, dto.getContent());
            pstmt.setInt(3, dto.getIdx());
            pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    public boolean remove(int idx) {
        String sql = "DELETE FROM board WHERE idx = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, idx);
            return pstmt.executeUpdate() == 1;
        } catch (Exception e) {
            e.printStackTrace();
            return false;
        }
    }

    public List<BoardDTO> selectByPage(int start, int pageSize) {
        String sql = "SELECT * FROM board ORDER BY regdate DESC LIMIT ?, ?";
        List<BoardDTO> list = new ArrayList<>();
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, start);
            pstmt.setInt(2, pageSize);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                BoardDTO dto = new BoardDTO();
                dto.setIdx(rs.getInt("idx"));
                dto.setTitle(rs.getString("title"));
                dto.setContent(rs.getString("content"));
                dto.setUser_id(rs.getString("user_id"));
                dto.setRegdate(rs.getString("regdate"));
                dto.setView_count(rs.getInt("view_count"));
                list.add(dto);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }


    public int countAll() {
        String sql = "SELECT COUNT(*) FROM board";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public void increaseViewCount(int idx) {
        String sql = "UPDATE board SET view_count = view_count + 1 WHERE idx = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, idx);
            pstmt.executeUpdate();
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    // 사용자 아이디 기준으로 게시글 목록 페이징 조회
    public List<BoardDTO> selectByUserIdWithPaging(String userId, int start, int pageSize) {
        String sql = "SELECT * FROM board WHERE user_id = ? ORDER BY regdate DESC LIMIT ?, ?";
        List<BoardDTO> list = new ArrayList<>();
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, userId);
            pstmt.setInt(2, start);
            pstmt.setInt(3, pageSize);
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                BoardDTO dto = new BoardDTO();
                dto.setIdx(rs.getInt("idx"));
                dto.setTitle(rs.getString("title"));
                dto.setContent(rs.getString("content"));
                dto.setUser_id(rs.getString("user_id"));
                dto.setRegdate(rs.getString("regdate"));
                dto.setView_count(rs.getInt("view_count"));
                list.add(dto);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return list;
    }

    // 사용자 아이디 기준 게시글 수 세기 (페이징용)
    public int countByUserId(String userId) {
        String sql = "SELECT COUNT(*) FROM board WHERE user_id = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, userId);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public List<BoardDTO> selectPopularPostsByPage(int start, int pageSize) {
        String sql = "SELECT * FROM board ORDER BY view_count DESC LIMIT ?, ?";
        List<BoardDTO> list = new ArrayList<>();
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, start);
            pstmt.setInt(2, pageSize);
            ResultSet rs = pstmt.executeQuery();

            while (rs.next()) {
                BoardDTO dto = new BoardDTO();
                dto.setIdx(rs.getInt("idx"));
                dto.setTitle(rs.getString("title"));
                dto.setContent(rs.getString("content"));
                dto.setUser_id(rs.getString("user_id"));
                dto.setRegdate(rs.getString("regdate"));
                dto.setView_count(rs.getInt("view_count"));
                list.add(dto);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public int countPopularPosts() {
        String sql = "SELECT COUNT(*) FROM board ORDER BY view_count DESC LIMIT 9"; // 이렇게 하면 안 됨
        // LIMIT과 COUNT는 함께 안 되므로, 서브쿼리 사용
        String sql2 = "SELECT COUNT(*) FROM (SELECT * FROM board ORDER BY view_count DESC LIMIT 9) AS temp";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql2);
             ResultSet rs = pstmt.executeQuery()) {
            if (rs.next()) {
                return rs.getInt(1);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return 0;
    }

    public List<BoardDTO> selectPopularPosts() {
        String sql = "SELECT * FROM board ORDER BY view_count DESC LIMIT 5";
        List<BoardDTO> list = new ArrayList<>();
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                BoardDTO dto = new BoardDTO();
                dto.setIdx(rs.getInt("idx"));
                dto.setTitle(rs.getString("title"));
                dto.setRegdate(rs.getString("regdate"));
                dto.setView_count(rs.getInt("view_count"));
                dto.setUser_id(rs.getString("user_id"));
                list.add(dto);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public List<BoardDTO> selectNoticePosts() {
        String sql = "SELECT * FROM notice ORDER BY regdate DESC";
        List<BoardDTO> list = new ArrayList<>();
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql);
             ResultSet rs = pstmt.executeQuery()) {
            while (rs.next()) {
                BoardDTO dto = new BoardDTO();
                dto.setIdx(rs.getInt("idx"));
                dto.setTitle(rs.getString("title"));
                dto.setContent(rs.getString("content"));
                dto.setUser_id(rs.getString("user_id"));
                dto.setRegdate(rs.getString("regdate"));
                dto.setView_count(rs.getInt("view_count"));
                list.add(dto);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

    public BoardDTO selectOneNotice(int idx) {
        String sql = "SELECT * FROM notice WHERE idx = ?";
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setInt(1, idx);
            ResultSet rs = pstmt.executeQuery();
            if (rs.next()) {
                BoardDTO dto = new BoardDTO();
                dto.setIdx(rs.getInt("idx"));
                dto.setTitle(rs.getString("title"));
                dto.setContent(rs.getString("content"));
                dto.setUser_id(rs.getString("user_id"));
                dto.setRegdate(rs.getString("regdate"));
                dto.setView_count(rs.getInt("view_count"));
                return dto;
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return null;
    }

    public List<BoardDTO> searchByContent(String keyword) {
        String sql = "SELECT * FROM board WHERE content LIKE ? ORDER BY regdate DESC";
        List<BoardDTO> list = new ArrayList<>();
        try (Connection conn = DBUtil.getConnection();
             PreparedStatement pstmt = conn.prepareStatement(sql)) {
            pstmt.setString(1, "%" + keyword + "%");
            ResultSet rs = pstmt.executeQuery();
            while (rs.next()) {
                BoardDTO dto = new BoardDTO();
                dto.setIdx(rs.getInt("idx"));
                dto.setTitle(rs.getString("title"));
                dto.setContent(rs.getString("content"));
                dto.setUser_id(rs.getString("user_id"));
                dto.setRegdate(rs.getString("regdate"));
                dto.setView_count(rs.getInt("view_count"));
                list.add(dto);
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return list;
    }

}
