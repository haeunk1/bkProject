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
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class MainController {
    @Autowired
    PostService postService;
    @GetMapping("/main")
    public String main(SearchCondition searchCondition, Model m) throws Exception {

        int totalCnt = postService.getSearchResultCnt(searchCondition);
        m.addAttribute("totalCnt", totalCnt);

        PageHandler ph = new PageHandler(totalCnt, searchCondition);
        m.addAttribute("ph", ph);

        List<PostDto> list = postService.getSearchSelectPage(searchCondition);
        AttachImageDto imgOne = null;
        for (PostDto dto : list) {
            //main이미지
            List<AttachImageDto> imglist = postService.getImageList(dto.getPno());
            imgOne = imglist.get(0);
            dto.setImgOne(imgOne);
            //
            String cate = dto.getCategory();
            cate = cate.replace(",", " #");
            dto.setCategory(cate);
        }
        m.addAttribute("list", list);
        return "main";
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