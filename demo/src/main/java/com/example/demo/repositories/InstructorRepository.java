package com.example.demo.repositories;

import com.example.demo.entities.Instructor;
import jdk.jfr.Registered;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface InstructorRepository extends JpaRepository<Instructor, String> {
    List<Instructor> findInstructorsByMajorMajorID(String major);
}