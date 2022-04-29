package com.bkProject.p1.service;

import com.bkProject.p1.dao.MemberDao;
import com.bkProject.p1.domain.MemberDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class MemberServiceImpl implements MemberService {
    @Autowired
    MemberDao memberDao;

    @Override
    public int register(MemberDto memberDto) throws Exception{
        return memberDao.insert(memberDto);
    }

    @Override
    public int reset() throws Exception{
        return memberDao.deleteAll();
    }

    public int idCheck(MemberDto memberDto) throws Exception{
        return memberDao.idCount(memberDto);
    }
}
