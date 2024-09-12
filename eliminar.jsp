<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.SQLException" %>
<%
    String id = request.getParameter("id");

    if (id != null) {
        Connection conexion = null;
        PreparedStatement pstmt = null;

        try {
            // Cargar el controlador JDBC
            Class.forName("org.postgresql.Driver");

            // Conectar a la base de datos
            conexion = DriverManager.getConnection("jdbc:postgresql://localhost:5432/agenda", "yuyis", "43870841");

            // Crear la consulta SQL para eliminar el registro
            String sql = "DELETE FROM usuarios WHERE id = ?";
            pstmt = conexion.prepareStatement(sql);
            pstmt.setInt(1, Integer.parseInt(id));
            int rowsAffected = pstmt.executeUpdate();

            if (rowsAffected > 0) {
                out.println("Registro eliminado correctamente.");
            } else {
                out.println("No se encontró el registro con el ID proporcionado.");
            }
        } catch (ClassNotFoundException e) {
            out.println("Error accediendo al driver: " + e.getMessage());
        } catch (SQLException e) {
            out.println("Error en la base de datos: " + e.getMessage());
        } finally {
            // Cerrar los recursos
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
    } else {
        out.println("ID no proporcionado.");
    }
%>
<a href="mostrar.jsp">Regresar</a>
