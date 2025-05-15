<%@ page import="java.sql.*" %>
<%
    ResultSet rs = (ResultSet) request.getAttribute("users");
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <title>User List</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.4.3/dist/css/bootstrap.min.css" rel="stylesheet" />
</head>
<body class="bg-light">
<div class="container mt-5">
    <h2 class="mb-4">User List</h2>
    <a href="userform.jsp" class="btn btn-primary mb-3">Add New User</a>
    <table class="table table-bordered table-hover bg-white">
        <thead class="table-dark">
            <tr>
                <th>ID</th><th>Name</th><th>Email</th><th style="width: 150px;">Actions</th>
            </tr>
        </thead>
        <tbody>
        <%
            while(rs.next()) {
        %>
            <tr>
                <td><%= rs.getInt("id") %></td>
                <td><%= rs.getString("name") %></td>
                <td><%= rs.getString("email") %></td>
                <td>
                    <a href="UserServlet?action=edit&id=<%= rs.getInt("id") %>" class="btn btn-sm btn-warning">Edit</a>
                    <a href="UserServlet?action=delete&id=<%= rs.getInt("id") %>" class="btn btn-sm btn-danger" onclick="return confirm('Are you sure?');">Delete</a>
                </td>
            </tr>
        <%
            }
            rs.close();
        %>
        </tbody>
    </table>
</div>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.4.3/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
