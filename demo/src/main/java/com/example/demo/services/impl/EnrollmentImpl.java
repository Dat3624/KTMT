package com.example.demo.services.impl;

import com.example.demo.dto.EnrollmentDTO;
import com.example.demo.dto.ScheduleDTO;
import com.example.demo.entities.*;
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
    @Autowired
    private ScheduleRepository scheduleRepository;

    @Override
    public List<EnrollmentDTO> getAllEnrollmentByCourseID(String courseID) {
        if(!enrollmentRepository.findEnrollmentsByCourse_CourseID(courseID).isEmpty()){
            return enrollmentRepository.findEnrollmentsByCourse_CourseID(courseID).stream().map((element)->{
                String nameInstructor = element.getInstuctor().getName();
                int quantityApply = element.getStudentEnrollments().size();
                List<ScheduleDTO> scheduleDTOS = element.getScheduleStudy().stream().map((element1)->{
                    return modelMapper.map(element1, ScheduleDTO.class);
                }).toList();
                ScheduleDTO scheduleDTOexam = modelMapper.map(element.getExam(), ScheduleDTO.class);
                EnrollmentDTO enrollmentDTO = modelMapper.map(element, EnrollmentDTO.class);
                enrollmentDTO.setScheduleStudy(scheduleDTOS);
                enrollmentDTO.setExam(scheduleDTOexam);
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
                List<ScheduleDTO> scheduleDTOS = enrollment.getScheduleStudy().stream().map((element1)->{
                    return modelMapper.map(element1, ScheduleDTO.class);
                }).toList();
                ScheduleDTO scheduleDTOexam = modelMapper.map(enrollment.getExam(), ScheduleDTO.class);
                EnrollmentDTO enrollmentDTO = modelMapper.map(enrollment, EnrollmentDTO.class);
                enrollmentDTO.setScheduleStudy(scheduleDTOS);
                enrollmentDTO.setExam(scheduleDTOexam);
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
            enrollmentDTO.setNameInstuctor(nameInstructor);
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
        enrollmentDTO.getScheduleStudy().stream().map((element) -> modelMapper.map(element, Schedule.class)).collect(Collectors.toList());
        enrollmentDTO.getEnrollmentPs().forEach((element)->{
                if (scheduleImpl.checkScheduleByRoomTHName(element.getRoom(),element.getScheduleStudy())){
                    check.set(true);
                }
        });
        enrollmentDTO.getScheduleStudy().forEach((element)->{
            if (scheduleImpl.checkScheduleByRoomName(enrollmentDTO.getRoomName(),element)){
                check.set(true);
            }
        });
        if (check.get()){
            return "Schedule is duplicate";
        }
        Course course = courseRepository.findById(enrollmentDTO.getCourseID()).orElse(null);
        List<Instructor> instructors = enrollmentDTO.getEnrollmentPs().stream().map((element)->{
            return instructorRepository.findById(element.getInstructorID()).orElse(null);
        }).toList();
        Enrollment enrollment = modelMapper.map(enrollmentDTO, Enrollment.class);
        AtomicInteger flag = new AtomicInteger(1);
        enrollment.getEnrollmentPs().forEach((element)->{
            element.setEnrollment(enrollment);
            element.setEnrollmentPID(enrollment.getEnrollmentID() + flag.get());
            element.setName("nhom " + flag.get());
            element.getScheduleStudy().setEnrollmentP(element);
            element.setInstructor(instructors.get(flag.get()-1));
            flag.incrementAndGet();

        });
        Instructor instructor = instructorRepository.findById(enrollmentDTO.getInstructorID()).orElse(null);
        enrollment.getScheduleStudy().forEach((element)->{
            element.setEnrollment(enrollment);
        });
        enrollment.setCourse(course);
        enrollment.setInstuctor(instructor);
        List<Student_Enrollment> student_enrollments = new ArrayList<>();
        enrollment.setStudentEnrollments(student_enrollments);
        // lịch rỗng để khi kiểm tra thì thay đổi lịch
        Schedule exam = scheduleRepository.findById(1).orElse(null);
        enrollment.setExam(exam);

        enrollmentRepository.save(enrollment);
        System.out.println(enrollment.getEnrollmentPs());

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
    @Transactional
    @Override
    public String transferEnrollmentStatus(String enrollmentID, EnrollmentStatus status) {
        Enrollment enrollment = enrollmentRepository.findEnrollmentByEnrollmentID(enrollmentID);
        if (enrollment == null){
            return "Enrollment is not exist";
        }
        enrollment.setStatus(status);
        enrollmentRepository.save(enrollment);
        return "Transfer status success";
    }

    @Override
    public String deleteEnrollment(EnrollmentDTO enrollmentDTO) {
        Enrollment enrollment = enrollmentRepository.findEnrollmentByEnrollmentID(enrollmentDTO.getEnrollmentID());
        if (enrollment == null){
            return "Enrollment is not exist";
        }
        Schedule examDelete = new Schedule();
        scheduleRepository.save(examDelete);
        enrollment.setExam(examDelete);
        enrollmentRepository.delete(enrollment);
        return "Delete enrollment success";
    }


}
