package com.bkProject.p1.dao;

import com.bkProject.p1.domain.ScheduleDto;

import java.util.List;

public interface ScheduleDao {
    ScheduleDto select(ScheduleDto scheduleDto) throws Exception;

    int insert(ScheduleDto scheduleDto) throws Exception;

    int deleteAll() throws Exception;

//    int delete(int pno) throws Exception;

    int update(ScheduleDto scheduleDto) throws Exception;
    int dInsert(ScheduleDto scheduleDto) throws Exception;
    List<ScheduleDto> dSelectList(String book_user) throws Exception;
    ScheduleDto getBookingDetail(int no) throws Exception;
    List<Integer> lSelectList(String id) throws Exception;

}
