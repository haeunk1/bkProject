<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%@taglib prefix="fmt" uri="http://java.sun.com/jstl/fmt_rt" %>
<%@ page session="true"%>
<c:set var="loginId" value="${sessionScope.id}"/>
<c:set var="loginOutLink" value="${loginId=='' ? '/login/login' : '/login/logout'}"/>
<c:set var="loginOut" value="${loginId=='' ? 'Login' : 'ID='+=loginId}"/>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>여기다!</title>
    <link rel="stylesheet" href="/resources/css/menu.css" type="text/css">
    <link rel="stylesheet" href="/resources/css/user/bookingList.css" type="text/css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <script src="https://code.jquery.com/jquery-1.11.3.js"></script>

</head>
<body>
<script>
    let msg = "${msg}";
    if(msg=="DEL_OK") alert("예약이 삭제되었습니다.");
</script>
<div class="nav_wrapper">
    <nav>
        <div class="content">

            <div class="logo">
                <a href="/main">
                    <img alt="brand" src="/resources/img/logo1.png"/>
                </a>
            </div>
            <ul class="mainMenu">
                <c:if test="${memberDto.id==null}">
                    <li><a href="/member/login" >로그인</a></li>
                </c:if>
                <c:if test="${memberDto.id!=null}">
                    <c:if test="${memberDto.master_admin==1}">
                        <li>${memberDto.name} 관리자
                            <ul class="subMenu">
                                <li><a href="/post/list">공간 등록&수정</a></li>
                                <li><a href="/member/logout">로그아웃</a></li>
                            </ul>
                        </li>
                    </c:if>
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
<div style="text-align:center">
    <div class="board-container" style="margin-top: 50px">
        <h1>예약 관리</h1><br>
        <table>
            <tr>
                <th class="title">제목</th>
                <th class="day">예약일자</th>
                <th class="time">시간</th>
                <th class="date">예약일</th>
                <th class="cost">비용</th>
            </tr>
            <c:forEach var="dto" items="${list}">
                <tr>
                    <td class="title"><a href="<c:url value="/user/bookingRead?no=${dto.no}"/>">${dto.title}</a></td>
                    <td class="day">${dto.year}년 ${dto.month}월 ${dto.day}일</td>
                    <td class="time">${dto.time}</td>
                    <td class="date">${dto.book_time}</td>
                    <td class="cost">${dto.totCost}</td>
                </tr>
            </c:forEach>
        </table>
        <br>
    </div>
</div>
</body>
</html>