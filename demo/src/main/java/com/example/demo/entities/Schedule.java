package com.example.demo.entities;

import jakarta.persistence.*;
import lombok.Getter;
import lombok.Setter;

@Entity
@Getter
@Setter
@Table(name = "schedules")
public class Schedule {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    @Column(name = "scheduleID")
    private int scheduleID;

    private String dayOfWeek;

    private int classesStart;

    private int classesEnd;

    @ManyToOne
    @JoinColumn(name = "enrollmentID")
    private Enrollment enrollment;

    @OneToOne
    @JoinColumn(name = "enrollmentPID")
    private EnrollmentP enrollmentP;

    @OneToOne(mappedBy = "exam", fetch = FetchType.EAGER)
    private Enrollment enrollmentExam;

    public Schedule() {
    }

    public Schedule(String dayOfWeek, int classesStart, int classesEnd) {
        this.dayOfWeek = dayOfWeek;
        this.classesStart = classesStart;
        this.classesEnd = classesEnd;
    }



    @Override
    public String toString() {
        return "Schedule{" +
                "dayOfWeek='" + dayOfWeek + '\'' +
                ", classesStart=" + classesStart +
                ", classesEnd=" + classesEnd +
                '}';
    }
}
