package com.bkProject.p1.service;

import com.bkProject.p1.domain.AttachImageDto;
import com.bkProject.p1.domain.MemberDto;
import com.bkProject.p1.domain.PostDto;
import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import java.util.ArrayList;
import java.util.List;

import static org.junit.Assert.*;

public class PostServiceImplTest {
@Autowired
PostService postService;
    @Test
    public void post() {
    }

    @Test
    public void reset() {
    }

    @Test
    public void imgPost() throws Exception{
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

        System.out.println("imag1타입="+image1.getClass().getName());
        postService.imgPost(image1);

//        imageList.add(image1);
//        imageList.add(image2);
//        System.out.println("imag1="+image1);
//        System.out.println("imageList="+imageList);
//
//        for(AttachImageDto attach:imageList){
//            System.out.println("attach="+attach);
//            postService.imgPost(attach);
//        }
    }
}