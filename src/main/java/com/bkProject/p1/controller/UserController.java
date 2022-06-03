package com.bkProject.p1.controller;

import com.bkProject.p1.domain.MemberDto;
import com.bkProject.p1.domain.PostDto;
import com.bkProject.p1.domain.ScheduleDto;
import com.bkProject.p1.service.MemberService;
import com.bkProject.p1.service.PostService;
import com.bkProject.p1.service.ScheduleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/user")
public class UserController {
    @Autowired
    ScheduleService scheduleService;
    @Autowired
    PostService postService;
    @Autowired
    MemberService memberService;
    //예약현황
    @GetMapping("/bookingList")
    public String bookingList(HttpServletRequest request, Model m){
        HttpSession session=request.getSession();
        String id=(String)session.getAttribute("id");
        System.out.println("id="+id);
        try {
            //1.schedule_detail에서 id로 예약내역 가져오기
            List<ScheduleDto> list = scheduleService.dSelectList(id);
            for(ScheduleDto dto:list){
                int pno = dto.getPno();
                PostDto postDto = postService.getPost(pno);
                dto.setTitle(postDto.getTitle());
                int sum=0;
                for(int i=0;i<18;i++){
                    if(dto.getTime().charAt(i)=='2'){
                        sum++;
                    }
                }
                String totTime = Integer.toString(sum);
                dto.setTime(totTime+"시간");
            }
            m.addAttribute("list",list);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        return "user/bookingList";
    }

    @GetMapping("/bookingRead")
    public String bookingRead(Integer no, Model m){
        System.out.println("no="+no);
        try {
            ScheduleDto scheduleDto = scheduleService.getBookingDetail(no);
            PostDto postDto = postService.getPost(scheduleDto.getPno());
            scheduleDto.setTitle(postDto.getTitle());
            scheduleDto.setMain_content(postDto.getMain_content());
            scheduleDto.setArea_info(postDto.getArea_info());
            scheduleDto.setWriter(postDto.getWriter());

            MemberDto memberDto = memberService.getMember(postDto.getWriter());
            scheduleDto.setPhone_number(memberDto.getPhone_number());
            scheduleDto.setEmail(memberDto.getEmail());

            String timeString = scheduleDto.getTime();

            List<String> list = new ArrayList<String>();
            for(int i=0;i<18;i++){
                if(timeString.charAt(i)=='2'){
                    String str = (i+6)+":00~"+(i+7)+":00";
                    list.add(str);
                }
            }

            m.addAttribute("scheduleDto",scheduleDto);
            m.addAttribute("list",list);
            m.addAttribute("mode","check");

        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        return "payCheck";
    }
    //찜리스트
    @GetMapping("/likeList")
    public String likeList(HttpServletRequest request, Model m){
        HttpSession session = request.getSession();
        String id = (String)session.getAttribute("id");
        try {
            List<Integer> idList = scheduleService.lSelectList(id);
            List<PostDto> list = new ArrayList<>();
            for(Integer pno : idList){
                PostDto postDto = postService.getPost(pno);
                list.add(postDto);
            }

            m.addAttribute("list",list);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return "user/likeList";
    }
}
