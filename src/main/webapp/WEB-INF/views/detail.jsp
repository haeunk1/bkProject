<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <script src="https://kit.fontawesome.com/92d2245491.js" crossorigin="anonymous"></script>
    <link rel="stylesheet" href="/resources/css/menu.css" type="text/css">
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
            margin-top:20px;
            width: 100%;
            height: 200px;
        }

        .content_area{
            width: 100%;
            background-color: lemonchiffon;
            height: auto;

        }

        .parent{
            border-radius: 15px;
            background-color: white;
            width: 100%;
            height: 100%;
            display:grid;
            grid-template-columns:18fr 0.1fr 12fr;
            margin-top:10px;
/*            margin-bottom: 10px;*/

        }
        .child{
            flex:1;
        }
        #calendar_area{
            background-color:beige;
            border-radius: 20px;
            border: 5px solid black;
            padding-left:10px;
            padding-right: 10px;
            padding-top:10px;
        }
        #result_card img{
            width: 70%;
            height: 300px;
            display: block;
            padding: 5px;
            margin-top: 10px;
            margin: auto;
        }

        #upload_calendar>table{
            border:1px solid #444444;
            border-collapse:collapse;
        }
        th,td{
            border:1px solid #444444;
        }
        #upload_time>table{
            border:1px solid #444444;
        }

    </style>

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
    <div class="wrap">
        <div class="top_area" >
            <h1>${postDto.title}</h1><br>
            <h2>${postDto.main_content}</h2><br>
            <h3>#${postDto.category}</h3><br>
            <input type='checkbox' id='likeCheck' onclick='likeCheck()'>좋아요(찜)
        </div>
        <hr>
        <div class="content_area">
            <div class="space_list">
                    <div class="parent">
                        <div class="child">
                            <div id="uploadResult">
                            </div>
                            <div class="text_area">
                                <br>
                                <h2>상세설명</h2>
                                <h3>${postDto.detail_content}</h3>
                                <br>
                                <h3><i class="fa-solid fa-location-dot"></i> 위치</h3>
                                <h4>${postDto.area_info}</h4>
                                <br>
                                <h3><i class="fa-solid fa-comments"></i> 댓글</h3>
                                <h4>댓글리스트 나중에 출력</h4>
                            </div>
                        </div>
                        <div class="blank"></div>
                        <div class="child" id ="calendar_area" >
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
<script>


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
        calendar.html(str);

    }


    $(document).ready(function(){
        let id = '${memberDto.id}';
        let pno=${postDto.pno};
        if(id!=''){
            //좋아요 여부에 따라 checked=true
            $.ajax({
                url:'/likeCheck',
                type:'POST',
                data:{pno:pno, id:id},
                dataType:'json',
                success:function(result){
                    console.log("result="+result);
                    if(result==1){
                        $("input:checkbox[id='likeCheck']").prop("checked",true);
                    }else if(result==0){
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

    function likeCheck(){
        const checkbox=document.getElementById('likeCheck');
        const is_checked=checkbox.checked;
        console.log(is_checked);
        let pno=${postDto.pno};

        $.ajax({
            url:'/postLike',
            type:'POST',
            data:{ch:is_checked, pno:pno},
            dataType:'json',
            success:function(result){
                if(result){
                    alert("좋아요 추가!")
                }else{
                    alert("좋아요 삭제!")
                }
            },
            error:function(result){
                alert("로그인 해주세요");
                $("input:checkbox[id='likeCheck']").prop("checked",false);
            }

        })
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
            str += cnt + "시간 선택";
            str += "<br>";
            str += "비용 : 총";
            str += hourly_cost * cnt;
            str += "원";
            str +="<hr>";
            str +="<button type='button' id='payBtn' onclick=\"payBtnClick(\'"+str1+"',"+hourly_cost*cnt+","+year+","+month+","+day+")\">";
            str +="결제하기";
            str +="</button>";
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