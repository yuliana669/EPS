<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException" %>
<%@ include file="conexion.jsp" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Dashboard del Admin</title>
    <!-- Agregar Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f0f8ff;
            font-family: Arial, sans-serif;
        }
        h1 {
            text-align: center;
            margin-top: 20px;
            color: #0056b3;
        }
        .btn-primary, .btn-danger, .btn-success {
            margin: 5px;
        }
        .btn-group {
            margin-bottom: 20px;
            display: flex;
            justify-content: center;
        }
    </style>
</head>
<body>
    <div class="container">
        <h1>Panel de Administración</h1>

        <!-- Botones para registrar clientes y médicos -->
        <div class="btn-group">
            <a href="registroCliente.jsp" class="btn btn-success">Registrar Cliente</a>
            <a href="registrarmedico.jsp" class="btn btn-primary">Registrar Médico</a>
        </div>

        <table class="table table-striped">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Nombre</th>
                    <th>Email</th>
                    <th>Rol</th>
                    <th>Acciones</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    Connection conn = null;
                    PreparedStatement stmt = null;
                    ResultSet rs = null;
                    try {
                        conn = (Connection) application.getAttribute("conexion");
                        String sql = "SELECT * FROM usuarios WHERE rol = 'cliente'"; // Filtrar por rol de cliente
                        stmt = conn.prepareStatement(sql);
                        rs = stmt.executeQuery();
                        while (rs.next()) {
                            int id = rs.getInt("id");
                            String nombre = rs.getString("nombre");
                            String email = rs.getString("email");
                            String rol = rs.getString("rol");
                %>
                <tr>
                    <td><%= id %></td>
                    <td><%= nombre %></td>
                    <td><%= email %></td>
                    <td><%= rol %></td>
                    <td>
                        <a href="editarUsuario.jsp?id=<%= id %>" class="btn btn-primary">Editar</a>
                        <a href="eliminarUsuario.jsp?id=<%= id %>" class="btn btn-danger" onclick="return confirm('¿Estás seguro de que deseas eliminar este usuario?');">Eliminar</a>
                    </td>
                </tr>
                <% 
                        }
                    } catch (SQLException e) {
                        e.printStackTrace();
                    } finally {
                        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                        if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                    }
                %>
            </tbody>
        </table>
        
        <!-- Botón para cerrar sesión -->
        <div class="text-center mt-3">
            <a href="logout.jsp" class="btn btn-danger">Cerrar sesión</a>
        </div>
    </div>
</body>
</html>
