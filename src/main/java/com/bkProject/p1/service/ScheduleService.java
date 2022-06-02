package com.bkProject.p1.service;

import com.bkProject.p1.domain.ScheduleDto;

import java.util.List;

public interface ScheduleService {
    ScheduleDto getSchedule(ScheduleDto scheduleDto) throws Exception;

    int setSchedule(ScheduleDto scheduleDto)throws Exception;

    int deleteAll()throws Exception;

    int deletePost(int pno)throws Exception;

    int updateSchedule(ScheduleDto scheduleDto)throws Exception;
    int dInsert(ScheduleDto scheduleDto)throws Exception;
    List<ScheduleDto> dSelectList(String book_user)throws Exception;
    ScheduleDto getBookingDetail(int no)throws Exception;
    List<Integer> lSelectList(String id) throws Exception;
}
