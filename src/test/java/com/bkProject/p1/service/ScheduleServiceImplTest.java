package com.bkProject.p1.service;

import com.bkProject.p1.domain.ScheduleDto;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import static org.junit.Assert.*;
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/**/root-context.xml"})
public class ScheduleServiceImplTest {
    @Autowired
    ScheduleService scheduleService;

    @Test
    public void getSchedule() throws Exception{
/*        scheduleService.deleteAll();

        ScheduleDto scheduleDto = new ScheduleDto();
        scheduleDto.setPno(696);
        scheduleDto.setYear(2022);
        scheduleDto.setMonth(5);
        scheduleDto.setDay(20);
        scheduleDto.setTime("[0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0]");
        System.out.println(scheduleDto);
        scheduleService.setSchedule(scheduleDto);

        String result = (String)scheduleService.getSchedule(scheduleDto);
        System.out.println(result);
   */
    }
    @Test
    public void updateSchedule() throws Exception{
        scheduleService.deleteAll();
        ScheduleDto dto = new ScheduleDto(3,2022,6,3);
        String setTime="000000000000000000";
        dto.setTime(setTime);
        scheduleService.setSchedule(dto);

        dto.setTime("111111111111111111");
        dto.setBook_user("eeeee");
        scheduleService.updateSchedule(dto);



    }

}