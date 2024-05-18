package com.example.demo.controller;

import com.example.demo.dto.EnrollmentDTO;
import com.example.demo.dto.Student_EnrollmentDTO;
import com.example.demo.services.EnrollmentService;
import com.example.demo.services.Student_EnrollmentService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController()
public class EnrollmentController {
    @Autowired
    private EnrollmentService enrollmentService;
    @Autowired
    private Student_EnrollmentService student_enrollmentImpl;
    @GetMapping("/dangkyhocphan/lophocphan")
    public List<EnrollmentDTO> getAllEnrollmentByCourseID(@RequestParam("courseID") String courseID){
        return enrollmentService.getAllEnrollmentByCourseID(courseID);
    }
    @GetMapping("/dangkyhocphan/lophocphan/sinhvien")
    public List<EnrollmentDTO> getAllEnrollmentByStudentID(@RequestParam("studentID") String studentID, @RequestParam("semester") int semester, @RequestParam("year") int year){
        return enrollmentService.getAllEnrollmentByStudentID(studentID, semester, year);
    }

    @PostMapping("/dangkyhocphan/lophocphan/sinhvien/dangky")
    public Map<String,Object> registerEnrollment(@RequestBody Student_EnrollmentDTO studentEnrollmentDTO) {
        return (Map<String, Object>) new HashMap<>().put("result",student_enrollmentImpl.registerEnrollment(studentEnrollmentDTO));
    }
    @GetMapping("/dangkyhocphan/lophocphan/chitietlophocphan")
    public EnrollmentDTO getAllEnrollmentById(@RequestParam("enrollmentID") String enrollmentID){
        return enrollmentService.getAllEnrollmentById(enrollmentID);
    }
    @PostMapping("/dangkyhocphan/lophocphan/sinhvien/huydangky")
    public String cancelEnrollment(@RequestBody Student_EnrollmentDTO studentEnrollmentDTO) {
        return student_enrollmentImpl.cancelEnrollment(studentEnrollmentDTO);
    }
    @GetMapping("/admin/monhoc/lophocphan")
    public List<EnrollmentDTO> getAllEnrollmentByCourseIDInSemesterAndYear(@RequestParam("courseID") String courseID, @RequestParam("semester") int semester, @RequestParam("year") int year){
        return enrollmentService.getAllEnrollmentByCourseIDInSemesterAndYear(courseID, semester, year);
    }
    @PostMapping("/admin/monhoc/themlophocphan")
    public Map<String,Object> addEnrollment(@RequestBody EnrollmentDTO enrollmentDTO){
        return (Map<String, Object>) new HashMap<>().put("result",enrollmentService.addEnrollment(enrollmentDTO));
    }
    @GetMapping("/admin/monhoc/lophocphan/malophocphan")
    public Map<String,Object> getEnrollmentID(@RequestParam("courseID") String courseID){
        return (Map<String, Object>) new HashMap<>().put("result",enrollmentService.getEnrollmentID(courseID));
    }
    @GetMapping("/admin/monhoc/lophocphan/tenlophocphan")
    public Map<String,Object> getEnrollmentName(@RequestParam("majorID") String majorID){
        return (Map<String, Object>) new HashMap<>().put("result",enrollmentService.getEnrollmentName(majorID));
    }
}
