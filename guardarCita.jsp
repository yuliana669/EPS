<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.SQLException" %>
<%@ include file="conexion.jsp" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Guardar Cita</title>
    <!-- Agregar Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #e6f2ff;
            font-family: Arial, sans-serif;
        }
        .container {
            max-width: 600px;
            margin-top: 20px;
        }
    </style>
</head>
<body>
    <div class="container">
        <% 
            String medicoStr = request.getParameter("medico");
            String fechaStr = request.getParameter("fecha");
            Connection conn = null;
            PreparedStatement stmt = null;
            
            try {
                conn = (Connection) application.getAttribute("conexion");
                
                // Convertir el parámetro medico a Integer
                int medicoId = Integer.parseInt(medicoStr);

                // Convertir el parámetro fecha a un formato Timestamp
                java.sql.Timestamp fecha = java.sql.Timestamp.valueOf(fechaStr.replace("T", " ") + ":00");

                String sql = "INSERT INTO citas (medico_id, fecha) VALUES (?, ?)";
                stmt = conn.prepareStatement(sql);
                stmt.setInt(1, medicoId);  // Establecer el valor de medico_id como INTEGER
                stmt.setTimestamp(2, fecha);  // Establecer el valor de fecha como TIMESTAMP

                int rowsAffected = stmt.executeUpdate();
                
                if (rowsAffected > 0) {
                    out.println("<div class='alert alert-success'>Cita agendada exitosamente.</div>");
                } else {
                    out.println("<div class='alert alert-danger'>No se pudo agendar la cita. Inténtalo de nuevo.</div>");
                }
            } catch (NumberFormatException e) {
                out.println("<div class='alert alert-danger'>Error: El ID del médico no es un número válido.</div>");
            } catch (IllegalArgumentException e) {
                out.println("<div class='alert alert-danger'>Error: El formato de la fecha es incorrecto.</div>");
            } catch (SQLException e) {
                e.printStackTrace();
                out.println("<div class='alert alert-danger'>Error al guardar la cita: " + e.getMessage() + "</div>");
            } finally {
                if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
            }
        %>
        <div class="text-center mt-3">
            <a href="agendarCita.jsp" class="btn btn-link">Volver a Agendar Cita</a>
        </div>
    </div>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
