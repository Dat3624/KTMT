package com.example.demo.dto;

import com.example.demo.entities.EnrollmentStatus;
import com.example.demo.entities.Schedule;
import lombok.*;
import org.springframework.cglib.core.Local;

import java.time.LocalDate;
import java.util.List;
@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class EnrollmentDTO {
    private String enrollmentID;
    private String name;
    private int year;
    private int semester;
    private int quantity;

    private String roomName;
    private LocalDate dateStart;
    private LocalDate dateApplyStart;
    private LocalDate dateApplyEnd;
    private String courseID;
    private ScheduleDTO exam;
    private EnrollmentStatus status;
    private List<ScheduleDTO> scheduleStudy;
    private List<EnrollmentPDTO> enrollmentPs;
    private int credit;
    private String instructorID;
    private String nameCourse;
    private int quantityApply;
    private String nameInstuctor;
    private int fee;
    private String codePractice;
    private LocalDate paymentDeadline;
    public void genPaymentDeadline(){
        this.paymentDeadline = this.dateApplyEnd.plusDays(15);
    }
    private LocalDate dateApply;
    private String paymentStatus;



}
