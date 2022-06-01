package com.bkProject.p1.domain;


import java.util.ArrayList;
import java.util.List;

public class ScheduleDto {
    private int pno;
    private int year;
    private int month;
    private int day;
    private String time ;
    private String book_user;

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
                "pno=" + pno +
                ", year=" + year +
                ", month=" + month +
                ", day=" + day +
                ", time='" + time + '\'' +
                ", book_user='" + book_user + '\'' +
                '}';
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
