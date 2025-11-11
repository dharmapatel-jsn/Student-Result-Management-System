package com.mycompany.results.servlets;

import com.mycompany.results.models.Student;
import com.mycompany.results.models.SubjectResult;
import com.mycompany.results.util.DatabaseUtil;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

// This annotation maps the URL /ResultServlet to this class
@WebServlet(name = "ResultServlet", urlPatterns = {"/ResultServlet"})
public class ResultServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String studentId = request.getParameter("student_id");
        Student student = null;
        List<SubjectResult> results = new ArrayList<>();

        // SQL Queries
        String studentQuery = "SELECT * FROM students WHERE student_id = ?";
        String resultsQuery = "SELECT s.subject_name, s.max_marks, r.marks_obtained " +
                              "FROM results r " +
                              "JOIN subjects s ON r.subject_id_fk = s.subject_id " +
                              "WHERE r.student_id_fk = ?";

        try (Connection conn = DatabaseUtil.getConnection()) {
            
            // --- Query 1: Get Student Details ---
            try (PreparedStatement pstmt1 = conn.prepareStatement(studentQuery)) {
                pstmt1.setString(1, studentId);
                try (ResultSet rs1 = pstmt1.executeQuery()) {
                    if (rs1.next()) {
                        student = new Student();
                        student.setStudentId(rs1.getString("student_id"));
                        student.setFirstName(rs1.getString("first_name"));
                        student.setLastName(rs1.getString("last_name"));
                        student.setClassName(rs1.getString("class_name"));
                    }
                }
            }

            // --- Query 2: Get Student Results (only if student was found) ---
            if (student != null) {
                try (PreparedStatement pstmt2 = conn.prepareStatement(resultsQuery)) {
                    pstmt2.setString(1, studentId);
                    try (ResultSet rs2 = pstmt2.executeQuery()) {
                        while (rs2.next()) {
                            SubjectResult res = new SubjectResult();
                            res.setSubjectName(rs2.getString("subject_name"));
                            res.setMarksObtained(rs2.getInt("marks_obtained"));
                            res.setMaxMarks(rs2.getInt("max_marks"));
                            results.add(res);
                        }
                    }
                }
            }

        } catch (SQLException e) {
            throw new ServletException("Database error", e);
        }

        // Set attributes to pass to the JSP
        request.setAttribute("student", student); // This will be null if not found
        request.setAttribute("results", results); // This will be empty if not found

        // Forward to the display JSP
        RequestDispatcher rd = request.getRequestDispatcher("display.jsp");
        rd.forward(request, response);
    }
}