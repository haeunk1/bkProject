package com.bkProject.p1.dao;

import com.bkProject.p1.domain.ScheduleDto;

public interface ScheduleDao {
    ScheduleDto select(ScheduleDto scheduleDto) throws Exception;

    int insert(ScheduleDto scheduleDto) throws Exception;

    int deleteAll() throws Exception;

    int delete(int pno) throws Exception;

    int update(ScheduleDto scheduleDto) throws Exception;

}
