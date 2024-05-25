package com.example.demo.dto;

import lombok.*;

import java.time.LocalDate;
import java.util.List;
import java.util.Locale;

@Getter
@Setter
@ToString
@NoArgsConstructor
@AllArgsConstructor
public class ScheduleEnrollmentDTO {
    private List<ScheduleDTO> schedules;
    private String nameCourse;
    private String roomName;
    private String nameInstructor;
    private String enrollmentID;
    private String nameClass;
    private String note;
    private LocalDate endDate;
    private LocalDate startDate;
}
