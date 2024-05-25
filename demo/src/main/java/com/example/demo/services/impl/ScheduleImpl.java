package com.example.demo.services.impl;

import com.example.demo.dto.ScheduleDTO;
import com.example.demo.dto.ScheduleEnrollmentDTO;
import com.example.demo.entities.Enrollment;
import com.example.demo.entities.EnrollmentP;
import com.example.demo.entities.Schedule;
import com.example.demo.model.Caculator;
import com.example.demo.repositories.*;
import com.example.demo.services.ScheduleService;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.concurrent.atomic.AtomicBoolean;

@Service
public class ScheduleImpl implements ScheduleService {
    @Autowired
    private StudentRepository studentRepository;
    @Autowired
    private Student_EnrollmentRepository student_enrollmentRepository;
    @Autowired
    private EnrollmentRepository enrollmentRepository;
    @Autowired
    private ScheduleRepository scheduleRepository;
    @Autowired
    private ModelMapper modelMapper;
    @Autowired
    private EnrollmentPRepository enrollmentPRepository;
    @Override
    public boolean checkSchedule(Schedule schedule1, Schedule schedule2) {
        if(!Objects.equals(schedule1.getDayOfWeek(), schedule2.getDayOfWeek())){
            return true;
        }else{
            if(schedule1.getClassesEnd()<schedule2.getClassesStart()){
                System.out.println("a");
                return true;
            } else if (schedule1.getClassesStart()>schedule2.getClassesEnd()){
                System.out.println("b");
                return true;
            } else{
                return false;
            }
        }
    }

    @Override
    public List<ScheduleEnrollmentDTO> getStudentSchedule(String studentID) {
        return student_enrollmentRepository.findStudent_EnrollmentsByStudentStudent(studentRepository.findStudentById(studentID)).stream().map((student_enrollment) -> {
            Enrollment enrollment = enrollmentRepository.findEnrollmentByEnrollmentID(student_enrollment.getEnrollment().getEnrollmentID());
            ScheduleEnrollmentDTO scheduleEnrollmentDTO = new ScheduleEnrollmentDTO();
            scheduleEnrollmentDTO.setEnrollmentID(student_enrollment.getEnrollment().getEnrollmentID());
            scheduleEnrollmentDTO.setNameCourse(enrollment.getCourse().getName());
            scheduleEnrollmentDTO.setNameClass(enrollment.getName());
            scheduleEnrollmentDTO.setRoomName(enrollment.getRoomName());
            scheduleEnrollmentDTO.setNameInstructor(enrollment.getInstuctor().getName());
            scheduleEnrollmentDTO.setStartDate(enrollment.getDateStart());
            int numDate = Caculator.caculatorNumDate(enrollment.getScheduleStudy().get(0).getClassesStart(), enrollment.getScheduleStudy().get(0).getClassesEnd(),enrollment.getCourse().getCredits());
            scheduleEnrollmentDTO.setNumDate(numDate);
            List<ScheduleDTO> scheduleDTOS = new ArrayList<>(enrollment.getScheduleStudy().stream().map((schedule) -> {
                return modelMapper.map(schedule, ScheduleDTO.class);
            }).toList());
            if(!student_enrollment.getCodePractive().equals("")){
                EnrollmentP enrollmentP = enrollmentPRepository.findById(student_enrollment.getCodePractive()).orElse(null);
                Schedule sPractice = enrollmentP.getScheduleStudy();

                ScheduleDTO scheduleDTO = modelMapper.map(sPractice, ScheduleDTO.class);
                scheduleDTO.setRoomName(enrollmentP.getRoom());
                scheduleDTO.setIsPractice("Practice");
                scheduleDTO.setNameInstructor(enrollmentP.getInstructor().getName());
                scheduleDTOS.add(scheduleDTO);

            }
            scheduleEnrollmentDTO.setSchedules(scheduleDTOS);
            return scheduleEnrollmentDTO;
        }).toList();
    }

    @Override
    public boolean checkScheduleByRoomName(String roomName, ScheduleDTO schedule,int semester, int year,String instructorID){
        AtomicBoolean check = new AtomicBoolean(false);
        Schedule scheduleT = modelMapper.map(schedule, Schedule.class);
        enrollmentRepository.findAll().forEach((enrollment) -> {
            if(enrollment.getRoomName().equals(roomName)&&enrollment.getSemester()==semester&&enrollment.getYear()==year){
                enrollment.getScheduleStudy().forEach((schedule1) -> {
                    if(!checkSchedule(schedule1, scheduleT)){
                        check.set(true);
                    }
                });
            }
            if (enrollment.getInstuctor().getId().equals(instructorID)){
                enrollment.getScheduleStudy().forEach((schedule1) -> {
                    if(!checkSchedule(schedule1, scheduleT)){
                        check.set(true);
                    }
                });
            }
        });
        return check.get();
    }

    @Override
    public boolean checkScheduleByRoomTHName(String roomName, ScheduleDTO schedule, int semester, int year,String instructorID) {
        AtomicBoolean check = new AtomicBoolean(false);
        Schedule scheduleT = modelMapper.map(schedule, Schedule.class);
        enrollmentPRepository.findAll().forEach((enrollmentP) -> {
            if(enrollmentP.getRoom().equals(roomName)&&enrollmentP.getEnrollment().getSemester()==semester&&enrollmentP.getEnrollment().getYear()==year){
                if(!checkSchedule(enrollmentP.getScheduleStudy(), scheduleT)){
                    check.set(true);
                }
            }
            if (enrollmentP.getInstructor().getId().equals(instructorID)){
                if(!checkSchedule(enrollmentP.getScheduleStudy(), scheduleT)){
                    check.set(true);
                }
            }
        });
        return check.get();
}
}
