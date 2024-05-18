package com.example.demo.services.impl;

import com.example.demo.dto.EnrollmentDTO;
import com.example.demo.entities.Course;
import com.example.demo.entities.Enrollment;
import com.example.demo.entities.Instructor;
import com.example.demo.entities.Student_Enrollment;
import com.example.demo.model.Caculator;
import com.example.demo.repositories.*;
import com.example.demo.services.EnrollmentService;
import com.example.demo.services.ScheduleService;
import jakarta.transaction.Transactional;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.concurrent.atomic.AtomicBoolean;
import java.util.concurrent.atomic.AtomicInteger;
import java.util.stream.Collectors;

@Service
public class EnrollmentImpl implements EnrollmentService {
    @Autowired
    private EnrollmentRepository enrollmentRepository;
    @Autowired
    private ModelMapper modelMapper;
    @Autowired
    private Student_EnrollmentRepository student_enrollmentRepository;
    @Autowired
    private StudentRepository studentRepository;
    @Autowired
    private CourseRepository courseRepository;
    @Autowired
    private InstructorRepository instructorRepository;
    @Autowired
    private ScheduleService scheduleImpl;

    @Override
    public List<EnrollmentDTO> getAllEnrollmentByCourseID(String courseID) {
        if(!enrollmentRepository.findEnrollmentsByCourse_CourseID(courseID).isEmpty()){
            return enrollmentRepository.findEnrollmentsByCourse_CourseID(courseID).stream().map((element)->{
                String nameInstructor = element.getInstuctor().getName();
                int quantityApply = element.getStudentEnrollments().size();
                EnrollmentDTO enrollmentDTO = modelMapper.map(element, EnrollmentDTO.class);
                enrollmentDTO.setNameInstuctor(nameInstructor);
                enrollmentDTO.setQuantityApply(quantityApply);
                return enrollmentDTO;
            }).collect(Collectors.toList());
        }
        return null;
    }

    @Override
    public List<EnrollmentDTO> getAllEnrollmentByStudentID(String studentID, int semester, int year) {
        if (!studentRepository.existsById(studentID)){
            return null;
        }
        if(!student_enrollmentRepository.findStudent_EnrollmentsByStudentStudentAndEnrollment_SemesterAndEnrollment_Year(studentRepository.findById(studentID).orElse(null),semester,year).isEmpty()){
            return student_enrollmentRepository.findStudent_EnrollmentsByStudentStudentAndEnrollment_SemesterAndEnrollment_Year(studentRepository.findById(studentID).orElse(null),semester,year).stream().map((element)->{
                Enrollment enrollment = enrollmentRepository.findEnrollmentByEnrollmentID(element.getEnrollment().getEnrollmentID());

                EnrollmentDTO enrollmentDTO = modelMapper.map(enrollment, EnrollmentDTO.class);
                enrollmentDTO.setCredit(enrollment.getCourse().getCredits());
                enrollmentDTO.setNameCourse(enrollment.getCourse().getName());
                enrollmentDTO.setCodePractice(element.getCodePractive());
                enrollmentDTO.genPaymentDeadline();
                enrollmentDTO.setFee(Caculator.caculatorFee(enrollment.getCourse().getCredits()));
                enrollmentDTO.setPaymentStatus(element.getPaymentStatus());
                enrollmentDTO.setDateApply(element.getDateApply());
                return enrollmentDTO;
            }).collect(Collectors.toList());
        }
        return null;
    }

    @Override
    public List<EnrollmentDTO> getAllEnrollmentByCourseIDInSemesterAndYear(String courseID, int semester, int year) {
        return enrollmentRepository.findEnrollmentsByCourse_CourseIDAndSemesterAndYear(courseID,semester,year).stream().map((element)->{
            String nameInstructor = element.getInstuctor().getName();
            int quantityApply = element.getStudentEnrollments().size();
            EnrollmentDTO enrollmentDTO = modelMapper.map(element, EnrollmentDTO.class);
            enrollmentDTO.setQuantityApply(quantityApply);
            return enrollmentDTO;
        }).collect(Collectors.toList());
    }



    @Override
    public EnrollmentDTO getAllEnrollmentById(String enrollmentID) {
        Enrollment enrollment = enrollmentRepository.findEnrollmentByEnrollmentID(enrollmentID);
        assert enrollment != null;
        String nameInstructor = enrollment.getInstuctor().getName();

        EnrollmentDTO enrollmentDTO = modelMapper.map(enrollment, EnrollmentDTO.class);
        enrollmentDTO.setNameInstuctor(nameInstructor);

        List<String> nameInstutor = enrollment.getEnrollmentPs().stream().map((element)->{
            return element.getInstructor().getName();
        }).toList();

        AtomicInteger flag = new AtomicInteger();
        enrollmentDTO.getEnrollmentPs().forEach((element)->{
            element.setNameInstructor(nameInstutor.get(flag.get()));
            flag.getAndIncrement();
        });
        return enrollmentDTO;
    }
    @Override
    @Transactional
    public String addEnrollment(EnrollmentDTO enrollmentDTO) {
        if (enrollmentRepository.existsById(enrollmentDTO.getEnrollmentID())){
            return "Enrollment is exist";
        }
        if (!courseRepository.existsById(enrollmentDTO.getCourseID())){
            return "Course is not exist";
        }
        if (enrollmentDTO.getQuantity() < 0){
            return "Quantity is invalid";
        }
        if (!instructorRepository.existsById(enrollmentDTO.getInstructorID())){
            return "Instructor is not exist";
        }
        AtomicBoolean check = new AtomicBoolean(false);
        enrollmentDTO.getScheduleStudy().forEach((element)->{
            if (scheduleImpl.checkScheduleByRoomName(enrollmentDTO.getRoomName(),element)){
                check.set(true);
                return;
            }
        });
        enrollmentDTO.getEnrollmentPs().forEach((element)->{
                if (scheduleImpl.checkScheduleByRoomName(enrollmentDTO.getRoomName(),element.getScheduleStudy())){
                    check.set(true);
                    return;
                }
        });
        if (check.get()){
            return "Schedule is duplicate";
        }
        Course course = courseRepository.findById(enrollmentDTO.getCourseID()).orElse(null);
        Enrollment enrollment = modelMapper.map(enrollmentDTO, Enrollment.class);
        Instructor instructor = instructorRepository.findById(enrollmentDTO.getInstructorID()).orElse(null);
        enrollment.setCourse(course);
        enrollment.setInstuctor(instructor);
        List<Student_Enrollment> student_enrollments = new ArrayList<>();
        enrollment.setStudentEnrollments(student_enrollments);
        enrollmentRepository.save(enrollment);
        return "Add enrollment success";
    }

    @Override
    public String getEnrollmentID(String courseID) {
       int slEnrollment = enrollmentRepository.findEnrollmentsByCourse_CourseID(courseID).size();
         return courseID.substring(1) + "00" + (slEnrollment + 1);
    }

    @Override
    public String getEnrollmentName(String majorID) {
        int slEnrollment = enrollmentRepository.findEnrollmentsByName(majorID).size();
        return "DH" +majorID + Caculator.PROGRAM + (char) (slEnrollment + 64);
    }


}
