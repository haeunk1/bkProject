package com.bkProject.p1.domain;

import java.util.List;

public class PostDto {

    private int pno;
    private String title;
    private String main_content;
    private String detail_content;
    private String area_info;
    private String detail_area;
    private String hourly_cost;
    private String category;

    private String writer; //memberController에서 id session주입해야함(지금은 memberDto로 되어있음)
    private int like_cnt=0;
    private int view_cnt=0;
    private int comment_cnt=0;
    private List<AttachImageDto> imageList; //이미지정보 리스트

    private AttachImageDto imgOne;
    public PostDto(){}

    public AttachImageDto getImgOne() {
        return imgOne;
    }

    public void setImgOne(AttachImageDto imgOne) {
        this.imgOne = imgOne;
    }

    public PostDto(String title, String main_content, String detail_content, String area_info,String detail_area, String hourly_cost, String category) {
        this.title = title;
        this.main_content = main_content;
        this.detail_content = detail_content;
        this.area_info = area_info;
        this.detail_area=detail_area;
        this.hourly_cost = hourly_cost;
        this.category = category;

    }

    public String getDetail_area() {
        return detail_area;
    }

    public void setDetail_area(String detail_area) {
        this.detail_area = detail_area;
    }

    @Override
    public String toString() {
        return "PostDto{" +
                "pno=" + pno +
                ", title='" + title + '\'' +
                ", main_content='" + main_content + '\'' +
                ", detail_content='" + detail_content + '\'' +
                ", area_info='" + area_info + '\'' +
                ", detail_area='" + detail_area + '\'' +
                ", hourly_cost='" + hourly_cost + '\'' +
                ", category='" + category + '\'' +
                ", writer='" + writer + '\'' +
                ", like_cnt=" + like_cnt +
                ", view_cnt=" + view_cnt +
                ", comment_cnt=" + comment_cnt +
                ", imageList=" + imageList +
                ", imgOne=" + imgOne +
                '}';
    }

    public List<AttachImageDto> getImageList() {
        return imageList;
    }

    public void setImageList(List<AttachImageDto> imageList) {
        this.imageList = imageList;
    }

    public int getPno() {
        return pno;
    }

    public void setPno(int pno) {
        this.pno = pno;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getMain_content() {
        return main_content;
    }

    public void setMain_content(String main_content) {
        this.main_content = main_content;
    }

    public String getDetail_content() {
        return detail_content;
    }

    public void setDetail_content(String detail_content) {
        this.detail_content = detail_content;
    }


    public String getArea_info() {
        return area_info;
    }

    public void setArea_info(String area_info) {
        this.area_info = area_info;
    }

    public String getHourly_cost() {
        return hourly_cost;
    }

    public void setHourly_cost(String hourly_cost) {
        this.hourly_cost = hourly_cost;
    }

    public String getCategory() {
        return category;
    }

    public void setCategory(String category) {
        this.category = category;
    }



    public String getWriter() {
        return writer;
    }

    public void setWriter(String writer) {
        this.writer = writer;
    }

    public int getLike_cnt() {
        return like_cnt;
    }

    public void setLike_cnt(int like_cnt) {
        this.like_cnt = like_cnt;
    }

    public int getView_cnt() {
        return view_cnt;
    }

    public void setView_cnt(int view_cnt) {
        this.view_cnt = view_cnt;
    }

    public int getComment_cnt() {
        return comment_cnt;
    }

    public void setComment_cnt(int comment_cnt) {
        this.comment_cnt = comment_cnt;
    }
    //private List<AttachImageDto> imageDtoList;


}
