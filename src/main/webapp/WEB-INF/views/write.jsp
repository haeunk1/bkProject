<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%@ page session="true"%>
<!DOCTYPE html>
<html>
<head>
    <script src="https://code.jquery.com/jquery-1.11.3.js"></script>
    <meta charset="UTF-8">
    <title>post form</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <style>
        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
            font-family: "Noto Sans KR", sans-serif;
        }
        .container {
            width : 50%;
            margin : auto;
        }
        .writing-header {
            position: relative;
            margin: 20px 0 0 0;
            padding-bottom: 10px;
            border-bottom: 1px solid #323232;
        }
        input {
            width: 100%;
            height: 35px;
            margin: 5px 0px 10px 0px;
            border: 1px solid #e9e8e8;
            padding: 8px;
            background: #f8f8f8;
            outline-color: #e6e6e6;
        }
        textarea {
            width: 100%;
            background: #f8f8f8;
            margin: 5px 0px 10px 0px;
            border: 1px solid #e9e8e8;
            resize: none;
            padding: 8px;
            outline-color: #e6e6e6;
        }
        .frm {
            width:100%;
        }
        .btn {
            background-color: rgb(236, 236, 236); /* Blue background */
            border: none; /* Remove borders */
            color: black; /* White text */
            padding: 6px 12px; /* Some padding */
            font-size: 16px; /* Set a font size */
            cursor: pointer; /* Mouse pointer on hover */
            border-radius: 5px;
        }
        .btn:hover {
            text-decoration: underline;
        }
        .category_area{
            width:100%;
            margin:auto;
            display:grid;

            grid-template-columns: 33% 33% 33%;
            gap:10px
        }
        .temp-box{
            width:100%;
            height:100%;
            font-size:20px;
            text-align:left;
        }


        #result_card img{
            max-width: 100%;
            height: auto;
            display: block;
            padding: 5px;
            margin-top: 10px;
            margin: auto;
        }
        #result_card {
            position: relative;
        }
        .imgDeleteBtn{
            position: absolute;
            top: 0;
            right: 5%;
            background-color: #ef7d7d;
            color: wheat;
            font-weight: 900;
            width: 30px;
            height: 30px;
            border-radius: 50%;
            line-height: 26px;
            text-align: center;
            border: none;
            display: block;
            cursor: pointer;
        }
    </style>
</head>
<body>
<script>
    let msg = "${param.msg}";
    if(msg=="postERR") alert("게시글 등록이 실패되었습니다.");
</script>
<div class="container">
    <h2 class="writing-header">POST 작성</h2>
    <form id="form" class="frm" action="" method="post">

        <h3>제목</h3>
        <input name="title" type="text" placeholder="제목을 입력해 주세요." value="${postDto.title}"><br>
        <h3>간단한 설명</h3>
        <input name="main_content" type="text" placeholder="공간을 간략히 설명해주세요." value="${postDto.main_content}"><br>
        <h3>상세한 설명</h3>
        <textarea name="detail_content" rows="20" placeholder=" 내용을 입력해 주세요.">${postDto.detail_content}</textarea><br>


        <h3>카테고리</h3>
        <div class="category_area">
            <div class="temp-box">
                <label><input type="checkbox" name="category" value="파티">파티</label>
                <label><input type="checkbox" name="category" value="데이트">데이트</label>
                <label><input type="checkbox" name="category" value="역근처">역근처</label>
            </div>
            <div class="temp-box">
                <label><input type="checkbox" name="category" value="스튜디오">스튜디오</label>
                <label><input type="checkbox" name="category" value="바베큐">바베큐</label>
                <label><input type="checkbox" name="category" value="singing_room">노래방</label>
            </div>
            <div class="temp-box">
                <label><input type="checkbox" name="category" value="브라이덜샤워">브라이덜샤워</label>
                <label><input type="checkbox" name="category" value="보드게임">보드게임</label>
                <label><input type="checkbox" name="category" value="영화">영화</label>
            </div>
        </div>
        <br>

        <h3>이미지</h3>
        <div class="form_section">
            <div class="form_section_title">
                <label>상품 이미지</label>
            </div>
            <div class="form_section_content">
                <input type="file" id ="fileItem" name='uploadFile'  multiple>
                <div id="uploadResult"></div>
            </div>
        </div>
        <br>


        <h3>주소</h3>
        <div class="address_input">
            <div class="address_input_wrap">
                <input class="address_input_1" id="address1" placeholder="우편주소" readonly>
                <input class="address_button" type="button" value="우편번호 찾기" onClick="execution_daum_address()">
            </div>
            <input class="address_input_2" id="address2" placeholder="주소" readonly>

            <input class="address_input_3" type="text" id="address3" placeholder="상세주소" readonly>
            <input type="hidden" id="address" name="area_info" >
        </div>

        <h3>시간당 가격</h3>
        <input type="text" name="hourly_cost" id="cost" value="${postDto.main_content}" onkeyup="commas(this)"/>

        <%--
        <h3>운영시간</h3>
        시작시간<input type="time" id="s_time" min="08:00:00" max="24:00:00">
        <input type="hidden" id="stime" name="start_time" >
        끝나는시간<input type="time" id="e_time" min="08:00:00" max="24:00:00">
        <input type="hidden" id="etime" name="end_time" >
        --%>

        <button type="button" id="writeBtn" class="btn btn-write"><i class="fa fa-pencil"></i> 등록</button>
    </form>
</div>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>

    /* 이미지 업로드 */
    $("input[type='file']").on("change",function(e){
        //이미지 존재시 삭제
        if($(".imgDeleteBtn").length>0){
            deleteFile();
        }
        let formData = new FormData();
        let fileInput = $('input[name="uploadFile"]');
        let fileList = fileInput[0].files; //파일리스트 접근


        //let fileObj = fileList[0]; //파일객체 접근
        //for문으로 전체 검사해야함

        /*
                if(!fileCheck(fileObj.name,fileObj.size)){
                    return false;
                }
                */
        //서버에 전송할 파일들을 formData에 업로드
        for(let i=0; i<fileList.length;i++){
            formData.append("uploadFile",fileList[i]);
        }
        $.ajax({
            type : 'POST',
            url:'/uploadAjaxAction',
            processData : false, //서버로 전송할 데이터를 queryString형태로 변환할지 여부
            contentType : false, //서버로 전송되는 데이터의 content-type
            data : formData, //서버로 전송할 데이터
            dataType : 'json',//전송받을 데이터 타입

            success : function (result){
                console.log(result);
                showUploadImage(result);
            },
            error : function(result){
                console.log(result)
                alert("이미지 파일이 아닙니다.")
            }
        });

    });

    /*이미지 출력*/
    function showUploadImage(uploadResultArr){
        //데이터 검증
        if(!uploadResultArr || uploadResultArr.length==0) return

        let uploadResult = $("#uploadResult");

        for(let i=0;i<uploadResultArr.length;i++){
            console.log(i);

            let obj=uploadResultArr[i];
            let str=""; //div태그 내부에 이미지를 출력하는 태그 코드들을 추가
            let fileCallPath =encodeURIComponent(obj.uploadPath+"/s_"+obj.uuid+"_"+obj.fileName);

            str+="<div id='result_card'>";
            str+="<img src='/display?fileName="+fileCallPath+"'>";
            str+="<div class='imgDeleteBtn' data-file='"+fileCallPath+"'>X</div>";
            str += "<input type='hidden' name='imageList["+i+"].fileName' value='"+ obj.fileName +"'>";
            str += "<input type='hidden' name='imageList["+i+"].uuid' value='"+ obj.uuid +"'>";
            str += "<input type='hidden' name='imageList["+i+"].uploadPath' value='"+ obj.uploadPath +"'>";
            str+="</div>";

            uploadResult.append(str);
        }

        //파일 삭제 메서드
        function deleteFile(){
            let targetFile=$(".imgDeleteBtn").data("file");//"file":썸네일 경로 데이터
            let targetDiv = $("#result_card");//이미지를 감싸고 있는 태그
            $.ajax({
                url:'/deleteFile',
                data:{fileName:targetFile},
                dataType:'text',
                type:'POST',
                success:function(result){
                    console.log(result);
                    targetDiv.remove();
                    $("input[type='file']").val("");
                },
                error : function (result){
                    console.log(result);
                    alert("파일을 삭제하지 못하였습니다.")
                }
            });
        }

        //이미지 삭제 버튼 동작
        $("#uploadResult").on("click",".imgDeleteBtn",function(e){
            deleteFile();
        });



    }


    $(document).ready(function(){

        $("#writeBtn").on("click", function(){
            // $('#stime').val($('#s_time').val());
            // $('#etime').val($('#e_time').val());
            $('#address').val($('#address2').val()+" "+$('#address3').val());

            if(!formCheck()){return false;}

            let form = $("#form");
            form.attr("action", "<c:url value='/post/write'/>");
            form.attr("method", "post");
            /*if(formCheck())
                form.submit();*/
            form.submit();
        });
    });

    function formCheck() {
        let form = document.getElementById("form");
        if (form.title.value == "") {
            alert("제목을 입력해 주세요.");
            form.title.focus();
            return false;
        }
        if (form.main_content.value == "") {
            alert("간단히 공간을 소개해주세요.");
            form.main_content.focus();
            return false;
        }
        if (form.detail_content.value == "") {
            alert("공간의 상세 내용을 입력해 주세요.");
            form.detail_content.focus();
            return false;
        }
        if ($('#address2').val() == "") {
            alert("주소를 입력해 주세요.");
            form.$('#address2').focus();
            return false;
        }

        if ($('#address3').val() == "") {
            alert("상세 주소를 입력해 주세요.");
            form.$('#address3').focus();
            return false;
        }

        if (form.hourly_cost.value == "") {
            alert("시간당 가격을 입력해 주세요.");
            form.hourly_cost.focus();
            return false;
        }
        return true
    }

    /*가격 입력받기*/
    function commas(t) {
        // 콤마 빼고
        var x = t.value;
        x = x.replace(/,/gi, '');

        // 숫자 정규식 확인
        var regexp = /^[0-9]*$/;
        if (!regexp.test(x)) {
            $(t).val("");
            alert("숫자만 입력 가능합니다.");
        } else {
            x = x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
            $(t).val(x);
        }

    }

    /*다음 주소 연동*/
    function execution_daum_address() {
        new daum.Postcode({
            oncomplete: function (data) {
                //[사용자가 선택한 값 이용하기]
                // 각 주소의 노출 규칙에 따라 주소를 조합한다.
                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
                var addr = ''; // 주소 변수
                var extraAddr = ''; // 참고항목 변수

                //사용자가 선택한 주소 타입에 따라 해당 주소 값을 가져온다.
                if (data.userSelectedType === 'R') { // 사용자가 도로명 주소를 선택했을 경우
                    addr = data.roadAddress;
                } else { // 사용자가 지번 주소를 선택했을 경우(J)
                    addr = data.jibunAddress;
                }

                // 사용자가 선택한 주소가 도로명 타입일때 참고항목을 조합한다.
                if (data.userSelectedType === 'R') {
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if (data.bname !== '' && /[동|로|가]$/g.test(data.bname)) {
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if (data.buildingName !== '' && data.apartment === 'Y') {
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if (extraAddr !== '') {
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    addr += extraAddr;

                } else {
                    addr += ' ';
                }
                document.getElementById("address1").value = data.zonecode;
                document.getElementById("address2").value = addr;

                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("address3").readOnly = false;
                document.getElementById("address3").focus();

            }
        }).open();

    }
</script>
</body>
