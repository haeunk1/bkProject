package com.bkProject.p1.service;

import com.bkProject.p1.domain.AttachImageDto;
import com.bkProject.p1.domain.MemberDto;
import com.bkProject.p1.domain.PostDto;
import com.bkProject.p1.domain.SearchCondition;

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

    int insertLike(Map map) throws Exception;
    int deleteLike(Map map) throws Exception;
    int likeCntUpdate(Map map) throws Exception;
    int likeCheck(Map map) throws Exception;
    int getSearchResultCnt(SearchCondition searchCondition) throws Exception;
    List<PostDto> getSearchSelectPage(SearchCondition searchCondition) throws Exception;
}
