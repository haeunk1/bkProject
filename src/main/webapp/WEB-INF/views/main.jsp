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
        .content_area{
            width: 100%;
            background-color: #97ef97;
            height: 3000px;

        }
        /*.post>div{
            margin:50px;
        }*/

        .space_list{

            margin:10px 20px 10px 20px;
            border-radius: 15px;
            background-color: pink;
            height: 80%;

        }

        .parent{
            border-radius: 15px;
            border: 5px solid green;
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
        }

        #result_card img{
            max-width: 100%;
            height: auto;
            display: block;
            padding: 5px;
            margin-top: 10px;
            margin: auto;
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
                            <option value="/post/form">공간등록&수정</option>
                            <option value="">예약리스트</option>
                            <option value="">통계&정산</option>
                            <option value="/member/logout">로그아웃</option>
                        </select>
                    </c:if>
                    <c:if test ="${memberDto.master_admin==0}">
                        <select class="member-option" name="option" onchange="location.href=this.value">
                            <option>${memberDto.name}</option>
                            <option value="/user/bookingList">예약현황</option>
                            <option value="/user/likeList">찜리스트</option>
                            <option value="/member/logout">로그아웃</option>
                        </select>
                    </c:if>

                </c:if>

            </div>
            <div class="clearfix"></div>
        </div>



        <div class="navi_bar_area">
            <div class="arrange">
                <form action="<c:url value='/main'/>" class="search-form" method="get">

                </form>
            </div>
            <div class="search">
                <form action="<c:url value='/main'/>" class="search-form" method="get">
                    <select class="arrange-option" name="arrange">
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

            <div class="new_register">
                <button>새로운 공간 등록</button>
            </div>
        </div>
        <div class="content_area">
            <div class="space_list">
                <c:forEach var="postDto" items="${list}">
                    <a href="detail?pno=${postDto.pno}">
                            <%-- <a href="<c:url value = '/detail?pno=${postDto.pno}'/>">--%>
                        <div class="parent">
                            <div class="child">
                                <div id="uploadResult">


                                </div>
                            </div>
                            <div class="blank"></div>
                            <div class="child" style="background: #FA5858;">
                                <br><td class="title">${postDto.title}</td>
                                <br><td class="category">${postDto.category}</td>
                                <br><td class="hourly_cost">시간당 금액 : ${postDto.hourly_cost}</td>
                                <br><td class="area_info">위치 : ${postDto.area_info}</td>
                                <br><td class="like_cnt">좋아요 : ${postDto.like_cnt}</td>
                                <br><td class="view_cnt">조회수 : ${postDto.view_cnt}</td>
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
                        <a class="page ${i==ph.searchCondition.page? "paging-active" : ""}" href="<c:url value="/main${ph.searchCondition.getQueryString(i)}"/>">${i}</a>
                    </c:forEach>
                    <c:if test="${ph.showNext}">
                        <a class="page" href="<c:url value="/main${ph.searchCondition.getQueryString(ph.endPage+1)}"/>">&gt;</a>
                    </c:if>

                </c:if>



            </div>
        </div>
    </div>
</div>
<script>
    //메인화면 이미지 띄우기(보류)
    /*$(document).ready(function(){
        let pno='<c:out value="${postDto.pno}"/>';
        console.log(pno);
        let uploadResult=$("#uploadResult");
        $.getJSON("/getImageList",{pno:pno},function(arr){ //1.url매핑 메서드 요청 2.객체초기자(pno전달) 3.성공적으로 서버로부터 이미 정보를 전달받았을 때 실행할 콜백 함수
            if(arr.length===0){
                let str="";
                str+="<div id='result_card'>";
                str+="<img src='/resources/img/noImg.png'>";
                str+="</div>";
                uploadResult.html(str);
                return;
            }

            let str="";
            let obj=arr[0];//서버로부터 전달받은 이미지 정보 객체 값

            let fileCallPath = encodeURIComponent(obj.uploadPath + "/s_"+obj.uuid + "_" + obj.fileName);
            str += "<div id='result_card'";
            str += "data-path='" + obj.uploadPath + "' data-uuid='" + obj.uuid + "' data-filename='" + obj.fileName + "'";
            str +=">";
            str += "<img scr='/display?fileName=" + fileCallPath + "'>";
            str += "/>";

            uploadResult.html(str);
        });

    });*/
</script>
</body>
</html>