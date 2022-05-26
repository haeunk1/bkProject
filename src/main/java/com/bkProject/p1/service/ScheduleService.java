package com.bkProject.p1.service;

import com.bkProject.p1.domain.ScheduleDto;

public interface ScheduleService {
    ScheduleDto getSchedule(ScheduleDto scheduleDto) throws Exception;

    int setSchedule(ScheduleDto scheduleDto)throws Exception;

    int deleteAll()throws Exception;

    int deletePost(int pno)throws Exception;

    int updateSchedule(ScheduleDto scheduleDto)throws Exception;
}
