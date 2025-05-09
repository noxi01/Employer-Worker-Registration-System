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

🧩 How to Use.

In your dashboard pages (e.g. employer_dashboard.jsp, worker_dashboard.jsp), include a logout link:

```ruby
<a href="../LogoutServlet">Logout</a>
```

🛡️ Optional: Session Check Snippet in JSP.

To protect pages from unauthorized access, add this at the top of protected JSPs:
```ruby
<%
  String user = (String) session.getAttribute("username");
  if (user == null) {
      response.sendRedirect("../login.jsp");
  }
%>
```
🧩 Let's implement the Job Posting feature for employers in your system.

This feature will include:

A JSP form `(post_job.jsp)` to enter job details

A Servlet `(PostJobServlet.java)` to handle form submission

A MySQL table to store job posts.

✅ 1. Create the jobs Table.

Make sure your database has this table:
```ruby
CREATE TABLE jobs (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(255) NOT NULL,
    description TEXT,
    employer_id INT NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (employer_id) REFERENCES users(id)
);
```
✅ 2. JSP Form:
✅ 3. Servlet:

🔧 IMPORTANT – Track userId on Login.
Update your LoginServlet to store the user's ID:
```ruby
int userId = rs.getInt("id");
session.setAttribute("userId", userId);
```

🧩 Overview,

This will include:

A job listing JSP for workers

A button/form to apply for a job

A new database table to store applications

An `ApplyJobServlet` to handle applications

✅ 1. Create job_applications Table.

In your MySQL database:
```ruby
CREATE TABLE job_applications (
    id INT AUTO_INCREMENT PRIMARY KEY,
    job_id INT NOT NULL,
    worker_id INT NOT NULL,
    applied_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (job_id) REFERENCES jobs(id),
    FOREIGN KEY (worker_id) REFERENCES users(id)
);
```
✅ 2. JSP Page: `job_list.jsp`.

This lists jobs and shows an “Apply” button for each job. Add a check so only workers can access it.

✅ 3. Servlet: `ApplyJobServlet.java`

✅ 4. Add Link to Job List (from dashboard).

On `worker_dashboard.jsp`, link to the job listing:
```ruby
<a href="job_list.jsp">Browse Jobs</a>
```
🧩 Feature Overview.

JSP page: `view_applicants.jsp`

Fetch applicants for jobs posted by the logged-in employer

Display job title and list of workers who applied

✅ 1. JSP Page.

