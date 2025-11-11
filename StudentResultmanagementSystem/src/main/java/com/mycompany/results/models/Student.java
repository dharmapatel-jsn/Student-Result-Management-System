package com.mycompany.results.models;

// Model for the 'students' table
public class Student {
    private String studentId;
    private String firstName;
    private String lastName;
    private String className;

    // Getters
    public String getStudentId() { return studentId; }
    public String getFirstName() { return firstName; }
    public String getLastName() { return lastName; }
    public String getClassName() { return className; }

    // Setters
    public void setStudentId(String studentId) { this.studentId = studentId; }
    public void setFirstName(String firstName) { this.firstName = firstName; }
    public void setLastName(String lastName) { this.lastName = lastName; }
    public void setClassName(String className) { this.className = className; }
}