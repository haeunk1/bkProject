package com.bkProject.p1.domain;

import java.text.SimpleDateFormat;
import java.util.Date;

//달력을 출력하기 위함
public class calendar {
    SimpleDateFormat sdf= new SimpleDateFormat("[yyyy,MM,dd]");
    Date date = new Date();

    String now = sdf.format(date);


}
