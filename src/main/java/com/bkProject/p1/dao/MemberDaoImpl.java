package com.bkProject.p1.dao;

import com.bkProject.p1.domain.MemberDto;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.HashMap;
import java.util.Map;

@Repository
public class MemberDaoImpl implements MemberDao {
    @Autowired
    private SqlSession session;
   //     private static String namespace = "com.bkProject.p1.dao.MemberMapper.";
    private static String namespace = "com.bkProject.p1.dao.MemberMapper.";

    @Override
    public int insert(MemberDto memberDto) throws Exception {
        return session.insert(namespace+"insert",memberDto);

    }

    @Override
    public int deleteAll() throws Exception {

        return session.delete(namespace+"deleteAll");
    }
    public int idCount(MemberDto memberDto) throws Exception{
        return session.selectOne(namespace+"idCount",memberDto);
    }

    public MemberDto idPwdCheck(String id, String pwd) throws Exception{
        HashMap map = new HashMap();
        map.put("id",id);
        map.put("pwd",pwd);
        return session.selectOne(namespace+"memberLogin",map);
    }

    public MemberDto getMember(String id) throws Exception{
        return session.selectOne(namespace+"getMember",id);
    }

}