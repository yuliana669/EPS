<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException" %>
<%@ include file="conexion.jsp" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Iniciar Sesión</title>
    <!-- Agregar Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #e6f2ff;
            font-family: Arial, sans-serif;
        }
        h2 {
            text-align: center;
            margin-top: 20px;
            color: #0056b3;
        }
        form {
            margin: 20px auto;
            padding: 20px;
            border: 2px solid #0056b3;
            border-radius: 10px;
            max-width: 400px;
            background-color: white;
        }
        .btn-primary {
            background-color: #0056b3;
        }
        .btn-primary:hover {
            background-color: #004494;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Iniciar Sesión</h2>
        <form action="login.jsp" method="post" class="shadow p-4 rounded">
            <div class="mb-3">
                <label for="email" class="form-label">Correo Electrónico:</label>
                <input type="email" id="email" name="email" class="form-control" required>
            </div>
            <div class="mb-3">
                <label for="password" class="form-label">Contraseña:</label>
                <input type="password" id="password" name="password" class="form-control" required>
            </div>
            <button type="submit" class="btn btn-primary">Iniciar Sesión</button>
        </form>
        
        <div class="text-center mt-3">
            <a href="registrar.jsp" class="btn btn-link">No tengo cuenta. Registrarme</a>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

<%
    // Verificar si es una solicitud POST (inicio de sesión)
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        Connection conn = null;
        PreparedStatement pstmt = null;
        ResultSet rs = null;

        try {
            // Obtener conexión desde el archivo de conexión
            conn = (Connection) application.getAttribute("conexion");
            
            // Consulta para verificar el correo y contraseña
            String sql = "SELECT * FROM usuarios WHERE email = ? AND password = ?";
            pstmt = conn.prepareStatement(sql);
            pstmt.setString(1, email);
            pstmt.setString(2, password);
            rs = pstmt.executeQuery();
            
            if (rs.next()) {
                // Si las credenciales son válidas, identificar el rol del usuario
                String rol = rs.getString("rol");
                session.setAttribute("usuario", email); // Guardar el usuario en la sesión
                
                if ("admin".equals(rol)) {
                    response.sendRedirect("adminDashboard.jsp"); // Redirigir a página de administrador
                } else if ("cliente".equals(rol)) {
                    response.sendRedirect("medicoDashboard.jsp"); // Redirigir a página de cliente
                } else {
                    out.println("<div class='alert alert-danger text-center'>Rol no reconocido.</div>");
                }
            } else {
                out.println("<div class='alert alert-danger text-center'>Correo electrónico o contraseña incorrectos.</div>");
            }
        } catch (SQLException e) {
            out.println("<div class='alert alert-danger text-center'>Error en la base de datos: " + e.getMessage() + "</div>");
        } finally {
            if (rs != null) {
                try {
                    rs.close();
                } catch (SQLException e) {
                    out.println("Error cerrando ResultSet: " + e.getMessage());
                }
            }
            if (pstmt != null) {
                try {
                    pstmt.close();
                } catch (SQLException e) {
                    out.println("Error cerrando PreparedStatement: " + e.getMessage());
                }
            }
            if (conn != null) {
                try {
                    conn.close();
                } catch (SQLException e) {
                    out.println("Error cerrando conexión: " + e.getMessage());
                }
            }
        }
    }
%>
