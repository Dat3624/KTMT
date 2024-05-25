package com.example.demo.services;

import com.example.demo.dto.EnrollmentDTO;
import com.example.demo.entities.EnrollmentStatus;
import com.example.demo.entities.Schedule;
import org.springframework.stereotype.Service;

import java.util.List;
public interface EnrollmentService {
List<EnrollmentDTO> getAllEnrollmentByCourseID(String courseID);
EnrollmentDTO getAllEnrollmentById(String enrollmentID);
List<EnrollmentDTO> getAllEnrollmentByStudentID(String studentID, int semester, int year);
List<EnrollmentDTO> getAllEnrollmentByCourseIDInSemesterAndYear(String courseID,int semester, int year);
String addEnrollment(EnrollmentDTO enrollmentDTO);
String getEnrollmentID(String courseID);
String getEnrollmentName(String majorID);
String transferEnrollmentStatus(String enrollmentID, EnrollmentStatus status);
String deleteEnrollment(EnrollmentDTO enrollmentDTO);
}
