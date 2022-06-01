package com.bkProject.p1.controller;

import com.bkProject.p1.domain.CalendarHandler;
import com.bkProject.p1.domain.MemberDto;
import com.bkProject.p1.domain.PostDto;
import com.bkProject.p1.domain.ScheduleDto;
import com.bkProject.p1.service.MemberService;
import com.bkProject.p1.service.PostService;
import com.bkProject.p1.service.ScheduleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Controller
public class DetailPageController {
    @Autowired
    PostService postService;
    @Autowired
    ScheduleService service;
    @Autowired
    MemberService memberService;
    @Autowired
    ScheduleService scheduleService;
    @GetMapping("/detail")
    public String detailPage(HttpServletRequest request, Integer pno, Model m) {

        HttpSession session = request.getSession();
        MemberDto memberDto= (MemberDto)session.getAttribute("memberDto");
        if(memberDto!=null)
            m.addAttribute("memberDto",memberDto);
        try {
            PostDto postDto = postService.getPost(pno);
            m.addAttribute("postDto",postDto);

            CalendarHandler ch = new CalendarHandler();
            LocalDate now = LocalDate.now();
            ch.setMonth(now.getMonthValue());
            m.addAttribute("ch",ch);

        } catch (Exception e) {
            throw new RuntimeException(e);
        }
        return "detail";
    }
    //로그인 한 회원이 해당 게시물에 '좋아요'를 눌렀는지 확인
    @PostMapping("/likeCheck")
    public ResponseEntity<Integer> likeCheck(int pno, String id){
        Map map=new HashMap();
        map.put("id",id);
        map.put("pno",pno);
        try {
            int ch = postService.likeCheck(map); //있음(1) or 없음(0)
            return new ResponseEntity<Integer>(ch, HttpStatus.OK);
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    @PostMapping("/postLike")
    public ResponseEntity<Boolean> postLike(HttpServletRequest request, boolean ch,Integer pno){

        //로그인 체크
        if(!loginCheck(request)){
            return new ResponseEntity<Boolean>(false, HttpStatus.BAD_REQUEST);
        }
        HttpSession session = request.getSession();
        String id = (String)session.getAttribute("id");


        try {
            Map map = new HashMap();//insertLike,deleteLike
            map.put("pno",pno);
            map.put("id",id);

            Map map2 = new HashMap();//likeCntUpdate
            map2.put("pno",pno);
            if(ch){
                postService.insertLike(map);
                map2.put("action",1);
                postService.likeCntUpdate(map2);
                return new ResponseEntity<Boolean>(true, HttpStatus.OK);
            }else{
                postService.deleteLike(map);
                map2.put("action",-1);
                postService.likeCntUpdate(map2);
                return new ResponseEntity<Boolean>(false, HttpStatus.OK);
            }
        } catch (Exception e) {
            throw new RuntimeException(e);
        }
    }

    private boolean loginCheck(HttpServletRequest request) {
        //1.세션을 얻어서
        HttpSession session = request.getSession();
        //2.세션에 id가 있는지 확인/있으면 true반환
        return session.getAttribute("id")!=null;
    }

    @PostMapping ("/calendar")
    public ResponseEntity<CalendarHandler> getCaledar(Integer year, Integer month){//month전달받은 값에 따라서 반환하는 값도 달라야 함
        if(month==null|| month==0){
            LocalDate now = LocalDate.now();
            month=now.getMonthValue();
        }
        if(year==null || year==0){
            LocalDate now = LocalDate.now();
            year=now.getYear();
        }
        CalendarHandler ch = new CalendarHandler(year,month);
        return new ResponseEntity<CalendarHandler>(ch, HttpStatus.OK);

}
    @PostMapping("/getTimeList")
    public ResponseEntity<ScheduleDto> getTimeList(Integer pno, Integer year, Integer month,Integer day){

        ScheduleDto dto = new ScheduleDto(pno,year,month,day);
        try {
            ScheduleDto scheduleDto = service.getSchedule(dto);

            System.out.println("scheduleDto=="+scheduleDto);
            if(scheduleDto==null){
                String setTime = "000000000000000000";

                ScheduleDto dto2 = new ScheduleDto(pno,year,month,day);
                dto2.setTime(setTime);
                service.setSchedule(dto2);
                return new ResponseEntity<ScheduleDto>(dto2, HttpStatus.OK);
            }
            return new ResponseEntity<ScheduleDto>(scheduleDto, HttpStatus.OK);

        } catch (Exception e) {
            throw new RuntimeException(e);
        }

    }

    @PostMapping("/payCheck")
    public String payPage(HttpServletRequest request, String timeString, Integer totCost, Integer year, Integer month, Integer day, String pno, Model m, RedirectAttributes rttr){

        /*HttpSession session=request.getSession();
        MemberDto memberDto1 = (MemberDto)session.getAttribute("memberDto");
        String masterAdmin = (String)session.getAttribute("master_admin");
        System.out.println("memberDto1="+memberDto1);
        System.out.println("masterAdmin="+masterAdmin);*/
        //1.세션을 얻어서
        HttpSession session = request.getSession();
        //2.세션에 id가 있는지 확인/있으면 true반환
        String id = (String)session.getAttribute("id");
        if(id==null){
            rttr.addFlashAttribute("msg","login");
            return "redirect:/member/login";
        }

        try {
            ScheduleDto scheduleDto = new ScheduleDto(Integer.parseInt(pno), year,month,day);
            scheduleDto.setTime(timeString);
            //1. pno게시물정보 가져오기 - postDto
            PostDto postDto = postService.getPost(Integer.parseInt(pno));
            String writer = postDto.getWriter();
            //2. 작성자 정보 가져오기 - memberDto
            MemberDto memberDto = memberService.getMember(writer);
            //3. timeString해석해서 시간대 문자열로 넘기기
            List<String> list = new ArrayList<String>();
            for(int i=0;i<18;i++){
                if(timeString.charAt(i)=='2'){
                    String str = (i+6)+":00~"+(i+7)+":00";
                    list.add(str);
                }
            }

            m.addAttribute("scheduleDto",scheduleDto);
            m.addAttribute("postDto",postDto);
            m.addAttribute("memberDto",memberDto);
            m.addAttribute("list",list);
            m.addAttribute("totCost",totCost);
            m.addAttribute("id",id);

        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        return "payCheck";
    }
    @PostMapping("/pay")
    public String pay(Integer pno,Integer year, Integer month, Integer day, String time, String book_user, RedirectAttributes rttr){

        ScheduleDto dto = new ScheduleDto(pno,year,month,day);
        time = time.replace("2","1");
        dto.setTime(time);
        dto.setBook_user(book_user);
        try {
            scheduleService.updateSchedule(dto);
            rttr.addFlashAttribute("msg","BOOK_OK");
        } catch (Exception e) {
            rttr.addFlashAttribute("msg","BOOK_ERR");
            throw new RuntimeException(e);
        }
        return "redirect:/main";
    }


}
