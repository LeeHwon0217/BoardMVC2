<%--
  Created by IntelliJ IDEA.
  User: 훤
  Date: 2025-06-11
  Time: 오전 10:20
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>회원가입</title>
</head>
<body>
<h2>회원가입</h2>
<form method="post" action="joinForm.member">
    <p>아이디: <input type="text" name="userid"></p>
    <p>비밀번호: <input type="password" name="userpw"></p>
    <p>이름: <input type="text" name="name"></p>
    <p>휴대폰: <input type="text" name="hp"></p>
    <p>이메일: <input type="email" name="email"></p>
    <p>성별: <select name="gender">
        <option value="남자">남자</option>
        <option value="여자">여자</option>
    </select>
    <p>주민등록번호: <input type="text" name="ssn1"> - <input type="password" name="ssn2"></p>
    <p>우편번호: <input type="text" name="zipcode"></p>
    <p>주소: <input type="text" name="address1"></p>
    <p>상세주소: <input type="text" name="address2"></p>
    <p>참고항목: <input type="text" name="address3"></p>
    <p><button type="submit">완료</button></p>
</form>
</body>
</html>
