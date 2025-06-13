<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
    <title>Result</title>
</head>
<body>
<c:choose>
    <c:when test="${not empty success}">
        <c:choose>
            <c:when test="${success}">
                <h2>회원가입이 성공적으로 처리되었습니다!</h2>
                <p><a href="mypage.member">마이페이지</a></p>
            </c:when>
            <c:otherwise>
                <h2>회원가입 중 문제가 발생했습니다.</h2>
            </c:otherwise>
        </c:choose>
    </c:when>
    <c:when test="${not empty loginUser}">
        <h2>${loginUser.userid}(${loginUser.name})님, 로그인 성공!</h2>
        <p><a href="mypage.member">마이페이지</a> | <a href="logout.member">로그아웃</a></p>
    </c:when>
    <c:otherwise>
        <h2>로그인 실패</h2>
        <p>아이디 또는 비밀번호를 확인하세요 🤢🤢🤢</p>
    </c:otherwise>
</c:choose>
</body>
</html>