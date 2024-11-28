Web Technology Project

Project Overview

This project involves the development of a web-based application designed to facilitate front-end and back-end interactions. The application includes features such as user login, blog management, image upload, and more. The project also implements various technologies like JSP, AJAX, JDBC, and Session/Cookie management for user authentication.

Technologies Used:

	•	Frontend: HTML, CSS, JavaScript (AJAX), JSP
	•	Backend: Java, Servlet, JDBC
	•	Database: MySQL
	•	File Handling: Image upload and storage using Servlet

Features:

	1.	User Authentication:
	•	Login functionality using username, password, and CAPTCHA.
	•	Session management for persistent login.
	2.	Blog Management:
	•	Display, add, edit, and delete blog posts.
	•	Each blog post includes a title, content, and image.
	3.	Image Upload:
	•	Users can upload images for blogs or personal use.
	•	Images are stored on the server and accessed via a unique URL.
	4.	Database Interaction:
	•	Uses JDBC for connecting to a MySQL database for storing and retrieving blog and user data.
	•	Data persistence for blog content and user profile information.
	5.	AJAX for Asynchronous Communication:
	•	Implements AJAX to update the page dynamically without requiring a full reload.

Project Structure:

Backend (/src/com.pb)

	•	Controller: Handles HTTP requests for various features (login, blog, image management, etc.)
	•	DAO: Data Access Objects for interacting with the database.
	•	DTO: Data Transfer Objects for transferring data between layers.
	•	Service: Business logic for managing user and blog data.

Frontend (/web)

	•	HTML, CSS, and JSP files for the user interface and interaction.
	•	Includes static pages like admin.html, login.jsp, and blog.jsp.

Database:

	•	MySQL database for storing user and blog information.
	•	JDBC utilities for database connection management.

Setup Instructions:

	1.	Clone the Repository:

git clone https://github.com/jxx4gthb/PersonalBlogSystem.git


	2.	Set Up the Database:
	•	Import the provided MySQL database schema into your local MySQL server.
	•	Modify the database connection settings in JDBCUtil.java if needed.
	3.	Run the Application:
	•	Set up Apache Tomcat as your server.
	•	Ensure the server is running on port 8080 (or modify the port if needed).
	•	Deploy the project to Tomcat.
	4.	Access the Web Application:
	•	Open a browser and navigate to http://localhost:8080.

Core Concepts:

	•	JSP: JavaServer Pages for dynamic content generation.
	•	AJAX: Asynchronous JavaScript for dynamic, real-time user interactions.
	•	JDBC: Java Database Connectivity for database interaction.

Screenshots:

Login page for user authentication.

Admin panel for blog management.

License

This project is licensed under the MIT License - see the LICENSE file for details.
