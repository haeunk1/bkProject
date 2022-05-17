package com.bkProject.p1.domain;

import java.util.List;

public class PostDto {

    private int pno;
    private String title;
    private String main_content;
    private String detail_content;
    private String start_time;
    private String end_time;
    private String area_info;
    private String hourly_cost;
    private String category;

    private String writer; //memberController에서 id session주입해야함(지금은 memberDto로 되어있음)
    private int like_cnt=0;
    private int view_cnt=0;
    private int comment_cnt=0;
    private List<AttachImageDto> imageList; //이미지정보 리스트


    public PostDto(){}
    public PostDto(String title, String main_content, String detail_content, String start_time, String end_time, String area_info, String hourly_cost, String category) {
        this.title = title;
        this.main_content = main_content;
        this.detail_content = detail_content;
        this.start_time = start_time;
        this.end_time = end_time;
        this.area_info = area_info;
        this.hourly_cost = hourly_cost;
        this.category = category;

    }


    @Override
    public String toString() {
        return "PostDto{" +
                "pno=" + pno +
                ", title='" + title + '\'' +
                ", main_content='" + main_content + '\'' +
                ", detail_content='" + detail_content + '\'' +
                ", start_time='" + start_time + '\'' +
                ", end_time='" + end_time + '\'' +
                ", area_info='" + area_info + '\'' +
                ", hourly_cost='" + hourly_cost + '\'' +
                ", category='" + category + '\'' +
                ", writer='" + writer + '\'' +
                ", like_cnt=" + like_cnt +
                ", view_cnt=" + view_cnt +
                ", comment_cnt=" + comment_cnt +
                ", imageList=" + imageList +
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

    public String getStart_time() {
        return start_time;
    }

    public void setStart_time(String start_time) {
        this.start_time = start_time;
    }

    public String getEnd_time() {
        return end_time;
    }

    public void setEnd_time(String end_time) {
        this.end_time = end_time;
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
