package com.example.demo.repositories;

import com.example.demo.entities.Enrollment;
import com.example.demo.entities.Schedule;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.stereotype.Repository;

import java.util.Collection;
import java.util.List;

@Repository
public interface EnrollmentRepository extends JpaRepository<Enrollment, String> {
    List<Enrollment> findEnrollmentsByCourse_CourseID(String courseID);
    Enrollment findEnrollmentByEnrollmentID(String enrollmentID);
    List<Enrollment> findEnrollmentsByCourse_CourseIDAndSemesterAndYear(String courseID, int semester, int year);
    @Query("select max(e.enrollmentID) from Enrollment e where e.course.courseID = ?1")
    String getEnrollmentID(String courseID);
    @Query("SELECT e from Enrollment e where e.name like %?1%")
    List<Enrollment> findEnrollmentsByName(String name);

}