<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>

    <meta charset="UTF-8">
    <title>Welcome BookingSite</title>
    <script src="https://kit.fontawesome.com/92d2245491.js" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="/resources/css/menu.css" type="text/css">
</head>
<body>
<div class="nav_wrapper">
    <nav>
        <div class="content">

            <div class="logo">
                <a href="/main">
                    <img alt="brand" src="/img/logo1.png"/>
                </a>
            </div>
            <ul class="mainMenu">
                <c:if test="${memberDto.id==null}">
                    <li><a href="/member/login" >로그인</a></li>
                </c:if>
                <c:if test="${memberDto.id!=null}">
                    <c:if test="${memberDto.master_admin==0}">
                        <li>${memberDto.name} 회원
                            <ul class="subMenu">
                                <li><a href="/user/bookingList">예약현황</a></li>
                                <li><a href="/user/likeList">찜리스트</a></li>
                                <li><a href="/member/logout">로그아웃</a></li>
                            </ul>
                        </li>
                    </c:if>
                </c:if>
            </ul>
        </div>
    </nav>
</div>
</body>

</html>