<%@ page contentType="text/html;charset=utf-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page import="java.net.URLDecoder"%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/css/member/join.css">

    <title>Register</title>
    <script src="https://code.jquery.com/jquery-1.11.3.js"></script>
    <script
            src="https://code.jquery.com/jquery-3.4.1.js"
            integrity="sha256-WpOohJOqMqqyKL9FccASB9O0KwACQJpFTUBLTYOVvVU="
            crossorigin="anonymous"></script>

</head>
<body>
<%--action="<c:url value="/member/join"/>"--%>
<form  id="join_form" method="post" onsubmit="return formCheck(this)">
    <div class="title">회원가입</div>
    <div id="msg" class="msg">
        <c:if test="${not empty param.msg}">
            <i class="fa fa-exclamation-circle"> ${URLDecoder.decode(param.msg)}</i>
        </c:if>
    </div>
    <label for="">아이디</label>
    <input class="input-field" id="id_input" type="text" name="id" maxlength="10" placeholder="3자리 이상 영대소문자와 숫자 조합">
    <span class="id_input_re_1">사용 가능한 아이디입니다.</span>
    <span class="id_input_re_2">아이디가 이미 존재합니다.</span>
    <span class="id_input_len">id의 길이는 3이상이어야 합니다.</span>
    <span class="final_id_ck">아이디를 입력해주세요.</span>
    <label for="">비밀번호</label>
    <input class="input-field" id="pwd_input" type="text" name="pwd" placeholder="3자리 이상 영대소문자와 숫자 조합">
    <span class="final_pwd_ck">비밀번호를 입력해주세요.</span>
    <label for="">비밀번호 확인</label>
    <input class="input-field" id="pwd2_input" type="text" name="pwd2" placeholder="다시한번 입력해주세요.">
    <span class="pwd2_input_re_1">비밀번호가 일치합니다.</span>
    <span class="pwd2_input_re_2">비밀번호가 일치하지 않습니다.</span>
    <span class="final_pwd2_ck">비밀번호 확인을 입력해주세요.</span>
    <label for="">이름</label>
    <input class="input-field" id="name_input" type="text" name="name" placeholder="홍길동">
    <span class="final_name_ck">이름을 입력해주세요.</span>
    <label for="">연락처</label>
    <input class="input-field" id="phone_number_input" type="text" name="phone_number" placeholder="'-'없이 입력">
    <span class="final_phone_number_ck">연락처를 입력해주세요.</span>
    <div>
        <label><input type="checkbox" id="masterCheck" onclick="toggle1()"/>관리자로 가입하십니까?</label>
    </div>

    <label for="" id="emaillabel">이메일</label>
    <input class="input-field"  type="text" id="email" name="email" placeholder="example@fastcampus.co.kr">
    <span class="final_email_ck">이메일을 입력해주세요.</span>
    <span class="mail_input_box_warn"></span>


    <div class="join_button_wrap">
        <input type="button" class="join_button" value="가입하기">
    </div>
<%--    <button>회원 가입</button>--%>
</form>
<script>
    /* 유효성 검사 통과유무 변수 */
    var idCheck = false;            // 아이디
    var idckCheck = false;            // 아이디 중복 검사
    var pwdCheck = false;            // 비번
    var pwd2Check = false;            // 비번 확인
    var pwdeqCheck = false;        // 비번 확인 일치 확인
    var nameCheck = false;            // 이름
    var phoneCheck = false;         // 휴대전화 번호 확인
    var mailCheck = false;            // 이메일

    $(document).ready(function(){
        $(".join_button").click(function(){

            /* 입력값 변수 */
            var id = $('#id_input').val();                 // id 입력란
            var pwd = $('#pwd_input').val();                // 비밀번호 입력란
            var pwd2 = $('#pwd2_input').val();            // 비밀번호 확인 입력란
            var name = $('#name_input').val();            // 이름 입력란
            var phone_number = $('#phone_number').val();        // 주소 입력란
            var email = $('#email').val();            // 이메일 입력란

            //아이디 유효성검사(공백)
            if(id==""){
                $('.final_id_ck').css("display","block");
                idCheck=false;
            }else{
                $('.final_id_ck').css("display","none");
                idCheck=true;
            }

            //비밀번호 유효성 검사
            if(pwd==""){
                $('.final_pwd_ck').css("display","block");
                pwdCheck=false;
            }else{
                $('.final_pwd_ck').css("display","none");
                pwdCheck=true;
            }

            //비밀번호 확인 유효성 검사
            if(pwd==""){
                $('.final_pwd2_ck').css("display","block");
                pwd2Check=false;
            }else{
                $('.final_pwd2_ck').css("display","none");
                pwd2Check=true;
            }
            //이름 유효성 검사
            if(name==""){
                $('.final_name_ck').css("display","block");
                nameCheck=false;
            }else{
                $('.final_name_ck').css("display","none");
                nameCheck=true;
            }

            //핸드폰번호 유효성 검사
            if(phone_number==""){
                $('.final_phone_number_ck').css("display","block");
                phoneCheck=false;
            }else{
                $('.final_phone_number_ck').css("display","none");
                phoneCheck=true;
            }

///////email 관리자 체크되어있을 경우
            if($('#masterCheck').is(':checked')){
                if(email==""){
                    $('.final_email_ck').css("display","block");
                    emailCheck=false;
                }else{
                    $('.final_email_ck').css("display","none");
                    emailCheck=true;
                }
            }else{
                emailCheck=true;
            }
            if(idCheck&&idckCheck&&pwdCheck&&pwd2Check&&pwdeqCheck&&nameCheck&&emailCheck&&emailCheck&&phoneCheck ){
                $("#join_form").attr("action", "/member/join");
                $("#join_form").submit();

            }
            return false;


        });
    });
    $('#pwd2_input').on("propertychange change keyup paste input",function(){
        //입력할 때마다 초기화
        var pwd=$('#pwd_input').val();
        var pwd2=$('#pwd2_input').val();
        $('.final_pwd2_ck').css('display','none');

        if(pwd==pwd2){
            $('.pwd2_input_re_1').css('display','block');
            $('.pwd2_input_re_2').css('display','none');
            pwdeqCheck=true;
        }else{
            $('.pwd2_input_re_2').css('display','block');
            $('.pwd2_input_re_1').css('display','none');
            pwdeqCheck=false;
        }
    });

    //아이디 중복검사
    $('#id_input').on("propertychange change keyup paste input",function(){
        // console.log("keyup 테스트");
        var memberId=$('#id_input').val();
        var data={memberId:memberId}// '컨트롤에 넘길 데이터 이름' : '데이터(.id_input에 입력되는 값)'
        $.ajax({
            type:"post",
            url:"/member/memberIdCheck",
            data:data,
            success:function(result){
                // console.log("성공여부"+result);
                if(result=='fail'){
                    $('.id_input_re_2').css("display","inline-block");
                    $('.id_input_re_1').css("display","none");
                    $('.id_input_len').css("display","none");
                    idckCheck=false;

                }else if(result=="success"){
                    $('.id_input_re_1').css("display","inline-block");
                    $('.id_input_re_2').css("display","none");
                    $('.id_input_len').css("display","none");
                    idckCheck=true;

                }else if(result=="lenCheck"){
                    $('.id_input_re_2').css("display","none");
                    $('.id_input_re_1').css("display","none");
                    $('.id_input_len').css("display","inline-block");
                }
            }
        });
    });

    email.style.display = 'none';
    emaillabel.style.display = 'none';
    function formCheck(frm) {
        let msg ='';
        if(frm.id.value.length<3) {
            setMessage('id의 길이는 4이상이어야 합니다.', frm.id);
            return false;
        }
        if(frm.pwd.value.length<3) {
            setMessage('pwd의 길이는 4이상이어야 합니다.', frm.pwd);
            return false;
        }

        if(frm.pwd.value != frm.pwd2.value){
            setMessage("입력한 비밀번호와 다릅니다",frm.pwd2)
            return false;
        }

        return true;
    }
    function setMessage(msg, element){
        document.getElementById("msg").innerHTML = `<i class="fa fa-exclamation-circle"> ${'${msg}'}</i>`;
        if(element) {
            element.select();
        }
    }

    function toggle1(){
        // 토글 할 버튼 선택 (btn1)
        const email = document.getElementById('email');

        // 보이기
        if(email.style.display !== 'block') {
            email.style.display = 'block';
            emaillabel.style.display = 'block';
        }
        // 숨기기
        else {
            email.style.display = 'none';
            emaillabel.style.display = 'none';
        }
    }

    // //이메일 형식 유효성 검사
    // function mailFormCheck(email){
    //     var form = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i;
    //     return form.test(email);
    // }


</script>
</body>
</html>