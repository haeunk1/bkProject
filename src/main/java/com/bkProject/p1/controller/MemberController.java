package com.bkProject.p1.controller;

import com.bkProject.p1.domain.MemberDto;
import com.bkProject.p1.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

@Controller
@RequestMapping("/member")
public class MemberController {
    @Autowired
    MemberService service;

    @GetMapping("/login")
    public String loginGET() {
        return "/member/login";
    }


    @PostMapping("/join")
    public String joinPost(MemberDto memberDto, Model m) throws Exception {
        //1.유효성검사
        if (!isValid(memberDto)) {
            return "redirect:/member/join";
        }
        //2.db저장
        System.out.println("memberDto = " + memberDto);
        System.out.println("memberDto.getId()" + memberDto.getId());
        service.register(memberDto);
        return "redirect:/";

    }

    private boolean isValid(MemberDto memberDto) {
        return true;
    }

    @GetMapping("/join")
    public String joinGET() {
        return "/member/join";
    }

    @PostMapping("/memberIdCheck")
    @ResponseBody
    public String memberIdCheckPOST(String memberId) throws Exception {
        MemberDto memberDto = new MemberDto();
        memberDto.setId(memberId);
        System.out.println("memberDto==" + memberDto);

        int result = service.idCheck(memberDto);
        System.out.println(result);

        if (memberId.length() < 4) {
            return "lenCheck";
        } else {

            if (result == 0) {
                return "success";
            } else {
                return "fail";
            }
        }
    }
}



