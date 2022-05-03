<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
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
        }
        /* 홈페이지 기능 네비 */
        .top_gnb_area{
            width: 100%;
            height: 50px;
            background-color: #a2a2ea;
        }
        /* 로고, 검색, 로그인 */
        .top_area{
            width: 100%;
            height: 150px;
            /* background-color: #f7f0b9; */
        }
        /* 로고 영역 */
        .logo_area{
            width: 25%;
            height: 100%;
            background-color: red;
            float:left;
        }
        /* 검색 박스 영역 */
        .search_area{
            width: 50%;
            height: 100%;
            background-color: yellow;
            float:left;
        }
        /* 로그인 버튼 영역 */
        .login_area{
            width: 25%;
            height: 100%;
            display: inline-block;
            text-align: center;
        }
        .login_button{
            height: 50%;
            background-color: #D4DFE6;
            margin-top: 30px;
            line-height: 77px;
            font-size: 40px;
            font-weight: 900;
            border-radius: 10px;
            cursor: pointer;
        }
        .login_area>span{
            margin-top: 10px;
            font-weight: 900;
            display: inline-block;
        }
        .login_button{
            height : 50%;
            background-color: #D4DFE6;
            margin-top:30px;
        }

        /* 제품 목록 네비 */
        .navi_bar_area{
            width: 100%;
            height: 70px;
            background-color: #7696fd;
        }

        /* 홈페이지 메인 제품 목록  */
        .content_area{
            width: 100%;
            background-color: #97ef97;
            height: 1000px;
        }

        /* float 속성 해제 */
        .clearfix{
            clear: both;
        }
        .navi_bar_area{
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
        .new_register{
            display: none;
        }
    </style>
<%--    <link rel="stylesheet" href="/css/main.css">--%>
<%--    <link rel="stylesheet" href="<c:url value='/css/menu.css'/>">--%>
</head>
<body>
<script>
    let msg = "${param.msg}";
    if(msg=="REG_OK") alert("회원가입을 완료되었습니다.");
    if(msg=="REG_ERR") alert("회원가입을 실패했습니다.");
</script>
<div class="wrapper">
    <div class="wrap">
        <div class="top_gnb_area">
            <h1>gnb area</h1>
        </div>
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
                            <option value="edit">공간등록&수정</option>
                            <option value="list">예약리스트</option>
                            <option value="stats">통계&정산</option>
                            <option value="/logout">로그아웃</option>
                        </select>
                    </c:if>
                    <c:if test ="${memberDto.master_admin==0}">
                        <select class="member-option" name="option">
                            <option>${memberDto.name}</option>
                            <option>예약현황</option>
                            <option>찜리스트</option>
                            <option><a href="/logout">로그아웃</a></option>
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
                <input type="text" name="keyword" class="search-input" type="text" placeholder="검색어를 입력해주세요">
                <input type="submit" class="search-button" value="검색">
            </div>

            <div class="new_register">
                <button>새로운 공간 등록</button>
            </div>
        </div>
        <div class="content_area">
            <h1>content area</h1>
        </div>
    </div>
</div>
<script>
    function change(option){
        if(option.value=="logout")
    }
</script>
</body>
</html>