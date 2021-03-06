<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jstl/core_rt" %>
<%@ page session="true"%>
<!DOCTYPE html>
<html>
<head>
    <script src="https://code.jquery.com/jquery-1.11.3.js"></script>
    <meta charset="UTF-8">
    <title>여기다!</title>
    <link rel="stylesheet" href="/resources/css/admin/write.css" type="text/css">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

</head>
<body>
<script>
    let msg = "${param.msg}";
    if(msg=="postERR") alert("게시글 등록이 실패되었습니다.");
    if(msg=="modifyOK") alert("수정이 완료되었습니다");
</script>
<div class="container">
    <h2 class="writing-header">POST 수정</h2>
    <form id="form" class="frm" action="" method="post">
        <input type="hidden" name="pno" id="pno" value="${postDto.pno}">
        <br>
        <h3>제목</h3>
        <input name="title" type="text" placeholder="제목을 입력해 주세요." value="<c:out value='${postDto.title}'/>"><br>
        <br>
        <h3>간단한 설명</h3>
        <input name="main_content" type="text" placeholder="공간을 간략히 설명해주세요." value="${postDto.main_content}"><br>
        <br>
        <h3>상세한 설명</h3>
        <textarea name="detail_content" rows="20" placeholder=" 내용을 입력해 주세요.">${postDto.detail_content}</textarea><br>
        <br>

        <h3>카테고리</h3><br>
        <div class="category_area">
            <div class="temp-box">
                <label><input type="checkbox" name="category" id="파티" value="파티">파티</label>
                <label><input type="checkbox" name="category" id="데이트" value="데이트">데이트</label>
                <label><input type="checkbox" name="category" id="역근처" value="역근처">역근처</label>
            </div>
            <div class="temp-box">
                <label><input type="checkbox" name="category" id="스튜디오" value="스튜디오">스튜디오</label>
                <label><input type="checkbox" name="category" id="바베큐" value="바베큐">바베큐</label>
                <label><input type="checkbox" name="category" id="노래방" value="노래방">노래방</label>
            </div>
            <div class="temp-box">
                <label><input type="checkbox" name="category" id="브라이덜샤워" value="브라이덜샤워">브라이덜샤워</label>
                <label><input type="checkbox" name="category" id="보드게임" value="보드게임">보드게임</label>
                <label><input type="checkbox" name="category" id="영화" value="영화">영화</label>
            </div>
        </div>
        <br>
        <h3>이미지</h3><br>
        <div class="form_section">
            <div class="form_section_title">
                <label>상품 이미지</label>
            </div>
            <div class="form_section_content">
                <input type="file" id ="fileItem" name='uploadFile'  multiple>
                <div id="uploadResult">
                </div>
            </div>
        </div>
        <br>
        <h3>주소</h3>
        <div class="address_input">
            <div class="address_input_wrap">
                <input class="address_input_1" id="address1" placeholder="우편주소" readonly>
                <input class="address_button" type="button" value="우편번호 찾기" onClick="execution_daum_address()">
            </div>
            <input class="address_input_2" id="address2" placeholder="주소"  value = "${postDto.area_info}" readonly ><%----%>

            <input class="address_input_3" type="text" id="address3" placeholder="상세주소" value = "${postDto.detail_area}" readonly>
            <input type="hidden" id="area_info" name="area_info" >
            <input type="hidden" id="detail_area" name="detail_area" >
        </div>
        <br>
        <h3>시간당 가격</h3>
        <input type="text" name="hourly_cost" id="cost" value="${postDto.hourly_cost}" onkeyup="commas(this)"/>

        <br>
        <button type="button" id="modifyBtn" ><i class="fa fa-pencil"></i>수정</button>

        <br>
    </form>
</div>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script>

    $(document).ready(function(){

        let strArr = "${postDto.category}";
        let arr=strArr.split(',');
        //카테고리 체크
        if(strArr!=''){
            for(let i=0;i<arr.length;i++){
                let id = document.getElementById(arr[i]);
                id.checked=true;
            }
        }
        //세부주소 입력란 활성화
        let detail_area = "${postDto.detail_area}";
        if(detail_area!=''){
            document.getElementById("address3").readOnly = false;
        }

        let area_info="${postDto.area_info}";
        if(area_info!=""){
            $('#address2').val(area_info);
        }

        $("#modifyBtn").on("click", function(){
            $('#area_info').val($('#address2').val());
            $('#detail_area').val($('#address3').val());


            if(!formCheck()){return false;}

            let form = $("#form");
            form.attr("action", "<c:url value='/post/modify'/>");
            form.attr("method", "post");
            /*if(formCheck())
                form.submit();*/
            form.submit();
        });
    });


    //이미지 삭제
    function deleteFile(filePath,fileFullName){

        //let targetFile=$(".imgDeleteBtn").data("file");
        let fileCallPath =filePath+"/"+fileFullName;
        let div_id = "result_card"+"_"+fileFullName;

        let targetDiv = document.getElementById(div_id);//이미지를 감싸고 있는 태그

        $.ajax({
            url:'/deleteFile',
            data:{fileName:fileCallPath},
            dataType:'text',
            type:'POST',
            success:function(result){
                targetDiv.remove();
                $("input[type='file']").val("");
            },
            error : function (result){
                console.log(result);
                alert("파일을 삭제하지 못하였습니다.")
            }
        });
    }

    //이미지 업로드
    $("input[type='file']").on("change",function(e){

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
            formData.append("multipartFiles",fileList[i]);
        }
        $.ajax({
            type : 'POST',
            url:'/uploadAjaxAction',
            processData : false, //서버로 전송할 데이터를 queryString형태로 변환할지 여부
            contentType : false, //서버로 전송되는 데이터의 content-type
            data : formData, //서버로 전송할 데이터
            dataType : 'json',//전송받을 데이터 타입

            success : function (result){
                showUploadImage(result);
            },
            error : function(result){
                console.log(result);
                alert("이미지 파일이 아닙니다.");
            }
        });

    });

    //이미지 출력
    function showUploadImage(uploadResultArr){
        //데이터 검증
        if(!uploadResultArr || uploadResultArr.length==0) return;

        let uploadResult = $("#uploadResult");

        for(let i=0;i<uploadResultArr.length;i++){

            let obj=uploadResultArr[i];
            let str="";
            let fileFullName =obj.uuid+"_"+obj.fileName;


            str+="<div id='result_card"+"_"+fileFullName+"'>";
            str+="<div id='result_card'>";
            str+="<img src='/display?filePath="+obj.uploadPath+'&fileUuid='+obj.uuid+'&fileName='+obj.fileName+"'>";
            //str+="<div class='imgDeleteBtn' onclick='deleteFile("+fileCallPath+")'>X</div>";
            //str+="<div class='imgDeleteBtn' data-file='"+fileCallPath+"'>X</div>";
            //str+= "<a class='imgDeleteBtn' href='javascript:void(0);' onclick='deleteFile();' data-file='"+fileCallPath+"'>X</a>";
            str+= "<a class='imgDeleteBtn' href='javascript:void(0);' onclick=\"deleteFile(\'"+obj.uploadPath+"\',\'"+fileFullName+"\');\">X</a>";

            str += "<input type='hidden' name='imageList["+i+"].fileName' value='"+ obj.fileName +"'>";
            str += "<input type='hidden' name='imageList["+i+"].uuid' value='"+ obj.uuid +"'>";
            str += "<input type='hidden' name='imageList["+i+"].uploadPath' value='"+ obj.uploadPath +"'>";
            str+="</div>";
            str+="</div>";

            uploadResult.append(str);
        }
    }




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

    //가격 입력받기
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

    //다음 주소 연동
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
