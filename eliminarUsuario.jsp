<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.SQLException" %>
<%@ include file="conexion.jsp" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Eliminar Usuario</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">
</head>
<body>
    <div class="container mt-4">
        <h2>Eliminar Usuario</h2>
        <%
            String idParam = request.getParameter("id");
            if (idParam == null || idParam.isEmpty()) {
                out.println("<div class='alert alert-danger'>ID de usuario no proporcionado.</div>");
                return;
            }

            int userId;
            try {
                userId = Integer.parseInt(idParam);
            } catch (NumberFormatException e) {
                out.println("<div class='alert alert-danger'>ID de usuario inválido.</div>");
                return;
            }

            Connection conn = null;
            PreparedStatement stmt = null;

            try {
                conn = (Connection) application.getAttribute("conexion");
                if (conn == null) {
                    throw new SQLException("No se pudo establecer la conexión con la base de datos.");
                }

                String sql = "DELETE FROM usuarios WHERE id = ?";
                stmt = conn.prepareStatement(sql);
                stmt.setInt(1, userId);

                int rowsAffected = stmt.executeUpdate();
                if (rowsAffected > 0) {
                    out.println("<div class='alert alert-success'>Usuario eliminado exitosamente.</div>");
                } else {
                    out.println("<div class='alert alert-warning'>No se encontró el usuario con ID proporcionado.</div>");
                }
            } catch (SQLException e) {
                e.printStackTrace();
                out.println("<div class='alert alert-danger'>Error al eliminar el usuario: " + e.getMessage() + "</div>");
            } finally {
                if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
                // La conexión no se debe cerrar aquí ya que la conexión es compartida
            }
        %>
        <a href="adminDashboard.jsp" class="btn btn-primary">Volver al Panel de Administración</a>
    </div>
</body>
</html>

