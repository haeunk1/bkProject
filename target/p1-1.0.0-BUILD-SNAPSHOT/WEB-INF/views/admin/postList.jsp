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
    <title>postList</title>
    <link rel="stylesheet" href="/resources/css/menu.css" type="text/css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <script src="https://code.jquery.com/jquery-1.11.3.js"></script>
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: "Noto Sans KR", sans-serif;
        }
        a {
            text-decoration: none;
            color: black;
        }
        button,
        input {
            border: none;
            outline: none;
        }
        .board-container {
            width: 60%;
            height: 1200px;
            margin: 0 auto;
            /* border: 1px solid black; */
        }
        .search-option > option {
            text-align: center;
        }
        table {
            border-collapse: collapse;
            width: 100%;
            border-top: 2px solid rgb(39, 39, 39);
        }
        tr:nth-child(even) {
            background-color: #f0f0f070;
        }
        th,
        td {
            width:300px;
            text-align: center;
            padding: 10px 12px;
            border-bottom: 1px solid #ddd;
        }
        td {
            color: rgb(53, 53, 53);
        }
        .no      { width:150px;}
        .title   { width:50%;  }
        td.title   { text-align: left;  }
        td.writer  { text-align: left;  }
        td.viewcnt { text-align: right; }
        td.title:hover {
            text-decoration: underline;
        }
        .plus_btn{
            width: 100%;
            height: auto;
            padding-left:0;
            padding-top:10px;
            padding-bottom: 10px;

        }
        .plusBtn:before{
            font-family: "FontAwesome";content:"\f0fe";
            font-size:50px;
            color:black;
        }

    </style>
</head>
<body>
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

<div class="board-container">
    <div class="plus_btn">
        <a href="/post/form" class="plusBtn"></a>
    </div>
<div style="text-align:center">
    <%--<button type="button"><a href="<c:url value="/post/form"/>">공간 등록하기</a></button>--%>


        <table>
            <tr>
                <th class="title">제목</th>
                <th class="main_content">설명</th>
                <th class="hourly_cost">비용(시간)</th>
                <th class="btn"></th>
            </tr>
            <c:forEach var="dto" items="${list}">
                <tr>
                    <td class="title">${dto.title}</td>
                    <td class="main_content">${dto.main_content}</td>
                    <td class="hourly_cost">${dto.hourly_cost}</td>
                    <td class="btn"><button type="button"><a href="<c:url value="/post/modifyForm?pno=${dto.pno}"/>">수정</a></button> <button type="button" onclick="postDelete(${dto.pno})">삭제</button></td>


                </tr>
            </c:forEach>
        </table>
        <br>
        <%--<div class="paging-container">
            <div class="paging">
                <c:if test="${totalCnt==null || totalCnt==0}">
                    <div> 게시물이 없습니다. </div>
                </c:if>
                <c:if test="${totalCnt!=null && totalCnt!=0}">
                    <c:if test="${ph.showPrev}">
                        <a class="page" href="<c:url value="/board/list${ph.sc.getQueryString(ph.beginPage-1)}"/>">&lt;</a>
                    </c:if>
                    <c:forEach var="i" begin="${ph.beginPage}" end="${ph.endPage}">
                        <a class="page ${i==ph.sc.page? "paging-active" : ""}" href="<c:url value="/board/list${ph.sc.getQueryString(i)}"/>">${i}</a>
                    </c:forEach>
                    <c:if test="${ph.showNext}">
                        <a class="page" href="<c:url value="/board/list${ph.sc.getQueryString(ph.endPage+1)}"/>">&gt;</a>
                    </c:if>
                </c:if>
            </div>
        </div>--%>
    </div>
</div>
<script>
    function postDelete(pno){
        let delCheck = confirm("포스트를 정말 삭제하시겠습니까?");
        if(delCheck){
            let form = document.createElement('form');
            form.setAttribute('method','get');
            form.setAttribute('action','delete');
            document.charset="utf-8";

            let pnoField=document.createElement('input');
            pnoField.setAttribute('type','hidden');
            pnoField.setAttribute('name','pno');
            pnoField.setAttribute('value',pno);
            form.appendChild(pnoField);

            document.body.appendChild(form);
            form.submit();
            /*$.ajax({
                url:'/post/delete',
                type:'GET',
                data:{pno:pno},
                dataType:'json',
                success:function(result){
                    if(result){
                        alert("게시글을 삭제했습니다.")
                    }else{
                        alert("넘어온 데이터 없음")
                    }

                },
                error:function(result){
                    alert("삭제 실패");
                }

            })*/
        }
    }
</script>
</body>
</html>