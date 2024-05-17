package com.example.demo.services.impl;

import com.example.demo.dto.MajorDTO;
import com.example.demo.repositories.MajorRepository;
import com.example.demo.services.MajorService;
import org.modelmapper.ModelMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;
import java.util.stream.Collectors;

@Service
public class MajorImpl implements MajorService {
    @Autowired
    private MajorRepository majorRepository;
    @Autowired
    private ModelMapper modelMapper;
    @Override
    public List<MajorDTO> getAllMajors() {
        return majorRepository.findAll().stream().map((element) -> modelMapper.map(element, MajorDTO.class)).collect(Collectors.toList());
    }
}
