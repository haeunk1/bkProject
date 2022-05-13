package com.bkProject.p1.dao;

import com.bkProject.p1.domain.AttachImageDto;
import com.bkProject.p1.domain.PostDto;

public interface PostDao {
    int insert(PostDto postDto) throws Exception;

    int deleteAll() throws Exception;
    int imgInsert(AttachImageDto attachImageDto) throws Exception;
}

