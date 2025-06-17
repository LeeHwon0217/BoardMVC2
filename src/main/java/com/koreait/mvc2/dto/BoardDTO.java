package com.koreait.mvc2.dto;

/*
	idx int primary key auto_increment,
    title varchar(500) not null,
    content text not null,
    user_id varchar(20) not null,
    regdate datetime default now(),
    view_count int default 0
*/

public class BoardDTO {
    private int idx;
    private String title;
    private String content;
    private String user_id;
    private String regdate;
    private int view_count;

    public BoardDTO() {
    }

    public BoardDTO(int idx, String title, String content, String user_id, String regdate, int view_count) {
        this.idx = idx;
        this.title = title;
        this.content = content;
        this.user_id = user_id;
        this.regdate = regdate;
        this.view_count = view_count;
    }

    public int getIdx() {
        return idx;
    }

    public void setIdx(int idx) {
        this.idx = idx;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getUser_id() {
        return user_id;
    }

    public void setUser_id(String user_id) {
        this.user_id = user_id;
    }

    public String getRegdate() {
        return regdate;
    }

    public void setRegdate(String regdate) {
        this.regdate = regdate;
    }

    public int getView_count() {
        return view_count;
    }

    public void setView_count(int view_count) {
        this.view_count = view_count;
    }
}
