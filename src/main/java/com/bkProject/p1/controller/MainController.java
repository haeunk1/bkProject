package com.bkProject.p1.controller;

import com.bkProject.p1.domain.*;
import com.bkProject.p1.service.PostService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.util.FileCopyUtils;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.io.File;
import java.nio.file.Files;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class MainController {
    @Autowired
    PostService postService;
    @GetMapping("/main")
    public String main(SearchCondition searchCondition, Model m) throws Exception{
        System.out.println("searchCondition="+searchCondition);
       /* if(page==null || pageSize==null){
            page=1;
            pageSize=10;
        }*/
        int totalCnt = postService.getSearchResultCnt(searchCondition);
        m.addAttribute("totalCnt",totalCnt);

        PageHandler ph=new PageHandler(totalCnt, searchCondition);
        m.addAttribute("ph",ph);

//        Map map=new HashMap();
//        map.put("offset",(page-1)*pageSize);
//        map.put("pageSize",pageSize);
        List<PostDto> list = postService.getSearchSelectPage(searchCondition);

        m.addAttribute("list",list);
        return "main";
    }
/*

    @GetMapping("/main")
    public String main(Integer page, Integer pageSize, Model m) throws Exception{

        if(page==null || pageSize==null){
            page=1;
            pageSize=10;
        }
        int totalCnt = postService.getCount();
        m.addAttribute("totalCnt",totalCnt);

        PageHandler ph=new PageHandler(totalCnt, page);
        m.addAttribute("ph",ph);

        Map map=new HashMap();
        map.put("offset",(page-1)*pageSize);
        map.put("pageSize",pageSize);
        List<PostDto> list = postService.getPage(map);

        m.addAttribute("list",list);
        return "main";
    }
*/


    //이미지는 모든 사용자가 접근가능해야 하기 때문에 일단 MainController에 작성
    @GetMapping("/display")
    public ResponseEntity<byte[]> getImage(String fileName){//ResponseEntity객체를 통해 body에 byte[]데이터를 보내기 때문에
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
        return result;
    }

    @GetMapping("/getImageList")
    public ResponseEntity<List<AttachImageDto>> getImageList(int pno){
        try {
            return new ResponseEntity<List<AttachImageDto>>(postService.getImageList(pno),HttpStatus.OK);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

}