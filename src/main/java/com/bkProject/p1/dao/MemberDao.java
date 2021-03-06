package com.bkProject.p1.dao;

import com.bkProject.p1.domain.MemberDto;

public interface MemberDao {
    int insert(MemberDto memberDto) throws Exception;

    int deleteAll() throws Exception;

    int idCount(MemberDto memberDto) throws Exception;

    MemberDto idPwdCheck(String id, String pwd) throws Exception;

    MemberDto getMember(String id) throws Exception;
}
