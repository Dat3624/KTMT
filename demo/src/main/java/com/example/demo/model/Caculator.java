package com.example.demo.model;

import java.time.Year;
import java.util.List;

public class Caculator {
    private static final int FEE = 800000;
    public static int caculatorFee(int credit){
        return credit*FEE;
    }
    public static final int PROGRAM = Year.now().getValue()-2005;
}
