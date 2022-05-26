package com.bkProject.p1.domain;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

import static org.junit.Assert.*;
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(locations = {"file:src/main/webapp/WEB-INF/spring/**/root-context.xml"})
public class CalendarHandlerTest {
/*    @Test
    public void test() throws Exception {
        CalendarHandler ch=new CalendarHandler();
        System.out.println("year="+ch.getYear());
        System.out.println("month="+ch.getMonth());
        System.out.println("day="+ch.getDay());
        List list1 = ch.getDayList();
        System.out.println(list1);
        for(int i=0 ; i< list1.size();i++){
            System.out.println("list1["+i+"]"+list1.get(i));

        }
    }*/

}