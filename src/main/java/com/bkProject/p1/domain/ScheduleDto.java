package com.bkProject.p1.domain;


import java.util.ArrayList;
import java.util.Date;
import java.util.List;

public class ScheduleDto {
    private int no;
    private int pno;
    private int year;
    private int month;
    private int day;
    private String time ;
    private String book_user;
    private int totCost;
    private Date book_time;

    /////////////////////////
    //post DB
    private String title;
    private String main_content;
    private String area_info;
    private String writer;
    //member_info DB
    private String phone_number;
    private String email;

    public int getNo() {
        return no;
    }

    public void setNo(int no) {
        this.no = no;
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

    public String getArea_info() {
        return area_info;
    }

    public void setArea_info(String area_info) {
        this.area_info = area_info;
    }

    public String getWriter() {
        return writer;
    }

    public void setWriter(String writer) {
        this.writer = writer;
    }

    public String getPhone_number() {
        return phone_number;
    }

    public void setPhone_number(String phone_number) {
        this.phone_number = phone_number;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    ///////////////////////////////////
    public ScheduleDto() {}

    public ScheduleDto(int pno, int year, int month, int day) {
        this.pno = pno;
        this.year = year;
        this.month = month;
        this.day = day;
    }

    @Override
    public String toString() {
        return "ScheduleDto{" +
                "no=" + no +
                ", pno=" + pno +
                ", year=" + year +
                ", month=" + month +
                ", day=" + day +
                ", time='" + time + '\'' +
                ", book_user='" + book_user + '\'' +
                ", totCost=" + totCost +
                ", book_time=" + book_time +
                ", title='" + title + '\'' +
                ", main_content='" + main_content + '\'' +
                ", area_info='" + area_info + '\'' +
                ", writer='" + writer + '\'' +
                ", phone_number='" + phone_number + '\'' +
                ", email='" + email + '\'' +
                '}';
    }

    public Date getBook_time() {
        return book_time;
    }

    public void setBook_time(Date book_time) {
        this.book_time = book_time;
    }

    public int getTotCost() {
        return totCost;
    }

    public void setTotCost(int totCost) {
        this.totCost = totCost;
    }

    public String getBook_user() {
        return book_user;
    }

    public void setBook_user(String book_user) {
        this.book_user = book_user;
    }

    public int getPno() {
        return pno;
    }

    public void setPno(int pno) {
        this.pno = pno;
    }

    public int getYear() {
        return year;
    }

    public void setYear(int year) {
        this.year = year;
    }

    public int getMonth() {
        return month;
    }

    public void setMonth(int month) {
        this.month = month;
    }

    public int getDay() {
        return day;
    }

    public void setDay(int day) {
        this.day = day;
    }

    public String getTime() {
        return time;
    }

    public void setTime(String time) {
        this.time = time;
    }
}
