<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>

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
            height: 300px;
        }

        .content_area{
            width: 100%;
            background-color: lemonchiffon;
            height: 2000px;

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
        #result_card img{
            width: 70%;
            height: 300px;
            display: block;
            padding: 5px;
            margin-top: 10px;
            margin: auto;
        }

    </style>
</head>
<body>
<div class="wrapper">
    <div class="wrap">
        <div class="top_area" style="background: #7696fd">
            <h1>${postDto.title}</h1>
            <h2>${postDto.main_content}</h2>
            <h3>${postDto.category}</h3>
        </div>
        <div class="content_area">
            <div class="space_list">
                    <div class="parent">
                        <div class="child" style="background: #2E9AFE;">
                            <div id="uploadResult">
                            </div>
                            <div class="text_area">
                                <h2>상세설명</h2>
                                <h3>${postDto.detail_content}</h3>
                                <h2>위치</h2>
                                <h3>${postDto.area_info}</h3>
                                <h2>댓글</h2>
                                <h3>댓글리스트 나중에 출력</h3>
                            </div>
                        </div>
                        <div class="blank"></div>
                        <div class="child" style="background: #FA5858;">
                            예약페이지
                        </div>
                    </div>
            </div>
        </div>
    </div>
</div>
<script src="https://code.jquery.com/jquery-3.4.1.js"></script>
<script>
    //이미지 띄우기
    $(document).ready(function(){
        /*let pno = '<c:out value="${postDto.pno}"/>';*/
        let uploadResult=$("#uploadResult");
        let pno=${postDto.pno};
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
                let fileCallPath = encodeURIComponent(obj.uploadPath + "/s_"+obj.uuid + "_" + obj.fileName);
                str += "<div id='result_card'";
                str += "data-path='" + obj.uploadPath + "' data-uuid='" + obj.uuid + "' data-filename='" + obj.fileName + "'";
                str +=">";
                str += "<img src='/display?fileName=" + fileCallPath + "'>";
                str += "</div>";

                uploadResult.append(str);

            }
        });
    });
</script>
</body>
</html>