package com.bkProject.p1.dao;

import com.bkProject.p1.domain.MemberDto;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

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

}