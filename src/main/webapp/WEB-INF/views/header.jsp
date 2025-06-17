<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!-- Header -->
<header id="header">
    <h1><a href="index.jsp">소소로그</a></h1>
    <nav class="links">
        <ul>
            <li><a href="notice.board">공지사항</a></li>
            <li><a href="write.board">글쓰기</a></li>
            <li><a href="myboard.board">내 글 보기</a></li>
            <li><a href="popular.board">인기글</a></li>
        </ul>
    </nav>
    <nav class="main">
        <ul>
            <li class="search">
                <a class="fa-search" href="#search">Search</a>
                <form id="search" method="get" action="#">
                    <input type="text" name="query" placeholder="검색어 입력" />
                </form>
            </li>
            <li class="menu">
                <a class="fa-bars" href="#menu">Menu</a>
            </li>
        </ul>
    </nav>
</header>
