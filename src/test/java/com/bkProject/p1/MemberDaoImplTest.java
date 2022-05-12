package com.bkProject.p1;

import com.bkProject.p1.dao.MemberDao;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.bkProject.p1.domain.MemberDto;


@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/**/root-context.xml"})
public class MemberDaoImplTest {
    @Autowired
    MemberDao memberDao;

    @Test
    public void insertTest() throws Exception{
        MemberDto memberDto =new MemberDto("asf112","1234","data","01011111111","aaa@aaa.com",0);
        memberDao.insert(memberDto);
    }

    @Test
    public void deleteAllTest() throws Exception{
        memberDao.deleteAll();
    }

}