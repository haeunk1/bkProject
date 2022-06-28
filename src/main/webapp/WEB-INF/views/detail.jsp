<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <script src="https://kit.fontawesome.com/92d2245491.js" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="/resources/css/menu.css" type="text/css">
    <link rel="stylesheet" href="/resources/css/detail.css" type="text/css">
    <meta charset="UTF-8">
    <title>여기다!</title>
</head>
<body>
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
                        <li><a href="/member/login?pno=${postDto.pno}" >로그인</a></li>
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
        <div class="top_area" >
            <h1>${postDto.title}</h1><br>
            <h2>${postDto.main_content}</h2><br>
            <h3>#${postDto.category}</h3><br>
            <div id="likeWrap">
                <a href='javascript:void(0);' onclick="likeCheck(true)"> <i class='far fa-heart' style='color:red' onclick='likeCheck(true)'></i></a>
            </div>
        </div>
        <hr>
        <div class="content_area">
            <div class="space_list">
                    <div class="parent">
                        <div class="child1">
                            <div id="uploadResult">
                            </div>
                            <div class="text_area">
                                <br>
                                <h2>상세설명</h2>
                                <hr>
                                <br>
                                <div id="textareaDiv">
                                    <h3><pre>${postDto.detail_content}</pre></h3>
                                </div>

                                <br>
                                <h3><i class="fa-solid fa-location-dot"></i> 위치</h3>
                                <hr>
                                <br>
                                <h4>${postDto.area_info}</h4><br>
                                <div id="map" style="width:100%;height:350px;"></div>

                                <br>
                                <h3>
                                    <div style="float:left"><i class="fa-solid fa-comments"></i> 리뷰 </div>
                                    <div id="commentCnt" style="float:left"></div>
                                </h3>

                                <hr>
                                <br>
                                <div id="commentList"></div>

                                <hr>
                                <div id="commentInput">

                                    <div id="iTop">
                                        <c:if test="${memberDto.id==null}">
                                            로그인이 필요합니다.
                                        </c:if>
                                        <c:if test="${memberDto.id!=null}">
                                            <h4>${memberDto.name}</h4>
                                        </c:if>
                                    </div>
                                    <div id="iMiddle">
                                        <form class="mb-3" name="myform" id="myform" method="post">
                                            <fieldset>
                                                <span class="text-bold">별점을 선택해주세요</span>
                                                <input type="radio" name="reviewStar" value="5" id="rate1"><label
                                                    for="rate1">★</label>
                                                <input type="radio" name="reviewStar" value="4" id="rate2"><label
                                                    for="rate2">★</label>
                                                <input type="radio" name="reviewStar" value="3" id="rate3"><label
                                                    for="rate3">★</label>
                                                <input type="radio" name="reviewStar" value="2" id="rate4"><label
                                                    for="rate4">★</label>
                                                <input type="radio" name="reviewStar" value="1" id="rate5"><label
                                                    for="rate5">★</label>
                                            </fieldset>
                                            <div>
                                                <textarea name="reviewContents" type="text" id="reviewContents"<%--class="col-auto form-control"--%>
                                                          placeholder="리뷰를 작성해주세요."></textarea>
                                            </div>
                                        </form>
                                        <%--<input type="text"placeholder="리뷰를 작성해주세요." name="comment"><br>--%>
                                    </div>
                                    <div id="iBottom">
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="blank"></div>
                        <div class="child2" id ="calendar_area" >
                            <div class="book_area">
                                <div id="upload_calendar"></div>
                                <div id="upload_time"></div>
                                <div id="upload_cost"></div>
                            </div>
                        </div>
                    </div>
            </div>
        </div>
    </div>
</div>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=890933eee4cefb5cd4a841205758a755&libraries=services"></script>



<script>
    //좋아요체크
    function likeCheck(result){
        let pno=${postDto.pno};
        $.ajax({
            url:'/postLike',
            type:'POST',
            data:{ch:result, pno:pno},
            dataType:'json',
            success:function(result){
                if(result){
                    alert("좋아요 추가!");
                    let likeWrap = $("#likeWrap");
                    let str = "<a href='javascript:void(0);' onclick='likeCheck(false)'> <i class='fas fa-heart' style='color:red'></i></a>";
                    likeWrap.html(str);
                }else{
                    alert("좋아요 삭제!");
                    let likeWrap = $("#likeWrap");
                    let str = "<a href='javascript:void(0);' onclick='likeCheck(true)'> <i class='far fa-heart' style='color:red'></i></a>";
                    likeWrap.html(str);
                }



            },
            error:function(result){
                alert("로그인 해주세요");
                let likeWrap = $("#likeWrap");
                let str = "<a href='javascript:void(0);' onclick='likeCheck(true)'> <i class='far fa-heart' style='color:red'></i></a>";
                likeWrap.html(str);
                //$("input:checkbox[id='likeCheck']").prop("checked",false);
            }

        })
    }

    function kakaoMap(area_info,detail_area){
        var mapContainer = document.getElementById('map'), // 지도를 표시할 div
            mapOption = {
                center: new kakao.maps.LatLng(33.450701, 126.570667), // 지도의 중심좌표
                level: 3 // 지도의 확대 레벨
            };

        // 지도를 생성합니다
        var map = new kakao.maps.Map(mapContainer, mapOption);

        // 주소-좌표 변환 객체를 생성합니다
        var geocoder = new kakao.maps.services.Geocoder();

        // 주소로 좌표를 검색합니다
        geocoder.addressSearch(area_info, function(result, status) {

            // 정상적으로 검색이 완료됐으면
            if (status === kakao.maps.services.Status.OK) {

                var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

                // 결과값으로 받은 위치를 마커로 표시합니다
                var marker = new kakao.maps.Marker({
                    map: map,
                    position: coords
                });

                // 인포윈도우로 장소에 대한 설명을 표시합니다
                var infowindow = new kakao.maps.InfoWindow({
                    //content: '<div style="width:150px;text-align:center;padding:6px 0;">상세주소</div>'
                    content: "<div style='width:150px;text-align:center;padding:6px 0;'>"+detail_area+"</div>"
                });
                infowindow.open(map, marker);

                // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
                map.setCenter(coords);
            }
        });
    }



    //댓글 띄우기
    function showReview(comments){
        let id = '${memberDto.id}';

        let commentList = $("#commentList");
        if(!comments || comments.length==0){
            let tmp ="<br><h3>댓글이 없습니다</h3><br>";
            commentList.html(tmp);
            return;
        }
        let tmp="";
        for(let i=0;i<comments.length;i++){
            let obj = comments[i];
            tmp+="<div id='commentWrapper'>";
            tmp +="<div id='userImg'> <i class='fa-solid fa-circle-user fa-5x'></i></div>";
            tmp +="<div id='commentWrapper2'>";
            //tmp +="<div id='cTop'>"+obj.commenter+"</div>";
            tmp +="<div id='cTop'>"
            tmp +="<div id='userId'>"+obj.commenter+"</div>";
            tmp +="<div id='star'>";
            let s="";
            let c=5-obj.starScore;
            for(let j=0;j<obj.starScore;j++){
                s+="★";
            }
            for(let j=0;j<c;j++){
                s+="☆";
            }
            tmp +=s;
            tmp +="</div>";//star
            tmp+="</div>";//cTop
            tmp +="<div id='cMiddle'><span id='comment'>"+obj.comment+"</span></div>";
            tmp +="<div id='cBottom'>";
            tmp +="<div id='date'>"+obj.up_date+"</div>";
            tmp +="<div id='btn'>";

            if(id!='' && id==obj.commenter){
                tmp +="<input type='hidden' id=input"+obj.cno+" value='"+obj.comment+"'>"
                tmp += "<button class='delBtn' value="+obj.cno+">삭제</button>";
                tmp += "<button class='modBtn' value="+obj.cno+">수정</button>";
            }
            tmp +="</div></div></div></div>";
        }
        commentList.html(tmp);
    }


    function getList(pno){
        $.ajax({
            type:'GET',       // 요청 메서드
            url: '/comments?pno='+pno,  // 요청 URI
            dataType:'json',
            success : function(result){
                showReview(result);
            },
            error   : function(){ alert("error") } // 에러가 발생했을 때, 호출될 함수
        });
    }

    function showCommentCnt(result) {
        let commentDiv=$("#commentCnt");
        let str="("+result+")";
        commentDiv.html(str);

    }

    $(document).ready(function(){
        let result=${postDto.comment_cnt};
        showCommentCnt(result);
        let id = '${memberDto.id}';
        let pno=${postDto.pno};

        //지도 띄우기
        let area_info="${postDto.area_info}";
        let detail_area="${postDto.detail_area}";
        kakaoMap(area_info,detail_area);

        //댓글 띄우기
        getList(pno);

        let iBottom = $("#iBottom");
        let str = "<button id='insertBtn'>입력</button>";
        iBottom.html(str);

        $(document).on("click", "button[id='modBtn2']", function() {

            if(!$('input[name=reviewStar]').is(':checked')){
                alert("별점을 체크해주세요.");
                return false;
            }
            if ($('#reviewContents').val() == "") {
                alert("리뷰를 작성해주세요.");
                $('#reviewContents').focus();
                return false;
            }
            let starScore=$('input[name=reviewStar]:checked').val();
            let comment = $('#reviewContents').val();
            let cno=$(this).attr("value");

            $.ajax({
                type:'PATCH',       // 요청 메서드
                url: '/comments/'+cno,  // 요청 URI(/ch4/comments?bno=1085  POST)
                headers : { "content-type": "application/json"}, // 요청 헤더
                data : JSON.stringify({cno:cno,comment:comment,starScore:starScore}),  // 서버로 전송할 데이터. stringify()로 직렬화 필요.
                success : function(result){
                    alert(result);
                    let iBottom = $("#iBottom");
                    let str = "<button id='insertBtn'>입력</button>";
                    iBottom.html(str);

                    $("textarea[name=reviewContents]").val("");//수정완료하면 택스트 공백만들기
                    getList(pno);
                },
                error   : function(){ alert("error") } // 에러가 발생했을 때, 호출될 함수
            }); // $.ajax()
        });




        $("#commentList").on("click",".modBtn",function(){
            let cno=$(this).attr("value");

            let inputid="input"+cno;
            let comment = document.getElementById(inputid).value;

            //1. comment의 내용을 input에 뿌려주기
            $("textarea[name=reviewContents]").val(comment);

            //2. 수정버튼 추가하기, cno전달
            let iBottom = $("#iBottom");
            let str = "<button id='modBtn2' value="+cno+">수정 확인</button>";
            iBottom.html(str);

        });

        //댓글삭제하기
        $("#commentList").on("click",".delBtn",function(){

            let cno=$(this).attr("value");

            $.ajax({
                type:'DELETE',       // 요청 메서드
                url: '/comments/'+cno+'?pno='+pno,  // 요청 URI
                success : function(result){
                    alert("삭제되었습니다.");
                    showCommentCnt(result);
                    getList(pno);
                },
                error   : function(){ alert("error") } // 에러가 발생했을 때, 호출될 함수
            });
        });

        //댓글 작성하기
        $("#insertBtn").click(function(){
            if(id==''){
                alert("로그인이 필요합니다.");
                return;
            }

            //let form = document.getElementById("form");

            if ($('#reviewContents').val() == "") {
                alert("리뷰를 작성해주세요.");
                $('#reviewContents').focus();
                return false;
            }
            if(!$('input[name=reviewStar]').is(':checked')){
                alert("별점을 체크해주세요.");
                return false;
            }
            let starScore=$('input[name=reviewStar]:checked').val();
            let comment = $('#reviewContents').val();
            $.ajax({
                type:'POST',       // 요청 메서드
                url: '/comments?pno='+pno,
                headers : { "content-type": "application/json"}, // 요청 헤더
                data : JSON.stringify({pno:pno,comment:comment,starScore:starScore}),
                //data : JSON.stringify({pno:pno,comment:comment}),  // 서버로 전송할 데이터. stringify()로 직렬화 필요.
                success : function(result){
                    alert("댓글이 입력되었습니다.");
                    document.getElementById("reviewContents").value='';
                    showCommentCnt(result);
                    getList(pno);
                },
                error   : function(){ alert("error") } // 에러가 발생했을 때, 호출될 함수
            }); // $.ajax()
        });

        if(id!=''){
            //좋아요 여부에 따라 checked=true
            $.ajax({
                url:'/likeCheck',
                type:'POST',
                data:{pno:pno, id:id},
                dataType:'json',
                success:function(result){
                    if(result==1){

                        let likeWrap = $("#likeWrap");
                        let str = "<a href='javascript:void(0);' onclick='likeCheck(false)'> <i class='fas fa-heart' style='color:red'></i></a>";
                        likeWrap.html(str);

                        $("input:checkbox[id='likeCheck']").prop("checked",true);
                    }else if(result==0){

                        let likeWrap = $("#likeWrap");
                        let str = "<a href='javascript:void(0);' onclick='likeCheck(true)'> <i class='far fa-heart' style='color:red'></i></a>";
                        likeWrap.html(str);

                        $("input:checkbox[id='likeCheck']").prop("checked",false);
                    }
                }
            })
        }


        let month= ${ch.month};
        let year=${ch.year};
        callCalendar(year, month,-1);


        ///***이미지 띄우기***
        /*let pno = '<c:out value="${postDto.pno}"/>';*/
        let uploadResult=$("#uploadResult");
        //let pno=${postDto.pno};
        $.getJSON("/getImageList",{pno:pno},function(arr){ //1.url매핑 메서드 요청 2.객체초기자(pno전달) 3.성공적으로 서버로부터 이미 정보를 전달받았을 때 실행할 콜백 함수
            if(arr.length===0){
                let str="";
                str+="<div id='result_card'>";
                str+="<img src='/resources/img/noImg.png'>";
                str+="</div>";
                uploadResult.html(str);
                return;
            }

            for(let i=0;i<arr.length;i++){
                let str="";
                let obj=arr[i];//서버로부터 전달받은 이미지 정보 객체 값
                let fileCallPath =obj.uploadPath+"/"+obj.uuid+"_"+obj.fileName;
                //let fileCallPath = encodeURIComponent(obj.uploadPath + "/s_"+obj.uuid + "_" + obj.fileName);
                str += "<div id='result_card'";
                str += "data-path='" + obj.uploadPath + "' data-uuid='" + obj.uuid + "' data-filename='" + obj.fileName + "'";
                str +=">";
                str += "<img src='/display?filePath="+obj.uploadPath+'&fileUuid='+obj.uuid+'&fileName='+obj.fileName+ "'>";
                str += "</div>";

                uploadResult.append(str);

            }
        });
    });



    //'월'에 따른 '일'배열을 가져옴
    function callCalendar(year,month,pick){
        if(month==13){
            year=year+1;
            month=1;
        }
        if(month==0){
            year=year-1;
            month=12;
        }


        $.ajax({
            url:'/calendar',
            type:'POST',
            data:{year:year,month:month},
            dataType:'json',
            success:function(ch){
                //console.log("Array.form="+Array.form(list));
                showCalendar(ch,pick);
            },
            error:function(result){
                alert("calendar실패");
            }

        })
    }
    function showCalendar(ch,pick){
        let cost_area=$("#upload_cost");
        let calendar=$("#upload_calendar");
        let month=ch.month;
        let year=ch.year;
        let lastDay=ch.end;
        let list=ch.dayList;
        let nextMonth=month+1;
        let prevMonth=month-1;

        //let day=ch.day;
        let today = new Date();
        let tyear=today.getFullYear();
        let tmonth=today.getMonth()+1;

        let tday=today.getDate();
        //costarea.html('');//***적용안됨***
        let str="";
        str+="<table  width=100% height='300px'>";

       str+="<caption class='blind'>"
        str+="<a href = '#' onclick='callCalendar("+year+","+prevMonth+")'>"+"<<"+"</a>";
        str+=year+"년"+month+"월"
        str+="<a href = '#' onclick='callCalendar("+year+","+nextMonth+")'>"+">>"+"</a>";
        str+="</caption>";

        str+="<colgoup>";
        str+="<col span='7' style='width:auto;'>";
        str+="</colgoup>";
        str+="<thead> <tr align='center'> <th>SUN</th> <th>MON</th> <th>TUE</th> <th>WED</th> <th>THU</th> <th>FRI</th> <th>SAT</th> </tr> </thead>";
        str+="<tbody>";
        let i=0;
        while(true){
            str+="<tr align='center'>";
            while(list[i]!="\"br\""){
                if(list[i] !="&nbsp;"){
                    if(year<tyear){
                        str += "<td bgcolor='gray'>" + list[i] + "</td>";
                    }else{
                        if(month<tmonth){
                            str += "<td bgcolor='gray'>" + list[i] + "</td>";
                        }else if(month==tmonth){
                            if(list[i]<tday){
                                str += "<td bgcolor='gray'>" + list[i] + "</td>";
                            }else{
                                if (pick==list[i]){
                                    str += "<td bgcolor='yellow' onclick='callTime(" + year + "," + month + "," + list[i] + ");'>" + list[i] + "</td>";
                                }else{
                                    if(year==tyear & month==tmonth & list[i]==tday) {
                                        str += "<td bgcolor='#87ceeb' onclick='callTime(" + year + "," + month + "," + list[i] + ");'>" + list[i] + "</td>";
                                    }else{
                                        str+="<td bgcolor='white' onclick='callTime("+year+","+month+","+list[i]+"); callCalendar("+year+","+month+","+list[i]+");'>"+list[i]+"</td>";
                                    }
                                }
                            }
                        }else {
                            if (pick == list[i]) {
                                str += "<td bgcolor='yellow' onclick='callTime(" + year + "," + month + "," + list[i] + ");'>" + list[i] + "</td>";
                            } else {
                                str += "<td bgcolor='white' onclick='callTime(" + year + "," + month + "," + list[i] + "); callCalendar(" + year + "," + month + "," + list[i] + ");'>" + list[i] + "</td>";

                            }
                        }
                    }
                }else{
                    str+="<td>"+list[i]+"</td>";
                }
                i++;
                if(list[i-1]==lastDay) break;
            }
            str+="</tr>";
            if(list[i-1]==lastDay) break;
            i++;
        }
        str+="</tbody>";
        str+="</table>";

        if($("#costDiv").length>0){
            $("#costDiv").remove();
        }
        calendar.html(str);

    }






    //'월'과 '일'정보에 따라 타임스케줄 불러옴
    function callTime(year,month,day) {
        let pno=${postDto.pno};
        $.ajax({
            url:'/getTimeList',
            type:'POST',
            data:{pno:pno,year:year,month:month,day:day},
            dataType:'json',
            success:function(scheduleDto){
                let timeString=scheduleDto.time;
                let year=scheduleDto.year;
                let month=scheduleDto.month;
                let day=scheduleDto.day;
                showTimeSchedule(timeString,year,month,day);
            },
            error:function(result){
                alert("timeSchedule실패");
            }

        })
    }
    function showTimeSchedule(timeString,year,month,day){


        let time_area=$("#upload_time");
        let str="";
        let tmp=6;
        let index=0;

        str+="<table bordercolor='black'>";
        str+="<colgoup>";
        str+="<col span='18' style='width:auto;'>";
        str+="</colgoup>";
        for(let a=0;a<2;a++){
            str+="<thead> <tr align='center'>";
            for(let i=0;i<9;i++){
                str+="<th bgcolor='white'>";
                str+=tmp+":00";
                str+="</th>";
                tmp++;
            }
            str+="</thead>";
            str+="<tbody> <tr>";
            for(let i=0;i<9;i++){
                if(timeString[index]=='0'){
                    str+="<td bgcolor='white' onclick=\"change(\'"+timeString+"',"+index+","+year+","+month+","+day+")\">";
                    str+="<h5>${postDto.hourly_cost}</h5>";
                }else if(timeString[index]=='2'){
                    str+="<td bgcolor='yellow' onclick=\"change(\'"+timeString+"',"+index+","+year+","+month+","+day+")\">";
                    str+="<h5>${postDto.hourly_cost}</h5>";
                }
                else{//버튼 비활성화
                    str+="<td bgcolor='gray'>";
                    str+="<h5>${postDto.hourly_cost}</h5>";
                }
                index++;
                str+="</td>";
            }
            str+="</tr>";
            str+="</tbody>";
        }

        str+="</table>";
        time_area.html(str);
    }
    function change(timeString,index,year,month,day){
        let str="";
        for(let i=0;i<18;i++){
            if(i==index){
                if(timeString[index]=='0') {
                    str+='2';
                }else if(timeString[index]=='2'){
                    str+='0';
                }
            }else{

                str+=timeString[i];
            }
        }
        showTimeSchedule(str,year,month,day);
        showCost(str,year,month,day);

    }

    let cost=0;
    function showCost(str1,year,month,day){
        let cnt=0;
        for(let i=0;i<18;i++){
            if(str1[i]=='2'){
                cnt=cnt+1;
            }
        }
        let str='';
        let cost_area=$("#upload_cost");
        let tmp="${postDto.hourly_cost}";
        let hourly_cost=parseInt(tmp.replaceAll(',',''));
        if(cnt!=0) {
            str+="<div id='costDiv'>";
            str += cnt + "시간 선택";
            str += "<br>";
            str += "비용 : 총";
            str += hourly_cost * cnt;
            str += "원";
            str +="<hr>";
            str +="<button type='button' id='payBtn' onclick=\"payBtnClick(\'"+str1+"',"+hourly_cost*cnt+","+year+","+month+","+day+")\">";
            str +="결제하기";
            str +="</button>";
            str+="</div>";
            cost_area.html(str);
        }else{
            cost_area.html(str);
        }
    }

    function payBtnClick(timeString,totCost,year,month,day){
        let pno=${postDto.pno};

        let form=document.createElement('form');
        form.setAttribute('method','post');
        form.setAttribute('action','/payCheck');
        document.charset="utf-8";

        let timeStringField=document.createElement('input');
        timeStringField.setAttribute('type','hidden');
        timeStringField.setAttribute('name','timeString');
        timeStringField.setAttribute('value',timeString);
        form.appendChild(timeStringField);

        let totCostField=document.createElement('input');
        totCostField.setAttribute('type','hidden');
        totCostField.setAttribute('name','totCost');
        totCostField.setAttribute('value',totCost);
        form.appendChild(totCostField);

        let yearField=document.createElement('input');
        yearField.setAttribute('type','hidden');
        yearField.setAttribute('name','year');
        yearField.setAttribute('value',year);
        form.appendChild(yearField);

        let monthField=document.createElement('input');
        monthField.setAttribute('type','hidden');
        monthField.setAttribute('name','month');
        monthField.setAttribute('value',month);
        form.appendChild(monthField);

        let dayField=document.createElement('input');
        dayField.setAttribute('type','hidden');
        dayField.setAttribute('name','day');
        dayField.setAttribute('value',day);
        form.appendChild(dayField);

        let pnoField=document.createElement('input');
        pnoField.setAttribute('type','hidden');
        pnoField.setAttribute('name','pno');
        pnoField.setAttribute('value',pno);
        form.appendChild(pnoField);

        document.body.appendChild(form);
        form.submit();
    }




</script>
</body>
</html>