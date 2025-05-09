# Employer-Worker-Registration-System

✅ Project Overview.

🎯 Goal:
A system where:

Employers and Workers can register and log in.

Employers can post jobs.

Workers can view jobs and apply.

📁 Project Structure
```ruby
EmployerWorkerSystem/
├── src/
│   ├── com.system.controllers/       → Servlets (RegisterServlet, LoginServlet, etc.)
│   ├── com.system.dao/               → Database operations
│   ├── com.system.model/             → POJOs (User, Job, etc.)
│   └── com.system.utils/             → DB connection class
│
├── WebContent/
│   ├── css/
│   ├── js/
│   ├── images/
│   ├── jsp/
│   │   ├── employer_dashboard.jsp
│   │   ├── worker_dashboard.jsp
│   │   └── job_listings.jsp
│   ├── index.jsp
│   └── WEB-INF/
│       └── web.xml
```
🧾 Database Tables Example (MySQL/PostgreSQL).

```ruby
-- User Table (Employer or Worker)
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(100),
    email VARCHAR(100),
    password VARCHAR(100),
    role ENUM('employer', 'worker')
);

-- Jobs (Posted by Employers)
CREATE TABLE jobs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255),
    description TEXT,
    employer_id INT,
    FOREIGN KEY (employer_id) REFERENCES users(id)
);

-- Applications (Submitted by Workers)
CREATE TABLE applications (
    id INT AUTO_INCREMENT PRIMARY KEY,
    job_id INT,
    worker_id INT,
    FOREIGN KEY (job_id) REFERENCES jobs(id),
    FOREIGN KEY (worker_id) REFERENCES users(id)
);
```
🔧 Core Servlets.

`RegisterServlet.java`  – Handles user registration.

`LoginServlet.java` – Handles authentication and session.

`PostJobServlet.java` – Employer posts a job.

`ApplyJobServlet.java` – Worker applies for job.

🌐 Example: Registration Form (HTML/JSP)

```ruby
<form action="RegisterServlet" method="post">
  <input type="text" name="username" placeholder="Username" required><br>
  <input type="email" name="email" placeholder="Email" required><br>
  <input type="password" name="password" placeholder="Password" required><br>
  <select name="role">
    <option value="employer">Employer</option>
    <option value="worker">Worker</option>
  </select><br>
  <button type="submit">Register</button>
</form>
```
📌 Tips.

Store passwords hashed (e.g., using SHA-256).

Use sessions to manage login state.

Validate inputs both on client (JS) and server (Servlet).

Show different dashboards for employer vs. worker.

🔄 After Form Submission.

The form will send data to your RegisterServlet, where you'll handle:

Validating input

Inserting user into the database

Redirecting to login or dashboard

🧩 Next Steps.

Make sure your `web.xml` or annotations register this servlet.

Test the form and ensure the data is inserted into the database.

Add a `login.jsp` and LoginServlet.java next for authentication.

🔐 Optional: Secure with Session Filters.
