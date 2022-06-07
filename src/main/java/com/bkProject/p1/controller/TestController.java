package com.bkProject.p1.controller;

import com.bkProject.p1.domain.PageHandler;
import com.bkProject.p1.domain.PostDto;
import com.bkProject.p1.domain.SearchCondition;
import com.bkProject.p1.service.PostService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

@Controller
public class TestController {
    @Autowired
    PostService postService;
    @GetMapping("/test")
    public String test()throws Exception{
        return "viewTest";
    }
}
