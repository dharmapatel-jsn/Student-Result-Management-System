<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Find Result</title>
        <style>
        /* === Global Variables (Easy to change colors!) === */
        :root {
            --bg-gradient-start: #e0eafc; /* Light blue */
            --bg-gradient-end: #f8f9fa;   /* Off-white */
            --card-bg: #ffffff;
            --primary-action: #007bff;
            --action-hover: #0056b3;
            --border-color: #1c1c1c;
            --text-dark: #333;
            --text-light: #555;
            --error-bg: #fff0f0;
            --error-border: #d8000c;
            --table-header: #343a40; /* Dark header */
        }
        
        /* === NEW: Animated Background Keyframes === */
        @keyframes animatedBackground {
            0%   { background-position: 0% 50%; }
            50%  { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }

        /* === Global Styles & Background === */
        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, Helvetica, Arial, sans-serif;
            
            /* --- UPDATED: Animated Gradient --- */
            background: linear-gradient(135deg, 
                var(--bg-gradient-start), 
                var(--bg-gradient-end), 
                var(--bg-gradient-start)
            );
            background-size: 300% 300%;
            animation: animatedBackground 18s ease infinite;
            /* --- End of Update --- */

            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
            margin: 0;
            padding: 1rem;
            color: var(--text-dark);
            transition: background-color 0.3s ease; /* For smooth theme change */
        }

        /* === Fade-in Animation === */
        @keyframes fadeIn {
            from { opacity: 0; transform: translateY(-10px); }
            to   { opacity: 1; transform: translateY(0); }
        }

        /* === The Main "Card" === */
        .container {
            background-color: var(--card-bg);
            padding: 2.5rem; /* More space */
            border-radius: 8px;
            border: 2px solid var(--border-color);
            box-shadow: 8px 8px 0 var(--border-color); /* The "neo-brutalist" shadow */
            width: 90%;
            max-width: 500px;
            animation: fadeIn 0.4s ease-out;
            position: relative; /* Needed for the toggle button */
            transition: background-color 0.3s ease, border-color 0.3s ease;
        }

        /* === Headings === */
        h2 {
            text-align: center;
            color: var(--text-dark);
            border-bottom: none; /* Removed old border */
            margin-top: 0;
            margin-bottom: 2rem;
        }

        h3 {
            color: var(--text-dark);
            border-bottom: 2px solid #eee;
            padding-bottom: 5px;
            margin-top: 2rem;
        }

        /* === Form Styles (index.jsp) === */
        form label {
            display: block; 
            margin-bottom: 8px; 
            text-align: left;
            font-weight: 600;
            color: var(--text-light);
        }

        input[type="text"] {
            width: 95%; /* Adjust for padding */
            padding: 14px; /* Thicker input */
            margin-bottom: 0.5rem; /* Reduced margin */
            border: 2px solid #ddd;
            border-radius: 5px;
            font-size: 1rem;
            transition: all 0.2s ease;
        }

        input[type="text"]:focus {
            border-color: var(--primary-action);
            box-shadow: 0 0 0 3px rgba(0,123,255,0.1);
            outline: none;
        }

        input[type="submit"] {
            width: 100%;
            padding: 14px;
            background-color: var(--primary-action);
            color: white;
            border: 2px solid var(--border-color); /* Match card */
            border-radius: 5px;
            font-size: 1rem;
            font-weight: bold;
            cursor: pointer;
            transition: all 0.2s ease;
            margin-top: 1rem; /* Added margin */
        }

        input[type="submit"]:hover {
            background-color: var(--action-hover);
            box-shadow: 4px 4px 0 var(--border-color); /* Add shadow on hover */
            transform: translateY(-2px); /* Add "lift" on hover */
        }
        
        /* === Validation Error === */
        .validation-error {
            color: var(--error-border);
            font-weight: 600;
            font-size: 0.9rem;
            display: block;
            height: 1rem; /* Reserve space to prevent layout shift */
            text-align: left;
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
        body.dark-mode input[type="text"] {
            background-color: #4a5568;
            border-color: #718096;
            color: #f7fafc;
        }
        body.dark-mode input[type="text"]::placeholder {
            color: #a0aec0;
        }
        body.dark-mode input[type="text"]:focus {
            border-color: var(--primary-action);
        }
        body.dark-mode input[type="submit"]:hover {
            box-shadow: 4px 4px 0 var(--border-color);
        }
        body.dark-mode a.button-link:hover {
            box-shadow: 4px 4px 0 var(--border-color);
        }
        body.dark-mode .validation-error {
            color: var(--error-border);
        }
        </style>
    </head>
    
    <body>
        <div class="container">
            <button id="theme-toggle" class="theme-toggle">🌙</button>
            
            <h2>Student Result Management System</h2>
            
            <form action="ResultServlet" method="post" id="resultForm" onsubmit="return validateForm()">
                
                <label for="student_id">Enter Student ID:</label>
                
                <input type="text" id="student_id" name="student_id" placeholder="e.g., S101" />
                
                <span class="validation-error" id="error-msg"></span>
                
                <input type="submit" value="Find Result" />
            </form>
        </div>

        <script>
            // --- Validation ---
            function validateForm() {
                const studentIdInput = document.getElementById("student_id");
                const errorMsg = document.getElementById("error-msg");
                
                // .trim() removes whitespace from both ends
                if (studentIdInput.value.trim() === "") {
                    errorMsg.textContent = "Student ID cannot be empty.";
                    studentIdInput.focus(); // Put cursor back in the box
                    return false; // Stop form submission
                }
                
                // Clear error if valid
                errorMsg.textContent = "";
                return true; // Allow form submission
            }

            // --- Theme Toggle ---
            (function () {
                const toggleBtn = document.getElementById("theme-toggle");
                const body = document.body;

                // Function to apply the saved theme
                function applyTheme(isDark) {
                    if (isDark) {
                        body.classList.add("dark-mode");
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