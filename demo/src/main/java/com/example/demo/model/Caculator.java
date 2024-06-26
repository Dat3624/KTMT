package com.example.demo.model;

import java.time.LocalDate;
import java.time.Year;
import java.util.List;
import java.util.Locale;

public class Caculator {
    private static final int FEE = 800000;
    public static int caculatorFee(int credit){
        return credit*FEE;
    }
    public static final int PROGRAM = Year.now().getValue()-2005;
    public static int caculatorNumDate(int start,int end, int credit){
        return (credit*15)/(end-start+1);
    }
    public static LocalDate caculatorEndDate(LocalDate start, int numDate, int numDayOfWeek){
        return start.plusDays(numDate/numDayOfWeek* 7L);
    }
}
