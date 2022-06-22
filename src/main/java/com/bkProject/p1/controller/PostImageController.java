package com.bkProject.p1.controller;

import com.bkProject.p1.domain.AttachImageDto;
import com.bkProject.p1.service.PostService;
import net.coobird.thumbnailator.Thumbnails;
import org.apache.commons.net.ftp.FTP;
import org.apache.commons.net.ftp.FTPClient;
import org.apache.commons.net.ftp.FTPReply;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;

import javax.imageio.ImageIO;
import java.awt.image.BufferedImage;
import java.io.*;
import java.net.URLDecoder;
import java.nio.file.Files;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

@Controller
public class PostImageController {//관리자만 사용 가능한 영역
    private int port = 21;
    private final String user = "asdf3";
    private final String pw = "1234";
    private final String server = "172.30.1.26";
    @Autowired
    PostService postService;
    //@PostMapping("/modImgTest")
    @RequestMapping(value="/modImgTest", method={RequestMethod.GET,RequestMethod.POST})
    public ResponseEntity<List<AttachImageDto>> ttt(Integer pno) {
        List<AttachImageDto> list=null;
        try {
            list = postService.getImageList(pno);

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return new ResponseEntity<>(list, HttpStatus.OK);
    }

    @PostMapping("/deleteFile")
    public ResponseEntity<String> deleteFile(String fileName){//Http Body에 String 데이터를 추가
        System.out.println("fileName="+fileName);
        FTPClient ftpClient = new FTPClient();
        try {

            ftpClient.connect(server, port);
            ftpClient.login(user,pw);

/*            int replycode = ftpClient.getReplyCode();
            if(!FTPReply.isPositiveCompletion(replycode)){
                System.out.println("Connect failed");

            }
            boolean success = ftpClient.login(user,pw);
            if (!success) {
                System.out.println("Could not login to the server");

            }*/
            String fileToDelete = fileName;

            boolean deleted = ftpClient.deleteFile(fileToDelete);
            if (deleted) {
                System.out.println("The file was deleted successfully.");
            } else {
                System.out.println("Could not delete the  file, it may not exist.");
            }

        } catch (IOException ex) {
            System.out.println("Error: " + ex.getMessage());
            ex.printStackTrace();
            return new ResponseEntity<String>("fail",HttpStatus.NOT_IMPLEMENTED);
        } finally {
            try {
                if (ftpClient.isConnected()) {
                    ftpClient.logout();
                    ftpClient.disconnect();
                }
            } catch (IOException ex) {
                ex.printStackTrace();
            }
        }
        return new ResponseEntity<String>("success",HttpStatus.OK);
        /*
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
        return new ResponseEntity<String>("success",HttpStatus.OK);*/
    }


    // 서버에서 뷰로 반환하는 데이터가 UTF8로 인코딩(파일이름이 한글인 경우 뷰로 반환되는 과정에서 깨질 수 있음)
    @PostMapping(value="/uploadAjaxAction", produces = MediaType.APPLICATION_JSON_UTF8_VALUE)
    public ResponseEntity<List<AttachImageDto>> uploadAjaxAction(MultipartFile[] multipartFiles) {//뷰에서 전송한 첨부파일 데이터를 받기위해

        //이미지 파일 체크
        for(MultipartFile uploadFile:multipartFiles){
            File checkFile = new File(uploadFile.getOriginalFilename());
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

        List<AttachImageDto> list = new ArrayList<>();

        //FTPClient를 생성합니다.
        FTPClient ftp = new FTPClient();
        FileInputStream fis = null;
        try {
            try {
                //인코딩 타입
                ftp.setControlEncoding("euc-kr");
                ftp.connect(server,port);
                ftp.login(user,pw);
                //파일 타입
                ftp.setFileType(FTP.BINARY_FILE_TYPE);
                ftp.enterLocalPassiveMode();
                //제대로 연결이 안됐을 경우 ftp접속을 끊습니다.
                if(!FTPReply.isPositiveCompletion(ftp.getReplyCode())) {
                    ftp.disconnect();
                }
                //파일을 넣을 디렉토리를 설정해줍니다.
                //makeDirectory는 directory 생성이 필요할 때만 해주시면 됩니다.
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                Date date = new Date();
                String str = sdf.format(date);
                String datePath = str.replace("-","/");//File.separator


                boolean result = ftp.changeWorkingDirectory(datePath);

                if(!result){
                    result = false;
                    String[] directory = datePath.split("/");
                    String newdir="";
                    for(int i=0,j=directory.length;i<j;i++){
                        newdir+=("/"+directory[i]);
                        try{
                            result=ftp.changeWorkingDirectory(newdir);
                            if(!result){
                                ftp.makeDirectory(newdir);
                                ftp.changeWorkingDirectory(newdir);
                            }
                        }catch(Exception e){
                            throw e;
                        }
                    }
                }

                //ftp.makeDirectory(directoryRoot);
                ftp.changeWorkingDirectory(datePath);//경로 지정

///////////////////////////////////////////
                for(MultipartFile uploadFile : multipartFiles){


                    AttachImageDto attachImageDto = new AttachImageDto();
                    String fileName = uploadFile.getOriginalFilename();
                    attachImageDto.setFileName(fileName);
                    attachImageDto.setUploadPath(datePath);

                    //uuid적용
                    String uuid = UUID.randomUUID().toString();
                    fileName = uuid+"_"+fileName;
                    attachImageDto.setUuid(uuid);

                    File convertFile = new File(fileName);//
                    FileOutputStream fos = new FileOutputStream(convertFile);//주어진 file객체가 가리키는 파일을 쓰기 위한 객체 생성(기존의 파일이 존재할 때는 그 내용을 지우고 새로운 파일을 생성)


                    fos.write(uploadFile.getBytes());//String(문자열)을 default charset으로 인코딩하여 byte배열로 반환
                    fos.close();
                    ///////////////////////
                    list.add(attachImageDto);

                    //그 후 이전에 File로 변환한 업로드파일을 읽어 FTP로 전송합니다.
                    fis = new FileInputStream(convertFile);

                    boolean isSuccess = ftp.storeFile(fileName, fis);
                    //storeFile Method는 파일 송신결과를 boolean값으로 리턴합니다
                    if(isSuccess) {
                        System.out.println("업로드 성공");
                    } else {
                        System.out.println("업로드 실패");
                    }
                }

                //여기까지 반복문
            } catch(Exception e) {
                e.printStackTrace();
            } finally {
                if(fis!=null) {
                    try {
                        fis.close();
                    } catch(Exception e) {
                        e.printStackTrace();
                    }
                }
            }
        } catch(Exception e) {
            e.printStackTrace();
        } finally {
            if(ftp!=null && ftp.isConnected()) {
                try {
                    ftp.disconnect();
                } catch(Exception e) {
                    e.printStackTrace();
                }
            }
        }
        return new ResponseEntity<List<AttachImageDto>>(list, HttpStatus.OK);

        /* old version
        //반환타입 : http의 body에 추가될 데이터는 List<AttachImageDto>
        String uploadFolder = "C:\\upload";
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");//객체생성 초기화
        Date date = new Date();
        String str = sdf.format(date); //yyyy-MM-dd형식
        String datePath = str.replace("-", File.separator);//실행되는 운영채제 환경에 따라 경로 구분자가 작성되도록 함
        // 윈도우 --> \\, 리눅스 --> /

        File uploadPath = new File(uploadFolder, datePath);//file객체 초기화 (부모경로,자식경로)
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
        ResponseEntity<List<AttachImageDto>> result = new ResponseEntity<List<AttachImageDto>>(list, HttpStatus.OK);
        //Http바디에 추가될 데이터는 List<AttachImageDto>이고, 상태코드가 200인 ReseponseEntity객체 생성
        return result;
        //AttachImageDto형식으로 리스트 추가됨*/
    }

    @GetMapping("/display")
    public ResponseEntity<byte[]> getImage(String filePath, String fileUuid, String fileName){//ResponseEntity객체를 통해 body에 byte[]데이터를 보내기 때문에
        ResponseEntity<byte[]> result=null;
        FTPClient ftpClient = new FTPClient();
        try {

            ftpClient.connect(server, port);
            ftpClient.login(user, pw);
            ftpClient.setControlEncoding("euc-kr");
            ftpClient.enterLocalPassiveMode();
            ftpClient.setFileType(FTP.BINARY_FILE_TYPE);

            String remoteFile1 = filePath+"/"+fileUuid+"_"+fileName;//fileName;
            File downloadFile1 = new File("D:/"+fileUuid+"_"+fileName);
            OutputStream outputStream1 = new BufferedOutputStream(new FileOutputStream(downloadFile1));
            boolean success = ftpClient.retrieveFile(remoteFile1, outputStream1);
            outputStream1.close();

            if (success) {
                System.out.println("File #1 has been downloaded successfully.");

            }


            HttpHeaders header = new HttpHeaders();//ResponseEntity에 Response의 header와 관련된 설정 객체를 추가해주기 위해
            header.add("Content-type", Files.probeContentType(downloadFile1.toPath()));//이미지 파일의 MIME TYPE
            result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(downloadFile1),header, HttpStatus.OK);
            downloadFile1.delete();

        } catch (IOException ex) {
            System.out.println("Error: " + ex.getMessage());
            ex.printStackTrace();
        } finally {
            try {
                if (ftpClient.isConnected()) {
                    ftpClient.logout();
                    ftpClient.disconnect();
                }
            } catch (IOException ex) {
                ex.printStackTrace();
            }
        }

        return result;

        /* old version
        File file = new File("C:\\upload\\"+fileName);
        ResponseEntity<byte[]> result = null;

        try {
            HttpHeaders header = new HttpHeaders();//ResponseEntity에 Response의 header와 관련된 설정 객체를 추가해주기 위해
            header.add("Content-type", Files.probeContentType(file.toPath()));//이미지 파일의 MIME TYPE
            result = new ResponseEntity<>(FileCopyUtils.copyToByteArray(file),header, HttpStatus.OK);
            //인자1. 출력시킬 대상 이미지파일(copyToByteArray()메서드 : file객체,이미지파일을 복사하여 Byte배열로 반환해주는 클래스)
            //인자2. header의 설정이 부여된 객체
            //인자3. 전송하고자 하는 상태코드
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return result;*/
    }
}
