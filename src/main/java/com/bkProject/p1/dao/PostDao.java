package com.bkProject.p1.dao;

import com.bkProject.p1.domain.AttachImageDto;
import com.bkProject.p1.domain.PostDto;
import com.bkProject.p1.domain.SearchCondition;

import java.util.List;
import java.util.Map;

public interface PostDao {
    int insert(PostDto postDto) throws Exception;
    int update(PostDto postDto) throws Exception;

    int deleteAll() throws Exception;
    int imgInsert(AttachImageDto attachImageDto) throws Exception;
    List<PostDto> selectPage(Map map) throws Exception;

    List<AttachImageDto> getImageList(int pno) throws Exception;
    List<Integer> getLikeList(String id) throws Exception;

    int count() throws Exception;

    PostDto getPost(int pno) throws Exception;

    int increaseViewCnt(int pno) throws Exception;

    int insertLike(Map map) throws Exception;
    int deleteLike(Map map) throws Exception;
    int likeCntUpdate(Map map) throws Exception;
    int likeCheck(Map map) throws Exception;

    int searchResultCnt(SearchCondition searchCondition) throws Exception;
    List<PostDto> searchSelectPage(SearchCondition searchCondition) throws Exception;
    List<PostDto> adminPostList(String writer)throws Exception;
    int deletePost(int pno) throws Exception;
    int deleteLikeAll(int pno) throws Exception;
    int deleteImg(int pno) throws Exception;
    int deleteSchedule(int pno) throws Exception;
    int deleteScheduleDetail(int pno) throws Exception;
}

