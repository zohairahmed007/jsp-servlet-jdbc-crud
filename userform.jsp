<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>User Form</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.4.3/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body class="bg-light">
<div class="container mt-5">
    <h2 class="mb-4"><%= request.getAttribute("userId") == null ? "Add New User" : "Edit User" %></h2>
    <form action="UserServlet" method="post" class="bg-white p-4 rounded shadow-sm">
        <input type="hidden" name="id" value="<%= request.getAttribute("userId") != null ? request.getAttribute("userId") : "" %>" />
        <div class="mb-3">
            <label for="name" class="form-label">Name</label>
            <input id="name" name="name" type="text" class="form-control" required
                   value="<%= request.getAttribute("userName") != null ? request.getAttribute("userName") : "" %>" />
        </div>
        <div class="mb-3">
            <label for="email" class="form-label">Email</label>
            <input id="email" name="email" type="email" class="form-control" required
                   value="<%= request.getAttribute("userEmail") != null ? request.getAttribute("userEmail") : "" %>" />
        </div>
        <button type="submit" class="btn btn-success">Save</button>
        <a href="UserServlet" class="btn btn-secondary ms-2">Back to List</a>
    </form>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.4.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
