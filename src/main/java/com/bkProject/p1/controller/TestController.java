package com.bkProject.p1.controller;

import com.bkProject.p1.domain.AttachImageDto;
import com.bkProject.p1.domain.MemberDto;
import com.bkProject.p1.domain.PostDto;
import com.bkProject.p1.service.PostService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
public class TestController {
    @Autowired
    PostService postService;
    @GetMapping("/test")
    public String test(HttpServletRequest request){
        //test를 위해 login 생략
        /*if(!adminLoginCheck(request)){
            return "redirect:/member/login";
        }*/

        return "test";
    }
    private boolean adminLoginCheck(HttpServletRequest request) {
        HttpSession session = request.getSession();
        MemberDto memberDto = (MemberDto) session.getAttribute("memberDto");

        return memberDto != null && memberDto.getMaster_admin() == 1;
    }

    @PostMapping("/test")
    public String testt(PostDto postDto, HttpServletRequest request, RedirectAttributes rttr){
        //test를 위해 login 생략
        /*HttpSession session= request.getSession();
        MemberDto memberDto = (MemberDto)session.getAttribute("memberDto");
        postDto.setWriter(memberDto.getId());*/
        postDto.setWriter("임시 관리자");
        try {
            postService.post(postDto);

            //if(postDto.getImageList()==null || postDto.getImageList().size()<=0) return;

            for(AttachImageDto attach:postDto.getImageList()){

                attach.setPno(postDto.getPno());
                postService.imgPost(attach);
            }

            rttr.addAttribute("msg","postOK");
            return "redirect:/";
        } catch (Exception e) {
            rttr.addAttribute("msg","postERR");
            return "redirect:/test";//폼으로 다시 돌아감
        }

    }
}
