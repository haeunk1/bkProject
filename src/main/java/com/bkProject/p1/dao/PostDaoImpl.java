package com.bkProject.p1.dao;

import com.bkProject.p1.domain.PostDto;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

@Repository
public class PostDaoImpl implements PostDao {
    @Autowired
    private SqlSession session;

    private static String namespace = "com.bkProject.p1.dao.PostMapper.";

    @Override
    public int insert(PostDto postDto) throws Exception{
        return session.insert(namespace+"insert",postDto);
    }

    public int deleteAll() throws Exception{
        return session.delete(namespace+"deleteAll");
    }

}
