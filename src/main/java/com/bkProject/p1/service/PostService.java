package com.bkProject.p1.service;

import com.bkProject.p1.domain.AttachImageDto;
import com.bkProject.p1.domain.MemberDto;
import com.bkProject.p1.domain.PostDto;

public interface PostService {

    int post(PostDto postDto) throws Exception;

    int reset() throws Exception;

    int imgPost(AttachImageDto attachImageDto) throws Exception;
}
