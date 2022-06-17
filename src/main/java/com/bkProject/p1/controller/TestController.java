package com.bkProject.p1.controller;

import com.bkProject.p1.domain.AttachImageDto;
import com.bkProject.p1.domain.PostDto;
import com.bkProject.p1.service.PostService;
import org.apache.commons.net.ftp.FTPClient;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.net.SocketException;
import java.util.List;

@Controller
public class TestController {
    @Autowired
    PostService postService;

    @GetMapping("/test")
    public String form( Integer pno, Model m) {

        try {
            if (pno != null) {
                PostDto postDto = postService.getPost(pno);
                System.out.println("카테고리" + postDto.getCategory());
                System.out.println("주소" + postDto.getArea_info());

                List<AttachImageDto> list = postService.getImageList(postDto.getPno());
                postDto.setImageList(list);
                System.out.println("이미지 정보" + postDto.getImageList());

                m.addAttribute("postDto", postDto);

            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return "viewTest";
    }
}
