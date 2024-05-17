package com.example.demo.services.impl;

import com.example.demo.dto.CourseDTO;
import com.example.demo.entities.Course;
import com.example.demo.entities.Major;
import com.example.demo.entities.Student_Enrollment;
import com.example.demo.repositories.*;
import com.example.demo.services.CourseService;
import jakarta.persistence.EntityManager;
import jakarta.persistence.PersistenceContext;
import jakarta.transaction.Transactional;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Objects;
import java.util.stream.Collectors;

@Service
public class CourseImpl implements CourseService {
    @Autowired
    private CourseRepository courseRepository;
    @Autowired
    private MajorRepository majorRepository;
    @Autowired
    private StudentRepository studentRepository;
    @Autowired
    private ModelMapper modelMapper;
    @Autowired
    private EnrollmentRepository enrollmentRepository;
    @Autowired
    private Student_EnrollmentRepository student_enrollmentRepository;
    @PersistenceContext
    private EntityManager entityManager;
    @Override
    public List<Course> getAllCourses() {
        return courseRepository.findAll();
    }

    @Override
    public List<CourseDTO> getAllCoursesOfMajorInSemester(String studentID, int semester, int year) {
        if(studentRepository.findById(studentID).orElse(null)==null){
            return null;
        }
        String majorID = studentRepository.findById(studentID).orElse(null).getMajor().getMajorID();
        Major major = majorRepository.findById(majorID).orElse(null);
        assert major != null;
        List<Course> courses = major.getCourses();
        courses.forEach(e->{
            System.out.println(e.getCourseID());
        });
        List<Course> elementsRemove = new ArrayList<>();
        courses.forEach((element)->{
            enrollmentRepository.findEnrollmentsByCourse_CourseID(element.getCourseID()).forEach((enrollment)->{
                if(enrollment.getSemester()!=semester || enrollment.getYear()!=year){
                    elementsRemove.add(element);
                }
            });
            if (enrollmentRepository.findEnrollmentsByCourse_CourseID(element.getCourseID()).isEmpty()){
                elementsRemove.add(element);
            }
            student_enrollmentRepository.findStudent_EnrollmentsByStudentStudentAndEnrollment_SemesterAndEnrollment_Year(studentRepository.findById(studentID).orElse(null),semester,year).forEach((student_enrollment)->{
                if(student_enrollment.getEnrollment().getCourse().getCourseID().equals(element.getCourseID())){
                    elementsRemove.add(element);
                }
            });
        });
        courses.removeAll(elementsRemove);
        return getCourseDTOS(courses);
    }

    private List<CourseDTO> getCourseDTOS(List<Course> courses) {
        return courses.stream().map((element) -> {
            List<Course> perquisites =getPerquisites(element.getCourseID());
            CourseDTO courseDTO = modelMapper.map(element, CourseDTO.class);
            courseDTO.setPrerequisites("");
            if(perquisites==null){
                return courseDTO;
            }
            if(!perquisites.isEmpty()){
                perquisites.forEach((perquisiteCourse)->{
                    if(perquisiteCourse!=null)
                    courseDTO.setPrerequisites(courseDTO.getPrerequisites()+" "+perquisiteCourse.getCourseID()+" ");
                });
            }
            return courseDTO;
        }).collect(Collectors.toList());
    }

    @Override
    public List<Course> getPerquisites(String courseID) {
        return courseRepository.findAll().stream().map((element) -> {
            if (element.getCourseAfter() != null) {
                if (element.getCourseAfter().getCourseID().equals(courseID))
                    return element;
                return null;
            } else {
                return null;
            }
        }).collect(Collectors.toList());
    }

    @Override
    public List<CourseDTO> getAllCourseByMajor(String majorID) {
        Major major = majorRepository.findById(majorID).orElse(null);
        if(major!=null){
            List<Course> courses = major.getCourses();
            return getCourseDTOS(courses);
        }
        return null;
    }
    @Transactional
    @Override
    public String addCourse(CourseDTO courseDTO) {
        if (courseRepository.findById(courseDTO.getCourseID()).orElse(null)!=null){
            return "Course already exists";
        }
        if (majorRepository.findById(courseDTO.getMajorsID()).orElse(null)==null){
            return "Major not found";
        }
        if (!Objects.equals(courseDTO.getPrerequisites(), "") && courseRepository.findById(courseDTO.getPrerequisites()).orElse(null)==null){
            return "Prerequisites not found";
        }
        if (courseDTO.getCredits()<0){
            return "Credits must be positive";
        }
        if (courseDTO.getType().isEmpty()){
            return "Type must not be empty";
        }
        Course course = modelMapper.map(courseDTO, Course.class);

        List<Major> majors = new ArrayList<>();
        majors.add(majorRepository.findById(courseDTO.getMajorsID()).orElse(null));
        course.setMajors(majors);
        courseRepository.saveAndFlush(course);
        entityManager.flush();
        entityManager.clear();
        return "Success";
    }
    @Transactional
    @Override
    public boolean updatePrerequisites(String courseID, String prerequisitesID){
        Course course = courseRepository.findById(courseID).orElse(null);
        if(course==null){
            return false;
        }
        Course prerequisites = courseRepository.findById(prerequisitesID).orElse(null);
        if(prerequisites==null){
            return false;
        }
        prerequisites.setCourseAfter(course);
        courseRepository.saveAndFlush(prerequisites);
        return true;
    }
}
