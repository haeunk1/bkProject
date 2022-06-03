package com.bkProject.p1.service;

import com.bkProject.p1.dao.PostDao;
import com.bkProject.p1.domain.AttachImageDto;
import com.bkProject.p1.domain.PostDto;
import com.bkProject.p1.domain.SearchCondition;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.Map;

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

    public List<PostDto> getPage(Map map) throws Exception{
        return postDao.selectPage(map);
    }

    public int getCount() throws Exception{
        return postDao.count();
    }

    public List<AttachImageDto> getImageList(int pno) throws Exception{
        return postDao.getImageList(pno);
    }
    public PostDto getPost(int pno) throws Exception{
        postDao.increaseViewCnt(pno);
        return postDao.getPost(pno);
    }

    public int insertLike(Map map) throws Exception{
        return postDao.insertLike(map);
    }
    public int deleteLike(Map map) throws Exception{
        return postDao.deleteLike(map);
    }

    public int likeCntUpdate(Map map) throws Exception{
        return postDao.likeCntUpdate(map);
    }
    public int likeCheck(Map map) throws Exception{
        return postDao.likeCheck(map);
    }
    public int getSearchResultCnt(SearchCondition searchCondition) throws Exception{
        return postDao.searchResultCnt(searchCondition);
    }
    public List<PostDto> getSearchSelectPage(SearchCondition searchCondition) throws Exception{
        return postDao.searchSelectPage(searchCondition);
    }
    public List<PostDto> adminPostList(String writer) throws Exception{
        return postDao.adminPostList(writer);
    }


    public int deletePost(int pno) throws Exception{
        return postDao.deletePost(pno);
    }
    public int deleteLikeAll(int pno) throws Exception{
        return postDao.deleteLikeAll(pno);
    }
    public int deleteImg(int pno) throws Exception{
        return postDao.deleteImg(pno);
    }
    public int deleteSchedule(int pno) throws Exception{
        return postDao.deleteSchedule(pno);
    }
    public int deleteScheduleDetail(int pno) throws Exception{
        return postDao.deleteScheduleDetail(pno);
    }
}