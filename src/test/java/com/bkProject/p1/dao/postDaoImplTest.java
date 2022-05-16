package com.bkProject.p1.dao;

import com.bkProject.p1.domain.AttachImageDto;
import com.bkProject.p1.domain.PostDto;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.ArrayList;
import java.util.List;

import static org.junit.Assert.*;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/**/root-context.xml"})
public class postDaoImplTest {
    @Autowired
    PostDao postDao;
    @Test
    public void insert() throws Exception {
        PostDto postDto = new PostDto("제목3","설명3","상세설명","12:00","24:00","도봉구","12,000","[date', 'bbq', 'singing_room',' board_game']");
        postDto.setWriter("eeee");
        postDao.insert(postDto);

    }
    @Test
    public void count() throws Exception{
        int count = postDao.count();
        System.out.println("count="+count);
    }

    @Test
    public void deleteAll() throws Exception {
        postDao.deleteAll();
    }
    @Test
    public void imgInsert() throws Exception{
        PostDto postDto = new PostDto("제목3","설명3","상세설명","12:00","24:00","도봉구","12,000","[date', 'bbq', 'singing_room',' board_game']");
        List<AttachImageDto> imageList = new ArrayList<AttachImageDto>();

        AttachImageDto image1 = new AttachImageDto();
        AttachImageDto image2 = new AttachImageDto();

        image1.setFileName("test Image 1");
        image1.setUploadPath("test image 1");
        image1.setUuid("test1111");

        image2.setFileName("test Image 2");
        image2.setUploadPath("test image 2");
        image2.setUuid("test2222");
        System.out.println("image1="+image1);

        postDao.imgInsert(image1);
    }
}