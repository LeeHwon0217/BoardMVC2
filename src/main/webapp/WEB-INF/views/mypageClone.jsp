<%--
  Created by IntelliJ IDEA.
  User: 훤
  Date: 2025-06-14
  Time: 오후 8:23
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
  com.koreait.mvc2.dto.MemberDTO user = (com.koreait.mvc2.dto.MemberDTO) session.getAttribute("user");
%>
<html>
<head>
  <title>회원정보 수정</title>
  <link rel="stylesheet" href="assets/css/loginSignin.css" />
  <link rel="stylesheet" href="assets/css/header.css"/>
</head>
<body>
<%--<%@ include file="header.jsp" %>--%>

<div class="container">
  <!-- Sign Up -->
  <div class="container__form container--login">
    <form method="post" action="modifyForm.member" class="form" id="form1">
      <h2 class="form__title">회원가입</h2>
      <input type="text" placeholder="아이디" class="input" name="userid" value="${user.userid}"/>
      <input type="password" placeholder="비밀번호" class="input" name="userpw" value="${user.userpw}"/>
      <input type="text" placeholder="이름" class="input" name="name" value="${user.name}"/>
      <input type="text" placeholder="휴대폰" class="input" name="hp" value="${user.hp}"/>
      <input type="email" placeholder="이메일" class="input" name="email" value="${user.email}"/>
      <div class="ssn">
        <input type="text" name="ssn1" class="input_ssn" placeholder="주민등록번호"> - <input type="password" name="ssn2" class="input_ssn">
      </div>
      <input type="text" placeholder="우편번호" class="input" name="zipcode" value="${user.zipcode}"/>
      <input type="text" placeholder="주소" class="input" name="address1" value="${user.address1}"/>
      <input type="text" placeholder="상세주소" class="input" name="address2" value="${user.address2}"/>
      <input type="text" placeholder="참고항목" class="input" name="address3" value="${user.address3}"/>
      <button class="btn" type="submit">완료</button>
    </form>
  </div>

  <!-- Overlay -->
  <div class="container__overlay">
    <div class="overlay">
      <div class="overlay__panel overlay--left">
        <button class="btn" id="signIn">계정이 있으신가요?</button>
      </div>
      <div class="overlay__panel overlay--right">
        <button class="btn" id="signUp">처음이신가요?</button>
      </div>
    </div>
  </div>
</div>
<script src="assets/js/loginSignin.js"></script>
<script src="assets/js/header.js"></script>
</body>
</html>