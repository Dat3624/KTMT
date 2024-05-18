package com.example.demo.services.impl;

import com.example.demo.dto.InstructorDTO;
import com.example.demo.repositories.InstructorRepository;
import com.example.demo.services.InstructorService;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class InstructorImpl implements InstructorService {
@Autowired
    private InstructorRepository instructorRepository;
    @Autowired
    private ModelMapper modelMapper;
    @Override
    public List<InstructorDTO> getAllInstructorsByMajor(String majorID) {
        return  instructorRepository.findInstructorsByMajorMajorID(majorID).stream().map((element) -> modelMapper.map(element, InstructorDTO.class)).collect(Collectors.toList());
    }
}
