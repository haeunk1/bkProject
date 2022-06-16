


<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <script src="https://code.jquery.com/jquery-1.11.3.js"></script>

    <meta charset="UTF-8">
    <title>Welcome BookingSite</title>

</head>
<body>


<form id="form" class="frm" action="" method="post">

    <input type="file" id ="fileItem" name='uploadFile' >
    <div id="uploadResult"></div>

    <button type="button" id="writeBtn" class="btn btn-write"><i class="fa fa-pencil"></i> 등록</button>
</form>

<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<script>
    /* 이미지 업로드 */
    $("input[type='file']").on("change",function(e){

        let formData = new FormData();
        let fileInput = $('input[name="uploadFile"]');
        let fileList = fileInput[0].files; //파일리스트 접근
        let fileObj = fileList[0];
        formData.append("uploadFile",fileObj);

        $.ajax({
            type : 'POST',
            url:'/test1',
            processData : false, //서버로 전송할 데이터를 queryString형태로 변환할지 여부
            contentType : false, //서버로 전송되는 데이터의 content-type
            data : formData, //서버로 전송할 데이터
            dataType : 'json',//전송받을 데이터 타입

            success : function (result){
                alert("성공");
            }
        });

    });
</script>
</body>

</html>