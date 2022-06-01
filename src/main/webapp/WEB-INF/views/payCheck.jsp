<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.net.URLDecoder"%>

<!DOCTYPE html>
<html lang="en">
<head>
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
<form  id="pay_form" method="post" action="<c:url value='/pay'/>">

    <div class="title">[결제확인]</div>
    <h1>${postDto.title}</h1>
    <h2>${postDto.main_content}</h2>
    <h3>★위치★</h3>
    ${postDto.area_info}
    <h3>★HOST정보★</h3>
    ● nickName : ${memberDto.id}<br>
    ● phoneNumber : ${memberDto.phone_number}<br>
    ● e-mail : ${memberDto.email}
    <hr>
    <h3>★예약 정보★</h3>
    ● 예약자 : ${id}<br>
    ● 날짜 : ${scheduleDto.year}년 ${scheduleDto.month}월 ${scheduleDto.day}일<br>
    ● 시간 :<br>
    <c:forEach var="str" items="${list}">
        >> ${str}<br>
    </c:forEach>
    ● 최종 비용 : ${totCost}<br>
    <br>
    <br>
    <button type="button" onclick="go()">결제하기</button>
    </div>
    <br>
    <br>
</form>
<script>

    function go(){
        let pno=${postDto.pno};
        let year=${scheduleDto.year};
        let month=${scheduleDto.month};
        let day=${scheduleDto.day};
        let time='${scheduleDto.time}';
        let book_user='${id}';

        let form=document.createElement('form');
        form.setAttribute('method','post');
        form.setAttribute('action','/pay');
        document.charset="utf-8";

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