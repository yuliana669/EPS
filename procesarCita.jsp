<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.sql.*" %>
<%@ include file="conexion.jsp" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Procesar Cita</title>
</head>
<body>
    <h1>Confirmación de Cita</h1>
    <%
        Connection conn = (Connection) application.getAttribute("conexion");
        PreparedStatement stmt = null;

        if (conn != null) {
            try {
                // Obtener datos del formulario
                int clienteId = Integer.parseInt(request.getParameter("cliente_id"));
                int medicoId = Integer.parseInt(request.getParameter("medico_id"));
                String fecha = request.getParameter("fecha");
                String estado = request.getParameter("estado");

                // Convertir la fecha al formato correcto
                String formattedFecha = fecha.replace("T", " ") + ":00"; // Convertir 'yyyy-MM-ddTHH:mm' a 'yyyy-MM-dd HH:mm:ss'

                // Crear la consulta SQL con conversión de fecha
                String sql = "INSERT INTO citas (cliente_id, medico_id, fecha, estado) VALUES (?, ?, ?, ?)";
                stmt = conn.prepareStatement(sql);
                stmt.setInt(1, clienteId);
                stmt.setInt(2, medicoId);
                stmt.setTimestamp(3, Timestamp.valueOf(formattedFecha));
                stmt.setString(4, estado);

                // Ejecutar la consulta
                int rowsInserted = stmt.executeUpdate();

                if (rowsInserted > 0) {
                    out.println("<p>Cita solicitada exitosamente.</p>");
                } else {
                    out.println("<p>No se pudo solicitar la cita.</p>");
                }

            } catch (SQLException e) {
                e.printStackTrace();
                out.println("<p>Se produjo un error: " + e.getMessage() + "</p>");
            } catch (IllegalArgumentException e) {
                e.printStackTrace();
                out.println("<p>Formato de fecha incorrecto: " + e.getMessage() + "</p>");
            } finally {
                // Cerrar recursos
                try {
                    if (stmt != null) stmt.close();
                    // Nota: No cerramos la conexión aquí ya que está gestionada en conexion.jsp
                } catch (SQLException e) {
                    e.printStackTrace();
                }
            }
        } else {
            out.println("<p>No se pudo establecer conexión con la base de datos.</p>");
        }
    %>
    <a href="solicitudCita.jsp">Volver a solicitar otra cita</a>
</body>
</html>
