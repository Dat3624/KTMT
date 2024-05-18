package com.example.demo.entities;

import jakarta.persistence.*;
import lombok.*;

import java.util.List;

@Entity
@Getter
@Setter
@NoArgsConstructor
@AllArgsConstructor
@Table(name = "enrollmentPractives")
public class EnrollmentP {
    @Id
    private String enrollmentPID;
    private String name;
    private String room;
    private int quantity;

    @OneToOne(mappedBy = "enrollmentP",cascade = CascadeType.ALL, fetch = FetchType.EAGER)
    private Schedule scheduleStudy;
    @ManyToOne
    @JoinColumn(name = "enrollmentID")
    private Enrollment enrollment;
    @OneToOne
    @JoinColumn(name = "id")
    private Instructor instructor;

    @Override
    public String toString() {
        return "EnrollmentP{" +
                "enrollmentPID='" + enrollmentPID + '\'' +
                ", name='" + name + '\'' +
                ", room='" + room + '\'' +
                ", quantity=" + quantity +
                ", scheduleStudy=" + scheduleStudy +
                ", instructor=" + instructor +
                '}';
    }
}
