<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@page import="com.mycompany.results.models.Student"%>
<%@page import="com.mycompany.results.models.SubjectResult"%>
<%@page import="java.util.List"%>

<!DOCTYPE html>
<html>
    <head>
        <title>Student Report</title>
        
        <style>
            /* === Global Variables === */
            :root {
                --bg-gradient-start: #e0eafc;
                --bg-gradient-end: #f8f9fa;
                --card-bg: #ffffff;
                --primary-action: #007bff;
                --action-hover: #0056b3;
                --border-color: #1c1c1c;
                --text-dark: #333;
                --text-light: #555;
                --error-bg: #fff0f0;
                --error-border: #d8000c;
                --table-header: #343a40;
            }
            
            /* === Animated Background Keyframes === */
            @keyframes animatedBackground {
                0%   { background-position: 0% 50%; }
                50%  { background-position: 100% 50%; }
                100% { background-position: 0% 50%; }
            }

            /* === Global Styles & Background === */
            body {
                font-family: 'Inter', -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
                
                /* --- Animated Gradient --- */
                background: linear-gradient(135deg, 
                    var(--bg-gradient-start), 
                    var(--bg-gradient-end), 
                    var(--bg-gradient-start)
                );
                background-size: 300% 300%;
                animation: animatedBackground 18s ease infinite;
                
                display: flex;
                justify-content: center;
                align-items: center; 
                min-height: 100vh;
                margin: 0;
                padding: 1rem;
                color: var(--text-dark);
                transition: background-color 0.3s ease;
            }

            /* === Fade-in Animation === */
            @keyframes fadeIn {
                from { opacity: 0; transform: translateY(-10px); }
                to   { opacity: 1; transform: translateY(0); }
            }

            /* === The Main "Card" === */
            .container {
                background-color: var(--card-bg);
                padding: 2.5rem;
                border-radius: 8px;
                border: 2px solid var(--border-color);
                box-shadow: 8px 8px 0 var(--border-color);
                width: 90%;
                max-width: 500px;
                animation: fadeIn 0.4s ease-out;
                position: relative; /* Needed for toggle button */
                transition: background-color 0.3s ease, border-color 0.3s ease;
            }

            /* === Headings === */
            h2 {
                text-align: center;
                color: var(--text-dark);
                border-bottom: none;
                margin-top: 0;
                margin-bottom: 2rem;
            }
            h3 {
                color: var(--text-dark);
                border-bottom: 2px solid #eee;
                padding-bottom: 5px;
                margin-top: 2rem;
            }
            
            /* === Result Page Styles === */
            .student-info {
                background-color: #f9f9f9;
                border: 2px solid #eee;
                border-radius: 5px;
                padding: 1rem;
                margin-bottom: 1.5rem;
                line-height: 1.6;
            }
            table {
                border-collapse: collapse;
                width: 100%;
                margin-bottom: 1.5rem;
                border: 2px solid #dee2e6;
            }
            th {
                background-color: var(--table-header);
                color: white;
                padding: 14px 12px;
                text-align: left;
            }
            td {
                border: 1px solid #ddd;
                padding: 12px;
            }
            tr:nth-child(even) {
                background-color: #f9f9f9;
            }
            tr:hover {
                background-color: #e9ecef;
            }
            .error {
                color: var(--error-border);
                background-color: var(--error-bg);
                border: 2px solid var(--error-border);
                padding: 1rem;
                border-radius: 5px;
                font-weight: 600;
            }
            a.button-link {
                display: inline-block;
                background-color: #6c757d;
                color: white;
                padding: 12px 18px;
                text-decoration: none;
                border-radius: 5px;
                border: 2px solid var(--border-color);
                font-weight: 600;
                transition: all 0.2s ease;
                margin-top: 1rem;
            }
            a.button-link:hover {
                background-color: #5a6268;
                box-shadow: 4px 4px 0 var(--border-color);
                transform: translateY(-2px);
            }
            
            /* === Theme Toggle Button === */
            .theme-toggle {
                position: absolute;
                top: 1.5rem;
                right: 1.5rem;
                background: none;
                color: var(--text-dark);
                border: 2px solid var(--border-color);
                border-radius: 5px;
                width: 40px;
                height: 40px;
                font-size: 1.2rem;
                cursor: pointer;
                transition: all 0.2s ease;
            }
            .theme-toggle:hover {
                background-color: #f0f2f5;
            }

            /* === Dark Mode Styles === */
            body.dark-mode {
                --bg-gradient-start: #28313B;
                --bg-gradient-end: #1a202c;
                --card-bg: #2d3748;
                --border-color: #f7fafc; /* Light border */
                --text-dark: #f7fafc;    /* Light text */
                --text-light: #a0aec0;   /* Lighter gray text */
                --error-bg: #4A2B2B;
                --error-border: #f56565;
                --table-header: #1a202c;
            }
            body.dark-mode .container {
                 box-shadow: 8px 8px 0 var(--border-color);
            }
            body.dark-mode .theme-toggle {
                background-color: var(--card-bg);
                color: var(--text-dark);
            }
            body.dark-mode .theme-toggle:hover {
                background-color: #4a5568;
            }
            body.dark-mode .student-info {
                background-color: #384252;
                border-color: #4a5568;
            }
            body.dark-mode table {
                border-color: #4a5568;
            }
            body.dark-mode td {
                border-color: #4a5568;
            }
            body.dark-mode tr:nth-child(even) {
                background-color: #384252;
            }
            body.dark-mode tr:hover {
                background-color: #4a5568;
            }
            body.dark-mode .error {
                background-color: var(--error-bg);
                border-color: var(--error-border);
                color: #fff;
            }
            body.dark-mode a.button-link {
                border-color: var(--border-color);
            }
            body.dark-mode a.button-link:hover {
                box-shadow: 4px 4px 0 var(--border-color);
            }
        </style>
    </head>
    
    <body>
        <div class="container">
            <button id="theme-toggle" class="theme-toggle">🌙</button>
            
            <h2>Student Result Report</h2>
            
            <%
                Student s = (Student) request.getAttribute("student");
                List<SubjectResult> results = (List<SubjectResult>) request.getAttribute("results");
                
                if (s != null) {
            %>
                    <div class="student-info">
                        <b>Student ID:</b> <%= s.getStudentId() %> <br/>
                        <b>Name:</b> <%= s.getFirstName() %> <%= s.getLastName() %> <br/>
                        <b>Class:</b> <%= s.getClassName() %>
                    </div>
                    
                    <h3>Results:</h3>
                    
                    <% if (results.isEmpty()) { %>
                        <p>No results found for this student.</p>
                    <% } else { %>
                        <table>
                            <tr>
                                <th>Subject</th>
                                <th>Marks Obtained</th>
                                <th>Max Marks</th>
                            </tr>
                            <%
                                for (SubjectResult res : results) {
                            %>
                            <tr>
                                <td><%= res.getSubjectName() %></td>
                                <td><%= res.getMarksObtained() %></td>
                                <td><%= res.getMaxMarks() %></td>
                            </tr>
                            <%
                                } // End of for loop
                            %>
                        </table>
                    <%
                        } // End of else (results.isEmpty)
                    %>

            <%
                } else {
            %>
                    <p class="error">
                        <b>No student found with ID:</b>
                        <%= request.getParameter("student_id") %>
                    </p>
            <%
                } // End of else (s != null)
            %>
            
            <br/>
            <a href="index.jsp" class="button-link">Check another result</a>
        
        </div> <script>
            // --- Theme Toggle ---
            (function () {
                const toggleBtn = document.getElementById("theme-toggle");
                const body = document.body;

                // Function to apply the saved theme
                function applyTheme(isDark) {
                    if (isDark) {
                        body.classList.add("dark-mode"); // <-- THIS IS THE FIX
                        toggleBtn.textContent = "☀️"; // Sun icon
                    } else {
                        body.classList.remove("dark-mode");
                        toggleBtn.textContent = "🌙"; // Moon icon
                    }
                }
                
                // Function to set and save the theme
                function setTheme(isDark) {
                    applyTheme(isDark);
                    localStorage.setItem("theme", isDark ? "dark" : "light");
                }

                // Click listener
                toggleBtn.addEventListener("click", () => {
                    const isDarkMode = body.classList.contains("dark-mode");
                    setTheme(!isDarkMode); // Toggle the theme
                });

                // Check localStorage on page load
                const savedTheme = localStorage.getItem("theme");
                if (savedTheme === "dark") {
                    applyTheme(true);
                } else {
                    applyTheme(false); // Default to light
                }
            })();
        </script>
    </body>
</html>