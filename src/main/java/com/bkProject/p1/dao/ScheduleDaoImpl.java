package com.bkProject.p1.dao;

import com.bkProject.p1.domain.ScheduleDto;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class ScheduleDaoImpl implements ScheduleDao {
    @Autowired
    private SqlSession session;

    private static String namespace = "com.bkProject.p1.dao.ScheduleMapper.";

    @Override
    public ScheduleDto select(ScheduleDto scheduleDto) throws Exception{
        return session.selectOne(namespace+"getSchedule",scheduleDto);
    }

    public int insert(ScheduleDto scheduleDto) throws Exception{
        return session.insert(namespace+"insert",scheduleDto);
    }

    public int deleteAll() throws Exception{
        return session.delete(namespace+"deleteAll");
    }

    public int delete(int pno) throws Exception{
        return session.delete(namespace+"deletePost",pno);
    }

    public int update(ScheduleDto scheduleDto) throws Exception{
        return session.update(namespace+"update",scheduleDto);
    }

}
