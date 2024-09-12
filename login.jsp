<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException" %>
<%@ include file="conexion.jsp" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Inicio de Sesión</title>
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
        .btn-secondary {
            background-color: #6c757d;
        }
        .btn-secondary:hover {
            background-color: #5a6268;
        }
        .btn-group {
            display: flex;
            justify-content: space-between;
        }
        .alert {
            margin-bottom: 15px;
        }
    </style>
</head>
<body>
    <div class="container">
        <h2>Inicio de Sesión</h2>

        <!-- Mostrar mensajes de error si existen -->
        <div class="text-center">
            <% 
                if ("POST".equalsIgnoreCase(request.getMethod())) {
                    String email = request.getParameter("email");
                    String password = request.getParameter("password");

                    PreparedStatement pstmt = null;
                    ResultSet rs = null;

                    try {
                        // Consulta para verificar el correo y contraseña
                        String sql = "SELECT id, rol FROM usuarios WHERE email = ? AND password = ?";
                        pstmt = conexion.prepareStatement(sql);
                        pstmt.setString(1, email);
                        pstmt.setString(2, password);
                        rs = pstmt.executeQuery();

                        if (rs.next()) {
                            // Recuperar el ID y el rol
                            int userId = rs.getInt("id");
                            String rol = rs.getString("rol");
                            session.setAttribute("usuario_id", userId); // Guardar el ID del usuario en la sesión

                            if ("admin".equals(rol)) {
                                response.sendRedirect("adminDashboard.jsp"); // Redirigir a página de administrador
                            } else if ("cliente".equals(rol)) {
                                response.sendRedirect("clienteDashboard.jsp"); // Redirigir a página de cliente
                            } else if ("medico".equals(rol)) {
                                // Guardar el ID del médico en la sesión
                                session.setAttribute("medico_id", userId);
                                response.sendRedirect("medicoDashboard.jsp"); // Redirigir a página de médico
                            } else {
                                out.println("<div class='alert alert-danger'>Rol no reconocido.</div>");
                            }
                        } else {
                            out.println("<div class='alert alert-danger'>Correo o contraseña incorrectos.</div>");
                        }
                    } catch (SQLException e) {
                        out.println("<div class='alert alert-danger'>Error en la base de datos: " + e.getMessage() + "</div>");
                    } finally {
                        if (rs != null) {
                            try { rs.close(); } catch (SQLException e) { out.println("<div class='alert alert-danger'>Error cerrando ResultSet: " + e.getMessage() + "</div>"); }
                        }
                        if (pstmt != null) {
                            try { pstmt.close(); } catch (SQLException e) { out.println("<div class='alert alert-danger'>Error cerrando PreparedStatement: " + e.getMessage() + "</div>"); }
                        }
                        if (conexion != null) {
                            try { conexion.close(); } catch (SQLException e) { out.println("<div class='alert alert-danger'>Error cerrando conexión: " + e.getMessage() + "</div>"); }
                        }
                    }
                }
            %>
        </div>

        <form action="login.jsp" method="post" class="shadow p-4 rounded">
            <div class="mb-3">
                <label for="email" class="form-label">Correo Electrónico:</label>
                <input type="email" id="email" name="email" class="form-control" required>
            </div>
            <div class="mb-3">
                <label for="password" class="form-label">Contraseña:</label>
                <input type="password" id="password" name="password" class="form-control" required>
            </div>
            <div class="btn-group">
                <button type="submit" class="btn btn-primary">Iniciar Sesión</button>
                <a href="index.html" class="btn btn-secondary">Volver</a> <!-- Botón Volver -->
            </div>
        </form>

        <div class="text-center mt-3">
            <a href="registrar.jsp" class="btn btn-link">¿No tienes cuenta? Regístrate aquí</a>
        </div>
    </div>

    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
