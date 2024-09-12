<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException" %>
<%@ include file="conexion.jsp" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Ver Citas</title>
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
    </style>
</head>
<body>
    <div class="container">
        <h2>Citas Programadas</h2>
        <table class="table table-striped">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Cliente</th>
                    <th>Fecha</th>
                    <th>Estado</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    Connection conn = null;
                    PreparedStatement stmt = null;
                    ResultSet rs = null;
                    try {
                        conn = (Connection) application.getAttribute("conexion");
                        
                        // Obtener el ID del médico logueado (supongamos que está en la sesión)
                        Integer medicoId = (Integer) session.getAttribute("medico_id");
                        
                        // Consulta para obtener citas del médico logueado
                        String sql = "SELECT c.id, cl.nombre, c.fecha, c.estado FROM citas c "
                                   + "JOIN clientes cl ON c.cliente_id = cl.id "
                                   + "WHERE c.medico_id = ?";
                        stmt = conn.prepareStatement(sql);
                        stmt.setInt(1, medicoId);
                        rs = stmt.executeQuery();
                        
                        while (rs.next()) {
                            int id = rs.getInt("id");
                            String clienteNombre = rs.getString("nombre");
                            java.sql.Timestamp fecha = rs.getTimestamp("fecha");
                            String estado = rs.getString("estado");
                %>
                <tr>
                    <td><%= id %></td>
                    <td><%= clienteNombre %></td>
                    <td><%= fecha %></td>
                    <td><%= estado %></td>
                </tr>
                <% 
                        }
                    } catch (SQLException e) {
                        e.printStackTrace();
                        out.println("<div class='alert alert-danger'>Error al cargar las citas: " + e.getMessage() + "</div>");
                    } finally {
                        if (rs != null) try { rs.close(); } catch (SQLException e) { e.printStackTrace(); }
                        if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
                    }
                %>
            </tbody>
        </table>
        <div class="text-center mt-3">
            <a href="medicoDashboard.jsp" class="btn btn-link">Volver al Panel del Médico</a>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
