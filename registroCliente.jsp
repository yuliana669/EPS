<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.SQLException" %>
<%@ include file="conexion.jsp" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registrar Cliente</title>
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
            max-width: 500px;
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
        <h2>Registrar Cliente</h2>
        <form action="registrarcliente.jsp" method="post" class="shadow p-4 rounded">
            <div class="mb-3">
                <label for="usuario_id" class="form-label">ID de Usuario:</label>
                <input type="number" id="usuario_id" name="usuario_id" class="form-control" required>
            </div>
            <div class="mb-3">
                <label for="direccion" class="form-label">Dirección:</label>
                <input type="text" id="direccion" name="direccion" class="form-control" required>
            </div>
            <div class="mb-3">
                <label for="telefono" class="form-label">Teléfono:</label>
                <input type="text" id="telefono" name="telefono" class="form-control" required>
            </div>
            <div class="mb-3">
                <label for="estado_civil" class="form-label">Estado Civil:</label>
                <input type="text" id="estado_civil" name="estado_civil" class="form-control" required>
            </div>
            <div class="mb-3">
                <label for="fecha_nacimiento" class="form-label">Fecha de Nacimiento:</label>
                <input type="date" id="fecha_nacimiento" name="fecha_nacimiento" class="form-control" required>
            </div>
            <button type="submit" class="btn btn-primary">Registrar Cliente</button>
        </form>
        <div class="text-center mt-3">
            <a href="adminDashboard.jsp" class="btn btn-link">Volver al Dashboard</a>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>

<%
    if ("POST".equalsIgnoreCase(request.getMethod())) {
        int usuarioId = Integer.parseInt(request.getParameter("usuario_id"));
        String direccion = request.getParameter("direccion");
        String telefono = request.getParameter("telefono");
        String estadoCivil = request.getParameter("estado_civil");
        java.sql.Date fechaNacimiento = java.sql.Date.valueOf(request.getParameter("fecha_nacimiento"));

        PreparedStatement pstmt = null;

        try {
            // Insertar el nuevo cliente en la tabla clientes
            String sql = "INSERT INTO clientes (usuario_id, direccion, telefono, estado_civil, fecha_nacimiento) VALUES (?, ?, ?, ?, ?)";
            pstmt = conexion.prepareStatement(sql);
            pstmt.setInt(1, usuarioId);
            pstmt.setString(2, direccion);
            pstmt.setString(3, telefono);
            pstmt.setString(4, estadoCivil);
            pstmt.setDate(5, fechaNacimiento);

            int filasAfectadas = pstmt.executeUpdate();
            if (filasAfectadas > 0) {
                out.println("<div class='alert alert-success text-center'>Cliente registrado con éxito.</div>");
            } else {
                out.println("<div class='alert alert-danger text-center'>Error al registrar el cliente.</div>");
            }
        } catch (SQLException e) {
            out.println("<div class='alert alert-danger text-center'>Error en la base de datos: " + e.getMessage() + "</div>");
        } finally {
            if (pstmt != null) {
                try { pstmt.close(); } catch (SQLException e) { out.println("<div class='alert alert-danger text-center'>Error cerrando PreparedStatement: " + e.getMessage() + "</div>"); }
            }
            if (conexion != null) {
                try { conexion.close(); } catch (SQLException e) { out.println("<div class='alert alert-danger text-center'>Error cerrando conexión: " + e.getMessage() + "</div>"); }
            }
        }
    }
%>
