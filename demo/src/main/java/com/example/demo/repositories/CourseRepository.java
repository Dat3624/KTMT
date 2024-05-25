package com.example.demo.repositories;

import com.example.demo.entities.Course;
import com.example.demo.entities.Major;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;
@Repository
public interface CourseRepository extends JpaRepository<Course, String> {
    public Course findByName(String name);

}