<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/functions" prefix="fn" %>
<!DOCTYPE HTML>
<html>
<head>
    <title>게시글 작성</title>
    <meta charset="utf-8" />
    <link rel="stylesheet" href="assets/css/main.css" />
</head>
<body class="single is-preload">

<div id="wrapper">

    <header id="header">
        <h1><a href="list.board">게시판</a></h1>
    </header>

    <div id="main">
        <article class="post">
            <header>
                <div class="title">
                    <h2>${post != null ? "게시글 수정" : "게시글 작성"}</h2>
                    <p>${post != null ? "수정 후 완료 버튼을 눌러주세요" : "내용을 입력하고 등록 버튼을 눌러주세요"}</p>
                </div>
            </header>

            <form method="post" action="${post != null ? 'update.board' : 'writeForm.board'}">
                <div class="row gtr-uniform">

                    <c:if test="${post != null}">
                        <!-- 수정 시 게시글 idx를 넘겨줌 -->
                        <input type="hidden" name="idx" value="${post.idx}" />
                    </c:if>

                    <div class="col-12">
                        <input
                                type="text"
                                name="title"
                                placeholder="제목을 입력하세요"
                                required
                                value="${post != null ? fn:escapeXml(post.title) : ''}" />
                    </div>

                    <div class="col-12">
                        <textarea
                                name="content"
                                placeholder="내용을 입력하세요"
                                rows="10"
                                required>${post != null ? fn:escapeXml(post.content) : ''}</textarea>
                    </div>

                    <div class="col-12">
                        <ul class="actions">
                            <li><input type="submit" value="${post != null ? '수정 완료' : '작성 완료'}" class="primary" /></li>
                            <li><a href="list.board" class="button">취소</a></li>
                        </ul>
                    </div>
                </div>
            </form>
        </article>
    </div>

    <section id="footer">
        <p>&copy; 게시판 프로젝트. 디자인: HTML5 UP</p>
    </section>

</div>

<script src="assets/js/jquery.min.js"></script>
<script src="assets/js/main.js"></script>

</body>
</html>
