package com.example.demo.controller;

import com.example.demo.dto.InstructorDTO;
import com.example.demo.services.InstructorService;
import lombok.AllArgsConstructor;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
public class InstructorController {
    @Autowired
    private InstructorService instructorImpl;
    @GetMapping("/admin/giangvien")
    public List<InstructorDTO> getAllInstructorsByMajor(@RequestParam String majorID){
        return instructorImpl.getAllInstructorsByMajor(majorID);
    }
}
