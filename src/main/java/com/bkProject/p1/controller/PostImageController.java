package com.bkProject.p1.controller;

import com.bkProject.p1.domain.AttachImageDto;
import net.coobird.thumbnailator.Thumbnails;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.multipart.MultipartFile;

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.IOException;
import java.net.URLDecoder;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

@Controller
public class PostImageController {//관리자만 사용 가능한 영역

    @PostMapping("/deleteFile")
    public ResponseEntity<String> deleteFile(String fileName){//Http Body에 String 데이터를 추가
        File file = null;

        try {
            //썸네일 파일 삭제
            file = new File("c:\\upload\\"+ URLDecoder.decode(fileName,"UTF-8"));
            file.delete();
            //원본 파일 삭제
            String originFileName = file.getAbsolutePath().replace("s_","");
            file=new File(originFileName);
            file.delete();
        } catch (Exception e) {
            e.printStackTrace();
            return new ResponseEntity<String>("fail",HttpStatus.NOT_IMPLEMENTED);
        }
        return new ResponseEntity<String>("success",HttpStatus.OK);
    }


    // 서버에서 뷰로 반환하는 데이터가 UTF8로 인코딩(파일이름이 한글인 경우 뷰로 반환되는 과정에서 깨질 수 있음)
    @PostMapping(value="/uploadAjaxAction", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
    public ResponseEntity<List<AttachImageDto>> uploadAjaxAction(MultipartFile[] uploadFile) {//뷰에서 전송한 첨부파일 데이터를 받기위해

        //이미지 파일 체크
        for(MultipartFile multipartFile:uploadFile){
            File checkFile = new File(multipartFile.getOriginalFilename());
            String type = null;

            try {
                type = Files.probeContentType(checkFile.toPath());//Mime Type을 반환해주는 메서드
            } catch (IOException e) {
                e.printStackTrace();
            }

            if(!type.startsWith("image")){
                List<AttachImageDto> list = null;
                return new ResponseEntity<>(list, HttpStatus.BAD_REQUEST);
            }
        }



        //반환타입 : http의 body에 추가될 데이터는 List<AttachImageDto>
        String uploadFolder = "C:\\upload";
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");//객체생성 초기화
        Date date = new Date();
        String str = sdf.format(date); //yyyy-MM-dd형식
        String datePath = str.replace("-", File.separator);//실행되는 운영채제 환경에 따라 경로 구분자가 작성되도록 함
        // 윈도우 --> \\, 리눅스 --> /

        File uploadPath = new File(uploadFolder, datePath);//file객체 초기화
        if (uploadPath.exists() == false) { //해당 경로의 폴더가 존재하지 않는다면
            uploadPath.mkdirs();//여러개의 폴더를 생성
        }

        //이미지 정보 담는 객체
        List<AttachImageDto> list = new ArrayList();

        for (MultipartFile multipartFile : uploadFile) {

            //이미지 정보 객체
            AttachImageDto attachImageDto = new AttachImageDto();

            //파일이름
            String uploadFileName = multipartFile.getOriginalFilename();
            attachImageDto.setFileName(uploadFileName);
            attachImageDto.setUploadPath(datePath);

            //UUID적용 파일 이름
            String uuid = UUID.randomUUID().toString();//파일이름이 같아 덮어씌우기를 막기 위해!(UUID - 범용 고유 식별자)
            uploadFileName = uuid + "_" + uploadFileName;
            attachImageDto.setUuid(uuid);

            //파일 위치, 파일이름을 합친 File객체
            File saveFile = new File(uploadPath, uploadFileName);
            //파일 저장
            try {
                multipartFile.transferTo(saveFile);

                //썸네일
                File thumbnailFile = new File(uploadPath, "s_" + uploadFileName);

                BufferedImage bo_image = ImageIO.read(saveFile);

                //비율
                double ratio = 3;
                //넓이 높이
                int width = (int) (bo_image.getWidth() / ratio);
                int height = (int) (bo_image.getHeight() / ratio);


                Thumbnails.of(saveFile)
                        .size(width, height)
                        .toFile(thumbnailFile);
            } catch (IOException e) {
                e.printStackTrace();
            }
            list.add(attachImageDto);
        }
        System.out.println("list="+list);
        ResponseEntity<List<AttachImageDto>> result = new ResponseEntity<List<AttachImageDto>>(list, HttpStatus.OK);
        //Http바디에 추가될 데이터는 List<AttachImageDto>이고, 상태코드가 200인 ReseponseEntity객체 생성
        return result;
        //AttachImageDto형식으로 리스트 추가됨
    }
}
