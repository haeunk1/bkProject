package com.bkProject.p1.controller;

import com.bkProject.p1.domain.CalendarHandler;
import com.bkProject.p1.domain.PostDto;
import com.bkProject.p1.domain.ScheduleDto;
import com.bkProject.p1.service.PostService;
import com.bkProject.p1.service.ScheduleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Controller
public class DetailPageController {
    @Autowired
    PostService postService;
    @Autowired
    ScheduleService service;
    @GetMapping("/detail")
    public String detailPage(Integer pno, Model m) {

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

    @PostMapping("/paytest")
    public String payPage(String timeString, Integer totCost, Integer year, Integer month, Integer day, String pno){
        System.out.println("timeString="+timeString);
        System.out.println("totCost="+totCost);
        System.out.println(year);
        System.out.println(month);
        System.out.println(day);
        System.out.println(pno);
        return "test";
    }


}
