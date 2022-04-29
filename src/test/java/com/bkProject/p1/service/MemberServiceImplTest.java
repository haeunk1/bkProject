package com.bkProject.p1.service;

import com.bkProject.p1.domain.MemberDto;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import static org.junit.Assert.*;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/**/root-context.xml"})
public class MemberServiceImplTest {
    @Autowired
    MemberService service;

    @Test
    public void register() throws Exception{
        service.reset();
        System.out.println("reset() OK");
        MemberDto memberDto = new MemberDto("aaaa","aaaa1","nameaaa","01011","aaa@aaa.aaa");
        service.register(memberDto);


    }

    @Test
    public void idCountTest() throws Exception{
        service.reset();
        MemberDto memberDto = new MemberDto("aaaa","aaaa1","nameaaa","01011","aaa@aaa.aaa");
        service.register(memberDto);
        MemberDto memberDto2 = new MemberDto();
        memberDto2.setId("aaaa");
        assertTrue(service.idCheck(memberDto2)==1);
    }
}