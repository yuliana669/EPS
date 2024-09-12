<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.SQLException" %>
<%@ include file="conexion.jsp" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registro de Usuario</title>
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
        <h2>Registrar Usuario</h2>
        <form action="registrar.jsp" method="post" class="shadow p-4 rounded">
            <div class="mb-3">
                <label for="nombre" class="form-label">Nombre Completo:</label>
                <input type="text" id="nombre" name="nombre" class="form-control" required>
            </div>
            <div class="mb-3">
                <label for="email" class="form-label">Correo Electrónico:</label>
                <input type="email" id="email" name="email" class="form-control" required>
            </div>
            <div class="mb-3">
                <label for="password" class="form-label">Contraseña:</label>
                <input type="password" id="password" name="password" class="form-control" required>
            </div>
            <div class="mb-3">
                <label for="rol" class="form-label">Rol:</label>
                <select id="rol" name="rol" class="form-select" required>
                    <option value="cliente">Paciente</option>
                    <option value="admin">Admin</option>
                    <option value="medico">Médico</option>
                </select>
            </div>
            <button type="submit" class="btn btn-primary">Registrar</button>
        </form>

        <div class="text-center mt-3">
            <a href="login.jsp" class="btn btn-link">Ya tengo cuenta. Iniciar sesión</a>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

<%
    // Verificar si es una solicitud POST (registro de usuario)
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        String nombre = request.getParameter("nombre");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String rol = request.getParameter("rol");

        // Validación si el rol es 'admin', la contraseña debe ser '12345'
        if ("admin".equals(rol)) {
            if (!"12345".equals(password)) {
                out.println("<div class='alert alert-danger text-center'>Error: La contraseña para Administrador debe ser '12345'.</div>");
                return; // Detener el registro si la contraseña no es la correcta
            }
        }

        PreparedStatement pstmt = null;

        try {
            // Insertar el nuevo usuario en la tabla usuarios
            String sql = "INSERT INTO usuarios (nombre, email, password, rol) VALUES (?, ?, ?, ?)";
            pstmt = conexion.prepareStatement(sql);
            pstmt.setString(1, nombre);
            pstmt.setString(2, email);
            pstmt.setString(3, password);  // Usamos la contraseña que el usuario ingresó o '12345' si es admin
            pstmt.setString(4, rol);

            int filasAfectadas = pstmt.executeUpdate();
            if (filasAfectadas > 0) {
                out.println("<div class='alert alert-success text-center'>Usuario registrado con éxito. <a href='login.jsp'>Inicia sesión aquí</a></div>");
            } else {
                out.println("<div class='alert alert-danger text-center'>Error al registrar el usuario.</div>");
            }
        } catch (SQLException e) {
            if (e.getMessage().contains("duplicate key value violates unique constraint")) {
                out.println("<div class='alert alert-danger text-center'>El correo electrónico ya está registrado.</div>");
            } else {
                out.println("<div class='alert alert-danger text-center'>Error en la base de datos: " + e.getMessage() + "</div>");
            }
        } finally {
            if (pstmt != null) {
                try {
                    pstmt.close();
                } catch (SQLException e) {
                    out.println("Error cerrando PreparedStatement: " + e.getMessage());
                }
            }
            if (conexion != null) {
                try {
                    conexion.close();
                } catch (SQLException e) {
                    out.println("Error cerrando conexión: " + e.getMessage());
                }
            }
        }
    }
%>
