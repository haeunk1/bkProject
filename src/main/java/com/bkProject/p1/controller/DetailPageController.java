package com.bkProject.p1.controller;

import com.bkProject.p1.domain.PostDto;
import com.bkProject.p1.service.PostService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

@Controller
public class DetailPageController {
    @Autowired
    PostService postService;
    @GetMapping("/detail")
    public String detailPage(Integer pno, Model m) {

        try {
            PostDto postDto = postService.getPost(pno);
            m.addAttribute("postDto",postDto);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        return "detail";
    }

}
