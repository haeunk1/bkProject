package com.bkProject.p1.dao;

import com.bkProject.p1.domain.PostDto;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import static org.junit.Assert.*;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/**/root-context.xml"})
public class postDaoImplTest {
    @Autowired
    PostDao postDao;
    @Test
    public void insert() throws Exception {
        postDao.deleteAll();
        PostDto postDto = new PostDto("제목1","설명1","상세설명","12:00","24:00","도봉구","12,000","[date', 'bbq', 'singing_room',' board_game']");

        postDao.insert(postDto);

    }
    @Test
    public void deleteAll() throws Exception{
        postDao.deleteAll();
    }
}