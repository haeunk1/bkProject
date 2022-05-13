<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>

    <meta charset="UTF-8">
    <title>Welcome BookingSite</title>
    <link rel="stylesheet" href="/css/main.css">
<%--    <link rel="stylesheet" href="<c:url value='/css/menu.css'/>">--%>
</head>
<body>
<script>
    let msg = "${param.msg}";
    if(msg=="REG_OK") alert("회원가입을 완료되었습니다.");
    if(msg=="REG_ERR") alert("회원가입을 실패했습니다.");
    if(msg=="postOK") alert("게시글이 등록되었습니다.");
</script>
<div class="wrapper">
    <div class="wrap">
        <div class="top_area">
            <div class="logo_area">
                <h1>logo area</h1>
            </div>
            <div class="search_area">
                <h1>Search area</h1>
            </div>
            <div class="login_area">
                <!--로그인 하지 않은 상태 -->
                <c:if test = "${memberDto.id==null}">
                    <div class="login_button"><a href="/member/login">로그인</a></div>
                    <span><a href="/member/join">회원가입</a></span>
                </c:if>

                <c:if test = "${memberDto.id!=null}">
                    <c:if test ="${memberDto.master_admin==1}">
                        <select class="admin-option" name="option" onchange="location.href=this.value">
                            <option>${memberDto.name}</option>
                            <option value="/test">공간등록&수정</option>
                            <option value="">예약리스트</option>
                            <option value="">통계&정산</option>
                            <option value="/member/logout">로그아웃</option>
                        </select>
                    </c:if>
                    <c:if test ="${memberDto.master_admin==0}">
                        <select class="member-option" name="option" onchange="location.href=this.value">
                            <option>${memberDto.name}</option>
                            <option>예약현황</option>
                            <option>찜리스트</option>
                            <option value="/member/logout">로그아웃</option>
                        </select>
                    </c:if>

                </c:if>

            </div>
            <div class="clearfix"></div>
        </div>



        <div class="navi_bar_area">
            <div class="arrange">
                <select class="arrange-option" name="option">
                    <option>정렬</option>
                    <option value="L">좋아요</option>
                    <option value="V">조회수</option>
                </select>
            </div>
            <div class="search">

                <select class="search-option" name="option">
                    <option>검색조건</option>
                    <option value="location">위치</option>
                    <option value="title">제목</option>
                    <option value="category">카테고리</option>
                </select>

                <input type="text" name="keyword" class="search-input" type="text" placeholder="검색어를 입력해주세요">
                <input type="submit" class="search-button" value="검색">
            </div>

            <div class="new_register">
                <button>새로운 공간 등록</button>
            </div>
        </div>
        <div class="content_area">
            <div class="space_list">
                <c:forEach var="postDto" items="${list}">
                    <tr>
                        <td class="img"></td>
                        <td class="title"></td>
                        <td class="location"></td>
                        <td class="category"></td>
                        <td class="price"></td>
                        <td class="like_cnt"></td>
                        <td class="view_cnt"></td>
                        <td class="comment_cnt"></td>

                    </tr>
                </c:forEach>
            </div>
            <div>
                <div class="page_handler">
                    1,2,3,4,5,6...
                </div>

            </div>
        </div>
    </div>
</div>

</body>
</html>