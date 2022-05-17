package com.bkProject.p1.service;

import com.bkProject.p1.domain.AttachImageDto;
import com.bkProject.p1.domain.MemberDto;
import com.bkProject.p1.domain.PostDto;

import java.util.List;
import java.util.Map;

public interface PostService {

    int post(PostDto postDto) throws Exception;

    int reset() throws Exception;

    int imgPost(AttachImageDto attachImageDto) throws Exception;

    List<PostDto> getPage(Map map) throws Exception;

    int getCount() throws Exception;

    List<AttachImageDto> getImageList(int pno) throws Exception;
    PostDto getPost(int pno) throws Exception;
}
