package com.example.demo.services;

import com.example.demo.dto.CourseDTO;
import com.example.demo.entities.Course;

import java.util.List;

public interface CourseService {
    List<Course> getAllCourses();
    List<CourseDTO> getAllCoursesOfMajorInSemester(String StudentID, int semester, int year);
    List<Course> getPerquisites(String courseID);
    List<CourseDTO> getAllCourseByMajor(String majorID);

    String addCourse(CourseDTO courseDTO);
    public void updatePrerequisites(String courseID, String prerequisitesID);
}
