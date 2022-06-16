<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.net.URLDecoder"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <script src="https://kit.fontawesome.com/92d2245491.js" crossorigin="anonymous"></script>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <style>
        form {
            width:700px;
            height:auto;
            display : flex;
            flex-direction: column;
            align-items:center;
            position : absolute;
            top:50%;
            left:50%;
            transform: translate(-50%, -50%) ;
            border: 1px solid rgb(89,117,196);
            border-radius: 10px;
        }
        label {
            width:300px;
            height:30px;
            margin-top :4px;
        }
        button {
            background-color: rgb(89,117,196);
            color : white;
            width:300px;
            height:50px;
            font-size: 25px;
            border : none;
            border-radius: 5px;
            margin : 20px 0 30px 0;
        }
        .title {
            font-size: 30px;
            margin: 40px 0 30px 0;
        }
        .join_button_wrap{
            margin-top: 40px;
            text-align: center;
        }
        .join_button {
            width: 100%;
            height: 40px;
            background-color: #6AAFE6;
            font-size: 20px;
            font-weight: 900;
            color: white;
        }
        .back_btn{
            width: 100%;
            height: 100px;
        }
        .btn:before{
            font-family: "FontAwesome";content:"\f359";
            font-size:50px;
            color:rgb(89,117,196);
        }
        a{
            text-decoration:none;
        }

    </style>

    <title>Register</title>
    <script src="https://code.jquery.com/jquery-1.11.3.js"></script>
    <script
            src="https://code.jquery.com/jquery-3.4.1.js"
            integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
            crossorigin="anonymous">

    </script>
</head>
<body>
<c:if test="${mode=='pay'}">
<%--    <button type="button"><a href="/detail?pno=${scheduleDto.pno}">◀ 돌아가기</a></button>--%>
    <div class="back_btn">
        <a href="/detail?pno=${scheduleDto.pno}" class="btn"></a>
    </div>
</c:if>
<c:if test="${mode!='pay'}">
    <div class="back_btn">
        <a href="/user/bookingList" class="btn"></a>
    </div>
<%--    <button type="button"><a href="/user/bookingList">◀ 돌아가기</a></button>--%>
</c:if>
<form  id="pay_form" method="post" action="<c:url value='/pay'/>">

    <div class="title">[${mode=="pay"?"결제확인":"예약내역 확인"}]</div>
    <h1>${scheduleDto.title}</h1>
    <h2>${scheduleDto.main_content}</h2>
    <h3>★위치★</h3>
    ${scheduleDto.area_info}
    <h3>★HOST정보★</h3>
    ● nickName : ${scheduleDto.writer}<br>
    ● phoneNumber : ${scheduleDto.phone_number}<br>
    ● e-mail : ${scheduleDto.email}
    <hr>
    <h3>★예약 정보★</h3>
    ● 예약자 : ${scheduleDto.book_user}<br>
    ● 날짜 : ${scheduleDto.year}년 ${scheduleDto.month}월 ${scheduleDto.day}일<br>
    ● 시간 :<br>
    <c:forEach var="str" items="${list}">
        >> ${str}<br>
    </c:forEach>
    <br>
    ● 최종 비용 : ${scheduleDto.totCost}<br>
    <br>
    <br>
    <div id="payBtm"> <%--style=${mode=="check"?"display:none;":""}--%>
        <c:if test="${mode=='check'}">
            <button type="button" ><a href="/user/bookingList">확인</a></button>
            <button type="button" onclick="delBook()">예약 취소</button>
        </c:if>
        <c:if test="${mode!='check'}">
            <button type="button" onclick="go()">결제하기</button>
        </c:if>


    </div>
    <br>
    <br>
</form>
<script>
    function delBook(){
        let check = confirm("예약을 취소하시겠습니까?");
        if(check){
            let no=${scheduleDto.no};

            let form=document.createElement('form');
            form.setAttribute('method','post');
            form.setAttribute('action','/user/delBook');
            document.charset="utf-8";

            let noField=document.createElement('input');
            noField.setAttribute('type','hidden');
            noField.setAttribute('name','no');
            noField.setAttribute('value',no);
            form.appendChild(noField);

            document.body.appendChild(form);
            form.submit();
        }
    }


    function go(){
        let pno=${scheduleDto.pno};
        let year=${scheduleDto.year};
        let month=${scheduleDto.month};
        let day=${scheduleDto.day};
        let time='${scheduleDto.time}';
        let book_user='${scheduleDto.book_user}';
        let totCost=${scheduleDto.totCost};

        let form=document.createElement('form');
        form.setAttribute('method','post');
        form.setAttribute('action','/pay');
        document.charset="utf-8";

        let totCostField=document.createElement('input');
        totCostField.setAttribute('type','hidden');
        totCostField.setAttribute('name','totCost');
        totCostField.setAttribute('value',totCost);
        form.appendChild(totCostField);

        let pnoField=document.createElement('input');
        pnoField.setAttribute('type','hidden');
        pnoField.setAttribute('name','pno');
        pnoField.setAttribute('value',pno);
        form.appendChild(pnoField);

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

        let timeField=document.createElement('input');
        timeField.setAttribute('type','hidden');
        timeField.setAttribute('name','time');
        timeField.setAttribute('value',time);
        form.appendChild(timeField);

        let userField=document.createElement('input');
        userField.setAttribute('type','hidden');
        userField.setAttribute('name','book_user');
        userField.setAttribute('value',book_user);
        form.appendChild(userField);

        document.body.appendChild(form);
        form.submit();

    }
</script>
</body>
</html>