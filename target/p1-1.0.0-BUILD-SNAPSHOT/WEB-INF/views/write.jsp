<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%@ page session="true"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>post form</title>
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    <script src="https://code.jquery.com/jquery-1.11.3.js"></script>
    <link rel="stylesheet" href="/css/write.css">

</head>
<body>
<div class="container">
    <h2 class="writing-header">POST ${mode=="new" ? "작성" : "수정"}</h2>
    <form id="form" class="frm" action="" method="post">
        <input type="hidden" name="pno" >
        <h3>제목</h3>
        <input name="title" type="text"  value="<c:out value='${boardDto.title}'/>" placeholder="제목을 입력해 주세요."><br>
        <h3>간단한 설명</h3>
        <input name="main_content" type="text" placeholder="공간을 간략히 설명해주세요."><br>
        <h3>상세한 설명</h3>
        <textarea name="detail_content" rows="20" placeholder=" 내용을 입력해 주세요." ></textarea><br>
        <h3>카테고리</h3>
        <div class="category_area">
            <div class="temp-box">
                <label><input type="checkbox" name="category" value="date">파티</label>
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
        <hr>
        <br>
        <%--String[] value = request.getParameterValues("category");--%>
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
            <input class="address_input_3" id="address3" placeholder="상세주소" readonly>
        </div>
        <br>
        <h3>시간당 가격</h3>
        <input type="text" name="hours_cost" id="cost" onkeyup="commas(this)"/>
        <h3>운영시간</h3>
        시작시간<input type="time" name="start_time" min="08:00:00" max="24:00:00">
        끝나는시간<input type="time" name="end_time" min="08:00:00" max="24:00:00">
        <%--시간 제한두기 <input type="time" name="end_time" min="13:00:00" max="15:00:00">--%>



        <c:if test="${mode eq 'new'}">
            <button type="button" id="writeBtn" class="btn btn-write"><i class="fa fa-pencil"></i> 등록</button>
        </c:if><%--
        <c:if test="${mode ne 'new'}">
            <button type="button" id="writeNewBtn" class="btn btn-write"><i class="fa fa-pencil"></i> 글쓰기</button>
        </c:if>
        <c:if test="${boardDto.writer eq loginId}">
            <button type="button" id="modifyBtn" class="btn btn-modify"><i class="fa fa-edit"></i> 수정</button>
            <button type="button" id="removeBtn" class="btn btn-remove"><i class="fa fa-trash"></i> 삭제</button>
        </c:if>

        <button type="button" id="listBtn" class="btn btn-list"><i class="fa fa-bars"></i> 목록</button>--%>
    </form>
</div>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>
    //checkbox선택된 요소 값 불러오기





    /* Post 등록하기 */
    $(document).ready(function(){
        let formCheck = function() {
            let form = document.getElementById("form");
            if(form.title.value=="") {
                alert("제목을 입력해 주세요.");
                form.title.focus();
                return false;
            }
            if(form.content.value=="") {
                alert("내용을 입력해 주세요.");
                form.content.focus();
                return false;
            }
            if(form.main_content.value=="") {
                alert("간단히 내용을 입력해 주세요.");
                form.content.focus();
                return false;
            }
            if(form.detail_content.value=="") {
                alert("상세 내용을 입력해 주세요.");
                form.content.focus();
                return false;
            }
            if($(".address_input_3").value==""){
                alert("상세 주소를 입력해 주세요.")
                form.content.focus();
                return false
            }
            return true;
        }
        $("#writeBtn").on("click", function(){
            var chk_arr=[]
            $("input[name=checkbox]:checked").each(function(){
                var chk=$(this).val();
                chk_arr.push(chk);
            })

            let form = $("#form");
            form.attr("action", "<c:url value='/post/write'/>");
            form.attr("method", "post");
            /*if(formCheck())
                form.submit();*/
            form.submit();
        });
    });


    /* 이미지 업로드 */
    $("input[type='file']").on("change",function(e){
        //이미지 존재시 삭제
        if($(".imgDeleteBtn").length>0){
            deleteFile();
        }
        let formData = new FormData();
        let fileInput = $('input[name="uploadFile"]');
        let fileList = fileInput[0].files; //파일리스트 접근
        let fileObj = fileList[0]; //파일객체 접근
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
/*
    /!*이미지 파일형식, 크기제한*!/
    let regex = new RegExp("(.*?)\.(jpg|png)$");
    let maxSize = 1048576; //1MB

    function fileCheck(fileName, fileSize){
        if(fileSize >= maxSize){
            alert("파일 사이즈 초과");
            return false;
        }
        if(!regex.test(fileName)){
            alert("해당 종류의 파일은 업로드할 수 없습니다.");
            return false;
        }

        return true;

    }*/


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
                    /*// 조합된 참고항목을 해당 필드에 넣는다.
                    document.getElementById("sample6_extraAddress").value = extraAddr;*/
                    // 주소변수 문자열과 참고항목 문자열 합치기
                    addr += extraAddr;

                } else {
                    /*document.getElementById("sample6_extraAddress").value = '';*/
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

</script>
</body>
</html>