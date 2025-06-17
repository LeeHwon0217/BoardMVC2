<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<%@ page import="java.util.*, com.koreait.mvc2.dao.BoardDAO, com.koreait.mvc2.dto.BoardDTO" %>


<!DOCTYPE HTML>
<!--
Future Imperfect by HTML5 UP
html5up.net | @ajlkn
Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
-->
<html>
<head>
    <title>팀 애플</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
    <link rel="stylesheet" href="assets/css/main.css" />
    <style>
        /* 데스크톱 모드 (너비 981px 이상)에서 햄버거 버튼과 메뉴 숨기기 */
        @media screen and (min-width: 981px) {
            .menu {
                display: none !important;
            }

            #menu {
                display: none !important;
            }
        }
    </style>


</head>
<body class="is-preload">

<!-- Wrapper -->
<div id="wrapper">

    <!-- Header -->
    <header id="header">
        <h1><a href="list.board">소소로그</a></h1>
        <nav class="links">
            <ul>
                <li><a href="notice.board">공지사항</a></li>
                <li><a href="write.board">글쓰기</a></li>
                <li><a href="myBoard.board">내 글 보기</a></li>
                <li><a href="popular.board">인기글</a></li>
                <c:choose>
                    <c:when test="${empty sessionScope.user}">
                        <li><a href="loginSignin.member">로그인</a></li>
                    </c:when>
                    <c:otherwise>
                        <li><a href="mypage.member">${sessionScope.user.name}님</a></li>
                        <li><a href="logout.member">로그아웃</a></li>
                    </c:otherwise>
                </c:choose>
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

    <!-- Menu -->
    <section id="menu">

        <!-- Search -->
        <section>
            <form class="search" method="get" action="search.board">
                <input type="text" name="query" placeholder="검색어 입력" />
            </form>
        </section>

        <!-- Links -->
        <section>
            <ul class="links">
                <li>
                    <a href="write.board">
                        <h3>글쓰기</h3>
                        <p>당신의 이야기를 자유롭게 기록해보세요</p>
                    </a>
                </li>
                <li>
                    <a href="myBoard.board">
                        <h3>내 글</h3>
                        <p>내가 작성한 게시글을 확인할 수 있어요</p>
                    </a>
                </li>
                <li>
                    <a href="popular.board">
                        <h3>인기글</h3>
                        <p>많이 본 게시물을 만나보세요</p>
                    </a>
                </li>
                <li>
                    <a href="notice.board">
                        <h3>공지사항</h3>
                        <p>중요한 안내와 업데이트를 확인하세요</p>
                    </a>
                </li>
            </ul>
        </section>

        <!-- 로그인/회원가입 -->
        <section>
            <ul class="actions stacked">
                <c:choose>
                    <c:when test="${empty sessionScope.user}">
                        <li><a href="loginSignin.member" class="button large fit">로그인</a></li>
                    </c:when>
                    <c:otherwise>
                        <li><a href="mypage.member" class="button large fit">${sessionScope.user.name}님</a></li>
                        <li><a href="logout.member" class="button large fit">로그아웃</a></li>
                    </c:otherwise>
                </c:choose>
            </ul>
        </section>

    </section>


    <!-- Main -->
    <div id="main">
        <h2>공지사항</h2>
        <c:forEach var="post" items="${boardList}">
            <%
                // 이미지 번호를 1~12 사이에서 랜덤하게 고르기
                int random = (int) (Math.random() * 12) + 1;
                String imagePath = "images/pic" + String.format("%02d", random) + ".jpg"; // pic01, pic02...
            %>
            <article class="post">
                <header>
                    <div class="title">
                        <h2>
                            <a href="specific.notice?idx=${post.idx}">
                                    ${fn:escapeXml(post.title)}
                            </a>
                        </h2>
                    </div>
                    <div class="meta">
                        <time class="published">${post.regdate}</time>
                        <span class="author">
                    <span class="name">${post.user_id}</span>
                </span>
                    </div>
                </header>
                <p style="margin-top: 10px;">
                        ${fn:length(post.content) > 120 ? fn:substring(post.content, 0, 120) : post.content}...
                </p>
                <footer>
                    <ul class="stats">
                        <li>조회수 ${post.view_count}</li>
                    </ul>
                </footer>
            </article>
        </c:forEach>




        <%
            Integer curPageAttr = (Integer) request.getAttribute("currentPage");
            Integer totalPagesAttr = (Integer) request.getAttribute("totalPages");

            int currentPage = (curPageAttr != null) ? curPageAttr : 1;
            int totalPages = (totalPagesAttr != null) ? totalPagesAttr : 1;

            int startPage = Math.max(1, currentPage - 2);
            int endPage = startPage + 4;
            if (endPage > totalPages) {
                endPage = totalPages;
                startPage = Math.max(1, endPage - 4);
            }

            request.setAttribute("startPage", startPage);
            request.setAttribute("endPage", endPage);
        %>


        <ul class="actions pagination">
            <!-- 이전 버튼 -->
            <c:choose>
                <c:when test="${currentPage > 1}">
                    <li><a href="list.board?page=${currentPage - 1}" class="button large previous">Previous Page</a></li>
                </c:when>
                <c:otherwise>
                    <li><span class="disabled button large previous">Previous Page</span></li>
                </c:otherwise>
            </c:choose>

            <!-- 숫자 페이지 목록 (최대 5개) -->
            <c:forEach var="i" begin="${startPage}" end="${endPage}">
                <li>
                    <a href="list.board?page=${i}"
                       class="button <c:if test='${i == currentPage}'>primary</c:if>">
                            ${i}
                    </a>
                </li>
            </c:forEach>

            <!-- 다음 버튼 -->
            <c:choose>
                <c:when test="${currentPage < totalPages}">
                    <li><a href="list.board?page=${currentPage + 1}" class="button large next">Next Page</a></li>
                </c:when>
                <c:otherwise>
                    <li><span class="disabled button large next">Next Page</span></li>
                </c:otherwise>
            </c:choose>
        </ul>

    </div>

    <!-- Sidebar -->
    <section id="sidebar">

        <!-- Intro -->
        <section id="intro">
            <a href="#" class="logo"><img src="images/logo.jpg" alt="" /></a>
            <header>
                <h2>소소로그</h2>
                <p>소소한 일상의 로그(log), 일기처럼 남기는 공간 <a href="http://html5up.net">HTML5 UP</a></p>
            </header>
        </section>

        <!-- Mini Posts -->
        <section>
            <div class="mini-posts">

                <!-- Mini Post -->
                <article class="mini-post">
                    <header>
                        <h3><a href="specific.board">작고 기분 좋은 일 하나</a></h3>
                        <time class="published" datetime="2025-06-20">jun 20, 2025</time>
                        <a href="#" class="author"><img src="images/avatar.jpg" alt="" /></a>
                    </header>
                    <a href="specific.board" class="image"><img src="images/pic04.jpg" alt="" /></a>
                </article>

                <!-- Mini Post -->
                <article class="mini-post">
                    <header>
                        <h3><a href="specific.board">오늘의 가장 잘한 선택</a></h3>
                        <time class="published" datetime="2020-06-20">June 20, 2025</time>
                        <a href="#" class="author"><img src="images/avatar.jpg" alt="" /></a>
                    </header>
                    <a href="specific.board" class="image"><img src="images/pic05.jpg" alt="" /></a>
                </article>

                <!-- Mini Post -->
                <article class="mini-post">
                    <header>
                        <h3><a href="specific.board">아무것도 안 하는 시간도 필요하다</a></h3>
                        <time class="published" datetime="2025-6-18">June 18, 2025</time>
                        <a href="#" class="author"><img src="images/avatar.jpg" alt="" /></a>
                    </header>
                    <a href="specific.board" class="image"><img src="images/pic06.jpg" alt="" /></a>
                </article>

                <!-- Mini Post -->
                <article class="mini-post">
                    <header>
                        <h3><a href="specific.board">밤이 되면 마음이 말이 많아진다</a></h3>
                        <time class="published" datetime="2025-06-17">June 17, 2025</time>
                        <a href="#" class="author"><img src="images/avatar.jpg" alt="" /></a>
                    </header>
                    <a href="specific.board" class="image"><img src="images/pic07.jpg" alt="" /></a>
                </article>

            </div>
        </section>


        <!-- Posts List -->
        <section>
            <ul class="posts">
                <li>
                    <article>
                        <header>
                            <h3><a href="notice.board">이 공간은 텍스트로 마음을 나누는 곳입니다</a></h3>
                            <time class="published" datetime="2025-06-07">June 06, 2025</time>
                        </header>
                        <a href="notice.board" class="image"><img src="images/pic08.jpg" alt="" /></a>
                    </article>
                </li>
                <li>
                    <article>
                        <header>
                            <h3><a href="notice.board">작성된 글은 수정 및 삭제가 가능합니다</a></h3>
                            <time class="published" datetime="2025-06-07">June 06, 2025</time>
                        </header>
                        <a href="notice.board" class="image"><img src="images/pic09.jpg" alt="" /></a>
                    </article>
                </li>
                <li>
                    <article>
                        <header>
                            <h3><a href="notice.board">이곳은 철저한 ‘익명’ 기반 플랫폼입니다</a></h3>
                            <time class="published" datetime="2025-06-07">June 06, 2025</time>
                        </header>
                        <a href="notice.board" class="image"><img src="images/pic10.jpg" alt="" /></a>
                    </article>
                </li>
                <li>
                    <article>
                        <header>
                            <h3><a href="notice.board">게시글 검색 기능 안내</a></h3>
                            <time class="published" datetime="2025-06-07">June 06, 2025</time>
                        </header>
                        <a href="notice.board" class="image"><img src="images/pic11.jpg" alt="" /></a>
                    </article>
                </li>
                <li>
                    <article>
                        <header>
                            <h3><a href="notice.board">부적절한 내용 작성 시 조치 안내</a></h3>
                            <time class="published" datetime="2025-06-07">June 06, 2025</time>
                        </header>
                        <a href="notice.board" class="image"><img src="images/pic12.jpg" alt="" /></a>
                    </article>
                </li>
            </ul>
        </section>

        <!-- About -->
        <section class="blurb">
            <h2>About</h2>
            <p>
                이곳은 당신의 하루를 조용히 담아낼 수 있는 작은 공간입니다.<br><br>
                우리는 특별하지 않아도 괜찮다고 생각합니다. 소소한 일상, 한 줄의 생각, 오늘 본 풍경, 혼잣말처럼 흘려보내는 말들이 사실은 가장 진솔하고 귀한 이야기들이니까요.<br><br>
                누군가에게는 평범한 하루가 누군가에겐 큰 위로가 될 수 있습니다.<br>
                누군가에겐 평범한 경험이 또 다른 누군가에겐 새로운 시작이 될 수도 있고요.<br><br>
                이 게시판은 그런 평범한 조각들을 모아 서로 나누고 공감하는 공간입니다.<br>
                우리는 서로를 잘 몰라도, 서로의 이야기를 듣고 마음을 나눌 수 있다고 믿습니다.<br><br>
                특별한 주제도, 복잡한 절차도 없습니다.<br>
                당신이 쓰는 글 한 줄이 곧 이 공간의 풍경이 됩니다.<br><br>
                바쁜 일상 속에서 잠시 멈춰 쉬어가고 싶을 때,<br>
                누군가에게 말 걸고 싶을 때,<br>
                혹은 그냥, 오늘 하루가 어땠는지 기록해두고 싶을 때,<br>
                언제든 편하게 찾아와 주세요.<br><br>
                이곳은 당신의 이야기를 기다리고 있습니다.
            </p>
            <ul class="actions">
                <li><a href="#" class="button">Learn More</a></li>
            </ul>
        </section>

        <!-- Footer -->
        <section id="footer">
            <ul class="icons">
                <li><a href="https://x.com/home?lang=ko" class="icon brands fa-twitter"><span class="label">Twitter</span></a></li>
                <li><a href="https://www.facebook.com/MetaKorea/?locale=ko_KR" class="icon brands fa-facebook-f"><span class="label">Facebook</span></a></li>
                <li><a href="https://www.instagram.com/" class="icon brands fa-instagram"><span class="label">Instagram</span></a></li>
                <li><a href="#" class="icon solid fa-rss"><span class="label">RSS</span></a></li>
                <li><a href="#" class="icon solid fa-envelope"><span class="label">Email</span></a></li>
            </ul>
            <p class="copyright">&copy; Untitled. Design: <a href="http://html5up.net">HTML5 UP</a>. Images: <a href="http://unsplash.com">Unsplash</a>.</p>
        </section>

    </section>

</div>

<!-- Scripts -->
<script src="assets/js/jquery.min.js"></script>
<script src="assets/js/browser.min.js"></script>
<script src="assets/js/breakpoints.min.js"></script>
<script src="assets/js/util.js"></script>
<script src="assets/js/main.js"></script>

</body>
</html>