package com.bkProject.p1.service;

import com.bkProject.p1.domain.AttachImageDto;
import com.bkProject.p1.domain.MemberDto;
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
public class PostServiceImplTest {
@Autowired
PostService postService;

    @Test
    public void ImageTest() throws Exception{
        List<AttachImageDto> list= postService.getImageList(255);
        System.out.println("list=="+list);
        for(AttachImageDto dto:list){
            System.out.println("dto="+dto);
        }
    }
    @Test
    public void getPost() throws Exception{
        PostDto postDto = postService.getPost(255);
        List<AttachImageDto> list = postService.getImageList(255);
        System.out.println("postDtotest="+postDto);
        for(AttachImageDto attachImageDto:list){
            System.out.println(attachImageDto);
        }
    }
    @Test
    public void post() throws Exception{
        //postService.reset();

        for(int i=1;i<=220;i++){
            PostDto postDto = new PostDto("제목"+i,"설명"+i,"상세설명"+i,"12:00","24:00","도봉구","12,000","[date', 'bbq', 'singing_room',' board_game']");
            postDto.setWriter("작성자"+i);
            List<AttachImageDto> list=new ArrayList<AttachImageDto>();

            AttachImageDto attachImageDto1 = new AttachImageDto();
            attachImageDto1.setPno(postDto.getPno());
            attachImageDto1.setFileName("test"+i);
            attachImageDto1.setUploadPath("2022\05\16");
            attachImageDto1.setUuid("5b61ba10-cf1c-44bc-8aae-4903d30"+i);
            list.add(attachImageDto1);

            AttachImageDto attachImageDto2 = new AttachImageDto();
            attachImageDto2.setPno(postDto.getPno());
            attachImageDto2.setFileName("test"+i+"_2");
            attachImageDto2.setUploadPath("2022\05\16");
            attachImageDto2.setUuid("68e09aa8-e5d7-43bb-904f-f1a3c07b39"+i);
            list.add(attachImageDto2);

            postDto.setImageList(list);

            postService.post(postDto);

            for(AttachImageDto attach:postDto.getImageList()){

                attach.setPno(postDto.getPno());
                postService.imgPost(attach);
            }
        }


    }

    @Test
    public void getCount() throws Exception{
        /*postService.reset();
        PostDto postDto1 = new PostDto("제목1","설명1","상세설명","12:00","24:00","도봉구","12,000","[date', 'bbq', 'singing_room',' board_game']");
        PostDto postDto2 = new PostDto("제목2","설명2","상세설명","12:00","24:00","도봉구","12,000","[date', 'bbq', 'singing_room',' board_game']");
        PostDto postDto3 = new PostDto("제목3","설명3","상세설명","12:00","24:00","도봉구","12,000","[date', 'bbq', 'singing_room',' board_game']");
        postService.post(postDto1);
        postService.post(postDto2);
        postService.post(postDto3);*/
        int count = postService.getCount();
        System.out.println(count);
    }

    @Test
    public void imgPost() throws Exception{
        /*PostDto postDto = new PostDto("제목3","설명3","상세설명","12:00","24:00","도봉구","12,000","[date', 'bbq', 'singing_room',' board_game']");
        List<AttachImageDto> imageList = new ArrayList<AttachImageDto>();

        AttachImageDto image1 = new AttachImageDto();
        AttachImageDto image2 = new AttachImageDto();

        image1.setFileName("test Image 1");
        image1.setUploadPath("test image 1");
        image1.setUuid("test1111");

        image2.setFileName("test Image 2");
        image2.setUploadPath("test image 2");
        image2.setUuid("test2222");

        imageList.add(image1);
        imageList.add(image2);

        for(AttachImageDto attach:imageList){
            attach.setPno(postDto.getPno());
            postService.imgPost(attach);
        }*/
    }
}