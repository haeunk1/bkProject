package com.bkProject.p1.controller;

import com.bkProject.p1.domain.MemberDto;
import com.bkProject.p1.domain.PostDto;
import com.bkProject.p1.service.PostService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

@Controller
@RequestMapping("/post")
public class PostController {

    @Autowired
    PostService postService;

    private static final String CURR_IMAGE_REPO_PATH = "C://spring//image_rep";

    @GetMapping("/form")
    public String form(HttpServletRequest request, Model m) {
        if (!adminLoginCheck(request)) {
            return "redirect:/member/login";
        }
        m.addAttribute("mode", "new");
        return "write";
    }

    private boolean adminLoginCheck(HttpServletRequest request) {
        HttpSession session = request.getSession();
        MemberDto memberDto = (MemberDto) session.getAttribute("memberDto");

        return memberDto != null && memberDto.getMaster_admin() == 1;
    }

    //상품등록
   // @PostMapping("/write")
    @RequestMapping(value="/write", method = {RequestMethod.GET, RequestMethod.POST})
    public String write(PostDto postDto, HttpSession session,RedirectAttributes rttr) throws Exception {

        String memberDto = (String)session.getAttribute("memberDto");
//        writer=memberDto.
//        postDto.setWriter(writer);
        System.out.println("memberDto = "+memberDto);

        System.out.println("전달 성공");
        System.out.println("postDto="+postDto);
        postService.post(postDto);
        rttr.addAttribute("msg","postOK");
        return "redirect:/";



    }


}
