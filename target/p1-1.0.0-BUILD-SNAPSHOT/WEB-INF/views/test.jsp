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

</head>
<body>
<div class="container">
    <h2 class="writing-header">POST 작성</h2>
    <form id="form" class="frm" action="" method="post">

        <h3>제목</h3>
        <input name="title" type="text" placeholder="제목을 입력해 주세요."><br>
        <h3>간단한 설명</h3>
        <input name="main_content" type="text" placeholder="공간을 간략히 설명해주세요."><br>
        <h3>상세한 설명</h3>
        <textarea name="detail_content" rows="20" placeholder=" 내용을 입력해 주세요." ></textarea><br>


        <h3>카테고리</h3>
        <div class="category_area">
            <div class="temp-box">
                <label><input type="checkbox" name="category" value="party">파티</label>
                <label><input type="checkbox" name="category" value="date">데이트</label>
                <label><input type="checkbox" name="category" value="station">역근처</label>
            </div>
            <div class="temp-box">
                <label><input type="checkbox" name="category" value="studio">스튜디오</label>
                <label><input type="checkbox" name="category" value="bbq">바베큐</label>
                <label><input type="checkbox" name="category" value="singing_room">노래방</label>
            </div>
            <div class="temp-box">
                <label><input type="checkbox" name="category" value="bridal_shower">브라이덜샤워</label>
                <label><input type="checkbox" name="category" value="board_game">보드게임</label>
                <label><input type="checkbox" name="category" value="board_game">영화</label>
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
        <input type="text" name="hours_cost" id="cost" onkeyup="commas(this)"/>
        <h3>운영시간</h3>
        시작시간<input type="time" id="s_time" min="08:00:00" max="24:00:00">
        <input type="hidden" id="stime" name="start_time" >
        끝나는시간<input type="time" id="e_time" min="08:00:00" max="24:00:00">
        <input type="hidden" id="etime" name="end_time" >
        <button type="button" id="writeBtn" class="btn btn-write"><i class="fa fa-pencil"></i> 등록</button>
    </form>
</div>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    $(document).ready(function(){
        $("#writeBtn").on("click", function(){
            $('#stime').val($('#s_time').val());
            $('#etime').val($('#e_time').val());

            /*var str1=$('#address2').val();
            var str2 = $('#address3').val();
            var str=str1.concat(" ",str2);
            $('#address').val(str);*/

            $('#address').val($('#address2').val()+" "+$('#address3').val());
            let form = $("#form");
            form.attr("action", "<c:url value='/test'/>");
            form.attr("method", "post");
            /*if(formCheck())
                form.submit();*/
            form.submit();
        });
    });

    /*가격 입력받기*/
    function commas(t) {
        // 콤마 빼고
        var x = t.value;
        x = x.replace(/,/gi, '');

        // 숫자 정규식 확인
        var regexp = /^[0-9]*$/;
        if(!regexp.test(x)){
            $(t).val("");
            alert("숫자만 입력 가능합니다.");
        } else {
            x = x.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
            $(t).val(x);
        }

    }
    /*다음 주소 연동*/
    function execution_daum_address(){
        new daum.Postcode({
            oncomplete:function(data){
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
                if(data.userSelectedType === 'R'){
                    // 법정동명이 있을 경우 추가한다. (법정리는 제외)
                    // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
                    if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
                        extraAddr += data.bname;
                    }
                    // 건물명이 있고, 공동주택일 경우 추가한다.
                    if(data.buildingName !== '' && data.apartment === 'Y'){
                        extraAddr += (extraAddr !== '' ? ', ' + data.buildingName : data.buildingName);
                    }
                    // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
                    if(extraAddr !== ''){
                        extraAddr = ' (' + extraAddr + ')';
                    }
                    addr += extraAddr;

                } else {
                    addr += ' ';
                }
                document.getElementById("address1").value = data.zonecode;
                document.getElementById("address2").value = addr;

                // 커서를 상세주소 필드로 이동한다.
                document.getElementById("address3").readOnly=false;
                document.getElementById("address3").focus();

            }
        }).open();
    }
</script>
</body>
