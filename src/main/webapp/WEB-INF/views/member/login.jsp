<%@ page contentType="text/html;charset=utf-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.net.URLDecoder" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login</title>
    <link rel="stylesheet" href="/css/member/login.css">
</head>
<body>
<form action="<c:url value='/member/login'/>" method="post" ><%--onsubmit="return formCheck(this);"--%>
    <h3 id="title">로그인</h3>
<%--    <div id="msg">
        <c:if test="${not empty param.msg}">
            <i class="fa fa-exclamation-circle"> ${URLDecoder.decode(param.msg)}</i>
        </c:if>
    </div>--%>
    <input type="text" name="id" placeholder="아이디 입력" maxlength="10" value="${cookie.id.value}"autofocus>
    <input type="password" name="pwd" placeholder="비밀번호">

    <c:if test="${param.result==0}">
        <div class="login_warn">사용자 ID 또는 PASSWORD를 잘못 입력하였습니다.</div>
    </c:if>

    <button>로그인</button>
    <div>
        <label><input type="checkbox" name="rememberId"  ${empty cookie.id.value ? "":"checked"}> 아이디 기억</label> |
        <a href="">비밀번호 찾기</a> |
        <a href="/member/join">회원가입</a>
    </div>
    <script>
/*        function formCheck(frm) {
            let msg ='';

            if(frm.id.value.length==0) {
                setMessage('id를 입력해주세요.', frm.id);
                return false;
            }

            if(frm.pwd.value.length==0) {
                setMessage('password를 입력해주세요.', frm.pwd);
                return false;
            }
            return true;
        }*/

        function setMessage(msg, element){
            document.getElementById("msg").innerHTML = ` ${'${msg}'}`;

            if(element) {
                element.select();
            }
        }
    </script>
</form>
</body>
</html>