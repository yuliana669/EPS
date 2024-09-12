<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.SQLException, java.sql.PreparedStatement, java.sql.ResultSet" %>
<%@ include file="conexion.jsp" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registro de Cliente</title>
    <!-- Agregar Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #e6f2ff; /* Color de fondo claro, adecuado para una EPS */
            font-family: Arial, sans-serif;
        }
        h2 {
            text-align: center;
            margin-top: 20px;
            color: #0056b3; /* Color azul calmante */
        }
        form {
            margin: 20px auto;
            padding: 20px;
            border: 2px solid #0056b3; /* Bordes en color azul */
            border-radius: 10px;
            max-width: 600px;
            background-color: white;
        }
        label {
            margin-bottom: 5px;
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
    <form action="registroCliente.jsp" method="post" class="shadow p-4 rounded">
        <div class="mb-3">
            <label for="usuario_id" class="form-label">Usuario ID:</label>
            <input type="number" id="usuario_id" name="usuario_id" class="form-control" required>
        </div>
        <div class="mb-3">
            <label for="direccion" class="form-label">Direccion:</label>
            <input type="text" id="direccion" name="direccion" class="form-control" required>
        </div>
        <div class="mb-3">
            <label for="telefono" class="form-label">Telefono:</label>
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
        <div class="d-flex justify-content-between">
            <button type="submit" class="btn btn-primary">Registrar</button>
            <!-- Botón para volver a la página de inicio -->
            <a href="index.jsp" class="btn btn-secondary">Volver a Inicio</a>
        </div>
    </form>
    
    <%
        if ("POST".equalsIgnoreCase(request.getMethod())) {
            int usuarioId = Integer.parseInt(request.getParameter("usuario_id"));
            String direccion = request.getParameter("direccion");
            String telefono = request.getParameter("telefono");
            String estadoCivil = request.getParameter("estado_civil");
            String fechaNacimiento = request.getParameter("fecha_nacimiento");

            PreparedStatement pstmt = null;
            ResultSet rs = null;
            try {
                // Verificar si el usuario_id existe en la tabla usuarios
                String checkUserSql = "SELECT id FROM usuarios WHERE id = ?";
                pstmt = conexion.prepareStatement(checkUserSql);
                pstmt.setInt(1, usuarioId);
                rs = pstmt.executeQuery();

                if (rs.next()) {
                    // El usuario_id existe, proceder con la inserción
                    String sql = "INSERT INTO clientes (usuario_id, direccion, telefono, estado_civil, fecha_nacimiento) VALUES (?, ?, ?, ?, ?)";
                    pstmt = conexion.prepareStatement(sql);
                    pstmt.setInt(1, usuarioId);
                    pstmt.setString(2, direccion);
                    pstmt.setString(3, telefono);
                    pstmt.setString(4, estadoCivil);
                    pstmt.setDate(5, java.sql.Date.valueOf(fechaNacimiento));

                    int filasAfectadas = pstmt.executeUpdate();
                    if (filasAfectadas > 0) {
                        out.println("<div class='alert alert-success'>Cliente registrado con éxito.</div>");
                    } else {
                        out.println("<div class='alert alert-danger'>Error al registrar el cliente.</div>");
                    }
                } else {
                    out.println("<div class='alert alert-danger'>Error: El usuario_id proporcionado no existe.</div>");
                }
            } catch (SQLException e) {
                out.println("<div class='alert alert-danger'>Error en la base de datos: " + e.getMessage() + "</div>");
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
</div>

<!-- Bootstrap JS -->
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
