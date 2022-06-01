package com.bkProject.p1.controller;

import com.bkProject.p1.domain.MemberDto;
import com.bkProject.p1.service.MemberService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import java.net.URLEncoder;
import java.util.concurrent.ExecutionException;

@Controller
@RequestMapping("/member")
public class MemberController {
    @Autowired
    MemberService service;

    //예약현황
    @GetMapping("/bookingList")
    public String bookingList(){
        return "/member/bookingList";
    }
    //찜리스트

    ////////////////////////////로그인 로그아웃/////////////////////////////////
    @GetMapping("/login")
    public String loginGET() {
        return "/member/login";
    }

    @PostMapping("/login")
    public String loginPOST(HttpServletRequest request, HttpServletResponse response, String id, String pwd, boolean rememberId, Model m) throws Exception {

        MemberDto memberDto = service.login(id,pwd);

        if(memberDto==null){
            //아이디, 비밀번호가 일치하지 않을 때
            m.addAttribute("result",0);
            return "redirect:/member/login";
        }
        //HttpServletRequest는 로그인 성공 시 session에 회원정보를 저장하기 위해
        //RedirectAttributes는 로그인 실패 시 리다이렉트 된 로그인페이지에 실패 메시지를 전송하기 위해
        HttpSession session=request.getSession();//헤더에 있는 session객체를 참조
        session.setAttribute("id",id);
        session.setAttribute("memberDto",memberDto);
        session.setAttribute("master_admin",memberDto.getMaster_admin());

        //아이디, 비밀번호 일치할 때
        if(rememberId){
            Cookie cookie = new Cookie("id",id); //1. 쿠키를 생성
            response.addCookie(cookie); //2. 응답에 저장
        }else{
            Cookie cookie = new Cookie("id",id);
            cookie.setMaxAge(0);//쿠키삭제
            response.addCookie(cookie);
        }
        //3. 홈으로 이동
        return "redirect:/main";
    }
    @GetMapping("/logout")
    public String logout(HttpSession session){
        session.invalidate();
        return "redirect:/main";
    }

    ////////////////////////////회원가입/////////////////////////////////
    @PostMapping("/join")
    public String joinPost(MemberDto memberDto, Model m,RedirectAttributes rttr){
        try {
            //1.유효성검사
            if (!isValid(memberDto)) {
                return "redirect:/member/join";
            }
            //2.db저장
//            System.out.println("memberDto = " + memberDto);
//            System.out.println("memberDto.getId()" + memberDto.getId());
            if(memberDto.getEmail()!="")
                memberDto.setMaster_admin(1);
            int rowCnt = service.register(memberDto);
            if(rowCnt!=1) throw new Exception("Register faild");
            rttr.addFlashAttribute("msg","REG_OK");

            return "redirect:/main";
        } catch (Exception e) {
            m.addAttribute(memberDto);
            rttr.addFlashAttribute("msg","REG_ERR");
            return "redirect:/member/join";
        }
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

        int result = service.idCheck(memberDto);

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



