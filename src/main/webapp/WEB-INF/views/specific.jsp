<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="com.koreait.mvc2.dto.MemberDTO" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>

<%
    // 로그인 사용자 ID 추출
    MemberDTO user = (MemberDTO) session.getAttribute("user");
    String loginUserId = (user != null) ? user.getUserid() : null;
    request.setAttribute("loginUserId", loginUserId);
%>

<!DOCTYPE HTML>
<html>
<head>
    <title>${fn:escapeXml(post.title)} - Future Imperfect</title>
    <meta charset="utf-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1, user-scalable=no" />
    <link rel="stylesheet" href="assets/css/main.css" />
</head>
<body class="single is-preload">

<div id="wrapper">

    <!-- Header -->
    <header id="header">
        <h1><a href="list.board">Future Imperfect</a></h1>
    </header>

    <!-- Main -->
    <div id="main">
        <article class="post">
            <header>
                <div class="title">
                    <h2>${fn:escapeXml(post.title)}</h2>
                    <p>${fn:substring(post.content, 0, 40)}...</p>
                </div>
                <div class="meta">
                    <time class="published">${post.regdate}</time>
                    <a href="#" class="author">
                        <span class="name">${post.user_id}</span>
                        <img src="images/avatar.jpg" alt="avatar" />
                    </a>
                </div>
            </header>
            <%
                // 이미지 번호를 1~12 사이에서 랜덤하게 고르기
                int random = (int) (Math.random() * 7) + 1;
                String imagePath = "images/pic" + String.format("%02d", random) + ".jpg"; // pic01, pic02...
            %>

            <span class="image featured"><img src="<%= imagePath %>" alt="대표 이미지" /></span>

            <!-- 줄바꿈 반영된 본문 출력 -->
            <p><c:out value="${convertedContent}" escapeXml="false"/></p>


            <footer>
                <ul class="stats">
                    <li>조회수: ${post.view_count}</li>
                    <li>작성자: ${post.user_id}</li>
                </ul>

                <!-- 로그인 사용자와 작성자가 일치할 때만 버튼 출력 -->
                <c:if test="${loginUserId == post.user_id}"><jsp:useBean id="post" scope="request" type="com.koreait.mvc2.dto.BoardDTO"/>
                
                    <ul class="actions">
                        <li>
                            <form method="get" action="edit.board">
                                <input type="hidden" name="idx" value="${post.idx}" />
                                <button type="submit" class="button">수정</button>
                            </form>
                        </li>
                        <li>
                            <form method="post" action="remove.board" onsubmit="return confirm('정말 삭제하시겠습니까?')">
                                <input type="hidden" name="idx" value="${post.idx}" />
                                <button type="submit" class="button">삭제</button>
                            </form>
                        </li>
                    </ul>
                </c:if>
            </footer>
        </article>
    </div>

    <!-- Footer -->
    <section id="footer">
        <ul class="icons">
            <li><a href="#" class="icon brands fa-twitter"><span class="label">Twitter</span></a></li>
            <li><a href="#" class="icon brands fa-facebook-f"><span class="label">Facebook</span></a></li>
            <li><a href="#" class="icon brands fa-instagram"><span class="label">Instagram</span></a></li>
            <li><a href="#" class="icon solid fa-rss"><span class="label">RSS</span></a></li>
            <li><a href="#" class="icon solid fa-envelope"><span class="label">Email</span></a></li>
        </ul>
        <p class="copyright">
            &copy; Untitled. Design: <a href="http://html5up.net">HTML5 UP</a>. Images: <a href="http://unsplash.com">Unsplash</a>.
        </p>
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
