package com.mycompany.results.models;

// Model to hold a single subject's result
public class SubjectResult {
    private String subjectName;
    private int marksObtained;
    private int maxMarks;

    // Getters
    public String getSubjectName() { return subjectName; }
    public int getMarksObtained() { return marksObtained; }
    public int getMaxMarks() { return maxMarks; }

    // Setters
    public void setSubjectName(String subjectName) { this.subjectName = subjectName; }
    public void setMarksObtained(int marksObtained) { this.marksObtained = marksObtained; }
    public void setMaxMarks(int maxMarks) { this.maxMarks = maxMarks; }
}