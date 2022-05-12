package com.bkProject.p1.service;

import com.bkProject.p1.dao.PostDao;
import com.bkProject.p1.domain.PostDto;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class PostServiceImpl implements PostService {
    @Autowired
    PostDao postDao;

    public int post(PostDto postDto) throws Exception{
        return postDao.insert(postDto);
    }

    public int reset() throws Exception{
        return postDao.deleteAll();
    }
}
