package com.example.demo.services.impl;

import com.example.demo.dto.CourseDTO;
import com.example.demo.entities.Course;
import com.example.demo.entities.Major;
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
import java.util.concurrent.atomic.AtomicInteger;
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
        // Check if student exists
        if(studentRepository.findById(studentID).orElse(null)==null){
            return null;
        }
        String majorID = studentRepository.findById(studentID).orElse(null).getMajor().getMajorID();
        Major major = majorRepository.findById(majorID).orElse(null);
        assert major != null;
        List<Course> courses = major.getCourses();
        List<Course> elementsRemove = new ArrayList<>();
        AtomicInteger flag = new AtomicInteger();
        courses.forEach((element)->{
            enrollmentRepository.findEnrollmentsByCourse_CourseID(element.getCourseID()).forEach((enrollment)->{

                if((enrollment.getSemester()!=semester || enrollment.getYear()!=year)&& flag.get() ==0&&!elementsRemove.contains(element)){
                    elementsRemove.add(element);

                }
                if(enrollment.getSemester()==semester && enrollment.getYear()==year){
                    elementsRemove.remove(element);

                    flag.set(1);
                }
            });
            flag.set(0);
            if (enrollmentRepository.findEnrollmentsByCourse_CourseID(element.getCourseID()).isEmpty()){
                elementsRemove.add(element);
            }
            student_enrollmentRepository.findStudent_EnrollmentsByStudentStudent(studentRepository.findById(studentID).orElse(null)).forEach((student_enrollment)->{
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
        List<Course> courses = new ArrayList<>();
         courseRepository.findAll().forEach((element) -> {
            if (element.getCourseAfter() != null) {
                if (element.getCourseAfter().getCourseID().equals(courseID)) {
                    courses.add(element);
                }
            }
        });
        return courses;
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
        if (!Objects.equals(courseDTO.getPrerequisites(), "")){
            String[] prerequisites = courseDTO.getPrerequisites().split(",");
            for (String prerequisite : prerequisites) {
                if (courseRepository.findById(prerequisite).orElse(null)==null){
                    return "Prerequisites not found";
                }
            }
        }
        if (courseDTO.getCredits()<0){
            return "Credits must be positive";
        }
        if (courseDTO.getType().isEmpty()){
            return "Type must not be empty";
        }
        if (courseRepository.findByName(courseDTO.getName())!=null){
            Course c = courseRepository.findByName(courseDTO.getName());
            List<Major> majors = new ArrayList<>(c.getMajors());
            majors.add(majorRepository.findById(courseDTO.getMajorsID()).orElse(null));
            c.setMajors(majors);
            courseRepository.saveAndFlush(c);
            entityManager.flush();
            entityManager.clear();
            return "Course already exists in another major, so add this major to the course";
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
    public void updatePrerequisites(String courseID, String prerequisitesID){
        Course course = courseRepository.findById(courseID).orElse(null);
        if(course==null){
            return;
        }
        String[] prerequisites = prerequisitesID.split(",");

        for (String prerequisite : prerequisites) {
            Course course1 = courseRepository.findById(prerequisite).orElse(null);
            if(course1==null){
                return;
            }
            course.setCourseAfter(course1);
            courseRepository.saveAndFlush(course);
            entityManager.flush();
            entityManager.clear();
        }
    }
}
