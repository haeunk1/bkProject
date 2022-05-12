package com.bkProject.p1.controller;

import com.bkProject.p1.domain.PostDto;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class TestController {
    @GetMapping("/test")
    public String test(){
        return "test";
    }
    @PostMapping("/test")
    public void testt(PostDto postDto){
        System.out.println("postDto="+postDto);
    }
}
