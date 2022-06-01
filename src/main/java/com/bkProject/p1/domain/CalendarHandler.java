package com.bkProject.p1.domain;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.List;

//달력을 출력하기 위함
public class CalendarHandler {
    private int year;
    private int month;
    private int day;
    private List dayList=new ArrayList();
    private int end;



    //현재 년도, 월 , 입력 알아내기
    // 현재 년도, 월에 따라 달력 출력하기
    // 앞, 뒤 화살표 누름에 따라 다음 달로 넘어가기(1월에 <누르면 년도-1, 월은 12월로 가기
    // 현재 '일'에 체크

public CalendarHandler(){}
    public CalendarHandler(int year, int month) {
        LocalDate now = LocalDate.now();
        this.year=year;
        this.month = month;
        day=now.getDayOfMonth();


        Calendar cal = Calendar.getInstance();
        cal.set(Calendar.YEAR,year);
        cal.set(Calendar.MONTH,month);
//        System.out.println("-----["+year+"년 "+month+"월]-----");
//        System.out.println("  일  월  화  수  목  금  토");
        cal.set(year,month-1,1);
        end = cal.getActualMaximum(Calendar.DATE); //해당 월 마지막 날짜
        int dayOfWeek = cal.get(Calendar.DAY_OF_WEEK); //해당 날짜의 요일(1:일요일 … 7:토요일)
        for(int i=1; i<=end; i++) {
            if(i==1) {
                for(int j=1; j<dayOfWeek; j++) {
                    dayList.add("&nbsp;");
                }
            }
//            if(i<10) { //한자릿수일 경우 공백을 추가해서 줄맞추기
//                dayList.add("&nbsp;");
//            }
            dayList.add(i);
            if(dayOfWeek%7==0) { //한줄에 7일씩 출력
                dayList.add("\"br\"");
            }
            dayOfWeek++;
        }
    }
    /*public CalendarHandler(int year, int month) {
        LocalDate now = LocalDate.now();
        this.year=year;
        this.month = month;
        day=now.getDayOfYear();


        Calendar cal = Calendar.getInstance();
        cal.set(Calendar.YEAR,year);
        cal.set(Calendar.MONTH,month);
//        System.out.println("-----["+year+"년 "+month+"월]-----");
//        System.out.println("  일  월  화  수  목  금  토");
        cal.set(year,month-1,1);
        end = cal.getActualMaximum(Calendar.DATE); //해당 월 마지막 날짜
        int dayOfWeek = cal.get(Calendar.DAY_OF_WEEK); //해당 날짜의 요일(1:일요일 … 7:토요일)
        for(int i=1; i<=end; i++) {
            if(i==1) {
                for(int j=1; j<dayOfWeek; j++) {
                    dayList.add("&nbsp;&nbsp;");
                }
            }
            if(i<10) { //한자릿수일 경우 공백을 추가해서 줄맞추기
                dayList.add("&nbsp;");
            }
            dayList.add("&nbsp;"+i+"&nbsp;");
            if(dayOfWeek%7==0) { //한줄에 7일씩 출력
                dayList.add("<br>");
            }
            dayOfWeek++;
        }
    }*/

    public int getEnd() {
        return end;
    }

    public void setEnd(int end) {
        this.end = end;
    }

    @Override
    public String toString() {
        return "CalendarHandler{" +
                "year=" + year +
                ", month=" + month +
                ", day=" + day +
                ", dayList=" + dayList +
                '}';
    }

    public List getDayList() {
        return dayList;
    }

    public void setDayList(List dayList) {
        this.dayList = dayList;
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
}
