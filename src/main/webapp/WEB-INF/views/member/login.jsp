<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.net.URLDecoder" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>여기다!</title>
    <link rel="stylesheet" href="/resources/css/member/login.css">
</head>
<body>
<form action="<c:url value='/member/login'/>" method="post" >
    <h3 id="title">로그인</h3>
    <input type="text" name="id" placeholder="아이디 입력" maxlength="10" value="${cookie.id.value}"autofocus>
    <input type="password" name="pwd" placeholder="비밀번호">
    <input  name="toURL" type = "hidden" value="${param.toURL}">
    <input  name="pno"  type = "hidden" value="${param.pno}">

    <c:if test="${param.result==0}">
        <div class="login_warn">사용자 ID 또는 PASSWORD를 잘못 입력하였습니다.</div>
    </c:if>

    <button>로그인</button>
    <div>
        <label><input type="checkbox" name="rememberId"  ${empty cookie.id.value ? "":"checked"}> 아이디 기억</label> |
        <a href="/member/join">회원가입</a>
    </div>
    <script>
        let msg = "${msg}";
        if(msg=="login") alert("로그인이 필요합니다.");
    </script>
</form>
</div>
</body>
</html>