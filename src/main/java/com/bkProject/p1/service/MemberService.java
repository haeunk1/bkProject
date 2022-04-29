package com.bkProject.p1.service;

import com.bkProject.p1.domain.MemberDto;

public interface MemberService {
    int register(MemberDto memberDto) throws Exception;

    int reset() throws Exception;

    int idCheck(MemberDto memberDto) throws Exception;
}
