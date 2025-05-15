import java.io.IOException;
import java.sql.*;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;

@WebServlet("/UserServlet")
public class UserServlet extends HttpServlet {
    private static final String URL = "jdbc:mysql://localhost:3306/testdb";
    private static final String USER = "root";
    private static final String PASS = "password"; // Change accordingly

    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String action = request.getParameter("action");
        if (action == null) action = "list";

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(URL, USER, PASS);

            if (action.equals("delete")) {
                int id = Integer.parseInt(request.getParameter("id"));
                PreparedStatement ps = conn.prepareStatement("DELETE FROM users WHERE id = ?");
                ps.setInt(1, id);
                ps.executeUpdate();
                ps.close();
                conn.close();
                response.sendRedirect("UserServlet");
                return;
            }

            if (action.equals("edit")) {
                int id = Integer.parseInt(request.getParameter("id"));
                PreparedStatement ps = conn.prepareStatement("SELECT * FROM users WHERE id = ?");
                ps.setInt(1, id);
                ResultSet rs = ps.executeQuery();
                if (rs.next()) {
                    request.setAttribute("userId", rs.getInt("id"));
                    request.setAttribute("userName", rs.getString("name"));
                    request.setAttribute("userEmail", rs.getString("email"));
                }
                rs.close();
                ps.close();
                conn.close();
                request.getRequestDispatcher("userform.jsp").forward(request, response);
                return;
            }

            // Default: list users
            Statement stmt = conn.createStatement();
            ResultSet rs = stmt.executeQuery("SELECT * FROM users");
            request.setAttribute("users", rs);
            request.getRequestDispatcher("userlist.jsp").forward(request, response);
            rs.close();
            stmt.close();
            conn.close();
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }

    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        String id = request.getParameter("id");
        String name = request.getParameter("name");
        String email = request.getParameter("email");

        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            Connection conn = DriverManager.getConnection(URL, USER, PASS);

            if (id == null || id.isEmpty()) {
                // Insert new user
                PreparedStatement ps = conn.prepareStatement("INSERT INTO users(name,email) VALUES(?,?)");
                ps.setString(1, name);
                ps.setString(2, email);
                ps.executeUpdate();
                ps.close();
            } else {
                // Update existing user
                PreparedStatement ps = conn.prepareStatement("UPDATE users SET name=?, email=? WHERE id=?");
                ps.setString(1, name);
                ps.setString(2, email);
                ps.setInt(3, Integer.parseInt(id));
                ps.executeUpdate();
                ps.close();
            }
            conn.close();
            response.sendRedirect("UserServlet");
        } catch (Exception e) {
            throw new ServletException(e);
        }
    }
}
