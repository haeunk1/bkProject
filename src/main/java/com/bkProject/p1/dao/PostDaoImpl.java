package com.bkProject.p1.dao;

import com.bkProject.p1.domain.AttachImageDto;
import com.bkProject.p1.domain.PostDto;
import org.apache.ibatis.session.SqlSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Repository;

import java.util.List;
import java.util.Map;

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

    public int imgInsert(AttachImageDto attachImageDto) throws Exception{
        return session.insert(namespace+"imgInsert",attachImageDto);
    }

    public List<PostDto> selectPage(Map map) throws Exception{
        return session.selectList(namespace+"selectPage",map);
    }
    public int count() throws Exception{
        return session.selectOne(namespace+"count");
    }

    public List<AttachImageDto> getImageList(int pno) throws Exception{
        return session.selectList(namespace+"getImageList",pno);
    }

    public PostDto getPost(int pno) throws Exception{
        return session.selectOne(namespace+"selectPost",pno);
    }

    public int increaseViewCnt(int pno) throws Exception{
        return session.update(namespace+"increaseViewCnt",pno);
    }

    public int insertLike(Map map) throws Exception{
        return session.insert(namespace+"insertLike",map);
    }

    public int deleteLike(Map map) throws Exception{
        return session.delete(namespace+"deleteLike",map);
    }

    public int likeCntUpdate(Map map) throws Exception{
        return session.update(namespace+"likeCntUpdate",map);
    }

    public int likeCheck(Map map) throws Exception{
        return session.selectOne(namespace+"likeCheck",map);
    }
}
