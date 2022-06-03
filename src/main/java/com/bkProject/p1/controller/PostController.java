package com.bkProject.p1.controller;

import com.bkProject.p1.domain.AttachImageDto;
import com.bkProject.p1.domain.MemberDto;
import com.bkProject.p1.domain.PostDto;
import com.bkProject.p1.service.PostService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.List;

@Controller
@RequestMapping("/post")
public class PostController {

    @Autowired
    PostService postService;

    private static final String CURR_IMAGE_REPO_PATH = "C://spring//image_rep";

    @GetMapping("/form")
    public String form(HttpServletRequest request,Integer pno,Model m) {
        if (!adminLoginCheck(request)) {
            return "redirect:/member/login";
        }
        try {
            if(pno!=null){
                PostDto postDto = postService.getPost(pno);
                m.addAttribute("postDto",postDto);
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return "write";
    }

    private boolean adminLoginCheck(HttpServletRequest request) {
        HttpSession session = request.getSession();
        MemberDto memberDto = (MemberDto) session.getAttribute("memberDto");

        return memberDto != null && memberDto.getMaster_admin() == 1;
    }

    @Transactional
    @PostMapping("/write")
    public String testt(PostDto postDto, HttpServletRequest request, RedirectAttributes rttr){
        ///////////////////////////
        HttpSession session= request.getSession();
        MemberDto memberDto = (MemberDto)session.getAttribute("memberDto");
        postDto.setWriter(memberDto.getId());
        System.out.println("postDto="+postDto);
        try {
            postService.post(postDto);
            //if(postDto.getImageList()==null || postDto.getImageList().size()<=0) return;

            for(AttachImageDto attach:postDto.getImageList()){

                attach.setPno(postDto.getPno());
                postService.imgPost(attach);
            }
            rttr.addFlashAttribute("msg","postOK");
            return "redirect:/main";
        } catch (Exception e) {
            rttr.addFlashAttribute("msg","postERR");
            return "redirect:/post/form";//폼으로 다시 돌아감
        }

    }
    @GetMapping("/list")
    public String adminPostList(HttpServletRequest request, Model m){
        HttpSession session = request.getSession();
        String writer = (String)session.getAttribute("id");
        try {
            List<PostDto> list = postService.adminPostList(writer);
            m.addAttribute("list",list);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return "admin/postList";
    }

    @GetMapping("/delete")
    public String deletepost(Integer pno, RedirectAttributes rttr){

        try {
            postService.deletePost(pno);
            postService.deleteLikeAll(pno);
            postService.deleteImg(pno);
            postService.deleteSchedule(pno);
            postService.deleteScheduleDetail(pno);

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return "redirect:/post/list";

    }


}
