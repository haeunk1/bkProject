package com.bkProject.p1.dao;

import com.bkProject.p1.domain.AttachImageDto;
import com.bkProject.p1.domain.PostDto;

import java.util.List;
import java.util.Map;

public interface PostDao {
    int insert(PostDto postDto) throws Exception;

    int deleteAll() throws Exception;
    int imgInsert(AttachImageDto attachImageDto) throws Exception;
    List<PostDto> selectPage(Map map) throws Exception;

    int count() throws Exception;
}

