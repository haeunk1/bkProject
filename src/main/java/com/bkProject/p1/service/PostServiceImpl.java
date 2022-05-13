package com.bkProject.p1.service;

import com.bkProject.p1.dao.PostDao;
import com.bkProject.p1.domain.AttachImageDto;
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

    public int imgPost(AttachImageDto attachImageDto) throws Exception{
        return postDao.imgInsert(attachImageDto);
    }
}
//서비스 단계에서 post정보와 이미지정보를 db에 등록하는 작업 할것