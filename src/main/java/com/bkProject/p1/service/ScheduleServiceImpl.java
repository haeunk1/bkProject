package com.bkProject.p1.service;

import com.bkProject.p1.dao.ScheduleDao;
import com.bkProject.p1.domain.ScheduleDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class ScheduleServiceImpl implements ScheduleService {
    @Autowired
    ScheduleDao scheduleDao;

    @Override
    public ScheduleDto getSchedule(ScheduleDto scheduleDto)throws Exception{
        return scheduleDao.select(scheduleDto);
    }

    public int setSchedule(ScheduleDto scheduleDto)throws Exception {
        return scheduleDao.insert(scheduleDto);
    }

    public int deleteAll()throws Exception{
        return scheduleDao.deleteAll();
    }

    public int deletePost(int pno)throws Exception{
        return scheduleDao.delete(pno);
    }

    public int updateSchedule(ScheduleDto scheduleDto)throws Exception {
        return scheduleDao.update(scheduleDto);
    }
}
