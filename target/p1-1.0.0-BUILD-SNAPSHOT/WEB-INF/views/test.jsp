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
<form  id="join_form">
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
    ● 날짜 : ${scheduleDto.year}년 ${scheduleDto.month}월 ${scheduleDto.day}일<br>
    ● 시간 :<br>
    <c:forEach var="str" items="${list}">
        >> ${str}<br>
    </c:forEach>
    ● 최종 비용 : ${totCost}<br>
    <br>
    <br>
    <div class="join_button_wrap">
        <input type="button" class="join_button" value="결제">
    </div>
    <br>
    <br>
</form>
<script>

</script>
</body>
</html>