package com.example.demo.services;

import com.example.demo.dto.InstructorDTO;

import java.util.List;

public interface InstructorService {
    public List<InstructorDTO> getAllInstructorsByMajor(String majorID);
}
