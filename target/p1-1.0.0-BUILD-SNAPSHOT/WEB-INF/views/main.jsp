<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <script src="https://kit.fontawesome.com/92d2245491.js" crossorigin="anonymous"></script>
    <script src="https://code.jquery.com/jquery-1.12.4.js"></script>
    <script src="https://code.jquery.com/ui/1.12.1/jquery-ui.js"></script>
    <meta charset="UTF-8">
    <link rel="stylesheet" href="/resources/css/menu.css" type="text/css">
    <title>Welcome BookingSite</title>
    <style>
        *{
            margin: 0;
            padding:0;
        }
        /* 화면 전체 렙 */
        .wrapper{
            width: 100%;
        }
        /* content 랩 */
        .wrap{
            width : 1080px;
            margin: auto;
            height: auto;
        }
        .login_area>span{
            margin-top: 10px;
            font-weight: 900;
            display: inline-block;
        }
        .main_wrapper{
            background-color: rgb(253, 253, 250);
            width: 100%;
            height: 110px;
            border: 1px solid #ddd;
            margin-top : 10px;
            margin-bottom: 30px;
            display: flex;
            justify-content: center;
            align-items: center;
        }
        .content_area{
            width: 100%;
            /*background-color: #97ef97;*/
            height: 3000px;

        }
        .space_list{

            margin:10px 20px 10px 20px;
            border-radius: 15px;
            /*background-color: pink;*/
            height: 80%;

        }

        .parent{
            border-radius: 15px;
            border: 5px solid beige;
            padding: 10px;
            background-color: white;
            width: 97%;
            height: 200px;
            display:grid;
            grid-template-columns:10fr 0.5fr 10fr;
            margin-bottom: 10px;

        }
        .child{
            flex:1;
            background: #2E9AFE;
            padding-left:10px;
        }

        #result_card img{
            max-width: 100%;
            height: auto;
            display: block;
            padding: 5px;
            margin-top: 10px;
            margin: auto;
        }
        .page_handler{
            color: black;
            width: 100%;
            align-items: center;
            margin-top: 20px;
            text-align:center;


        }
        .page {
            color: black;
            padding: 6px;
            margin-right: 10px;
        }
        .arrange{
            float:left;
            /*margin-left:20px;*/
        }
        .search{
            float:right;
        }

        #uploadResult img{
            max-width: 30%;
            height: auto;
            display: block;
            padding: 5px;
            margin-top: 10px;
            margin: auto;
            background-position:center;
        }



    </style>
</head>
<body>
<script>
    let msg = "${msg}";
    if(msg=="REG_OK") alert("회원가입을 완료되었습니다.");
    if(msg=="REG_ERR") alert("회원가입을 실패했습니다.");
    if(msg=="postOK") alert("게시글이 등록되었습니다.");
    if(msg=="BOOK_OK") alert("결제 완료되었습니다.");
    if(msg=="BOOK_ERR") alert("결제 실패했습니다.");

</script>
<div class="wrapper">
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
                        <li><a href="/member/login">로그인</a></li>
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
    <div class="wrap">
        <div class="main_wrapper">
            <div class="search">
                <form action="<c:url value='/main'/>" class="search-form" method="get">
                        <select class="arrange-option" name="arrange"><%--onchange="location.href=this.value" -->> 변하자마자 바로 적용--%>
                            <option value="pno"${ph.searchCondition.arrange=='pno' ? "selected" : ""}>정렬</option>
                            <option value="like"${ph.searchCondition.arrange=='like' ? "selected" : ""}>좋아요</option>
                            <option value="view" ${ph.searchCondition.arrange=='view' ? "selected" : ""}>조회수</option>
                        </select>
                        <select class="search-option" name="option">
                            <option value="all" ${ph.searchCondition.option=='all' || ph.searchCondition.option=='' ? "selected" : ""}>검색조건</option>
                            <option value="title" ${ph.searchCondition.option=='title' ? "selected" : ""}>제목</option>
                            <option value="category" ${ph.searchCondition.option=='category' ? "selected" : ""}>카테고리</option>
                            <option value="location" ${ph.searchCondition.option=='location' ? "selected" : ""}>위치</option>
                        </select>

                        <input type="text" name="keyword" class="search-input" type="text" value="${ph.searchCondition.keyword}"placeholder="검색어를 입력해주세요">
                        <input type="submit" class="search-button" value="검색">


                </form>

            </div>
        </div>
        <div class="content_area">
            <div class="space_list">
                <c:forEach var="postDto" items="${list}">
                    <a href="detail?pno=${postDto.pno}">
                        <div class="parent">
                            <div class="child">
                                <div id="uploadResult">
                                        <img src="/display?filePath=${postDto.imgOne.uploadPath}&fileUuid=${postDto.imgOne.uuid}&fileName=${postDto.imgOne.fileName}">
                                </div>
                            </div>
                            <div class="blank"></div>
                            <div class="child" style="background: #FA5858;">
                                <br><td class="title"><h2>${postDto.title}</h2></td>
                                <br><td class="category"> #${postDto.category}</td>
                                <br><td class="hourly_cost"> <i class="fa-solid fa-won-sign"></i> 시간당 금액 : ${postDto.hourly_cost}</td>
                                <br><td class="area_info"> <i class="fa-solid fa-location-dot"></i> 위치 : ${postDto.area_info}</td>
                                <br><td class="like_cnt"> <i class="fa-solid fa-heart"></i> 좋아요 : ${postDto.like_cnt}</td>
                                <br><td class="view_cnt"> <i class="fa-solid fa-eye"></i> 조회수 : ${postDto.view_cnt}</td>
                            </div>
                        </div>
                    </a>
                </c:forEach>

            </div>

            <div class="page_handler">

                <c:if test="${totalCnt eq null || totalCnt eq 0}">
                    <div> 게시물이 없습니다.</div>
                </c:if>
                <c:if test="${totalCnt ne 0}">
                    <c:if test="${ph.showPrev}">
                        <a class="page" href="<c:url value="/main${ph.searchCondition.getQueryString(ph.beginPage-1)}"/>">&lt;</a>
                    </c:if>
                    <c:forEach var="i" begin="${ph.beginPage}" end="${ph.endPage}">

                            <a class="page ${i==ph.searchCondition.page? "paging-active" : ""}" style="color:${ph.searchCondition.page eq i ? 'red;' : 'black;'} " href="<c:url value="/main${ph.searchCondition.getQueryString(i)}"/>">${i}</a>

                    </c:forEach>
                    <c:if test="${ph.showNext}">
                        <a class="page" href="<c:url value="/main${ph.searchCondition.getQueryString(ph.endPage+1)}"/>">&gt;</a>
                    </c:if>

                </c:if>
            </div>
        </div>
    </div>
    <script>

    </script>
</div>
</body>
</html>