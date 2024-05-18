package com.example.demo.controller;

import com.example.demo.dto.CourseDTO;
import com.example.demo.services.CourseService;
import com.example.demo.services.impl.CourseImpl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

@RestController
public class CourseController {
    @Autowired
    private CourseService courseImpl;
    @GetMapping("/dangkyhocphan")
    public List<CourseDTO> getAllCourseByMajorAndSemester(@RequestParam("studentID") String studentID,
                                                          @RequestParam("semester") int semester,
                                                          @RequestParam("year") int year){

        List<CourseDTO> courseDTOS = courseImpl.getAllCoursesOfMajorInSemester(studentID, semester, year);
        return courseDTOS;
    }
@GetMapping("/admin/monhoc")
    public List<CourseDTO> getAllCourse(@RequestParam("majorID") String majorID){
        return courseImpl.getAllCourseByMajor(majorID);
    }

@PostMapping("/admin/monhoc")
    public Map<String,Object> addCourse(@RequestBody CourseDTO courseDTO){
        String result = courseImpl.addCourse(courseDTO);
        if(!courseDTO.getPrerequisites().isEmpty()){
            courseImpl.updatePrerequisites(courseDTO.getCourseID(), courseDTO.getPrerequisites());
        }
        Map<String, Object> map = new HashMap<>();
        map.put("result", result);
        return map;
    }
    @GetMapping("/admin/monhoc/lophocphan/mamonhoc")
    public Map<String,Object> getCourseID(){
        Map<String, Object> result = new HashMap<>();
        result.put("result", "C"+courseImpl.getAllCourses().size() + 1);
        return result;
    }
}
