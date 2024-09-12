<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.SQLException" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Actualizar Datos</title>
</head>
<body>
<h2>Actualizar Datos</h2>
<%
    String id = request.getParameter("id");
    String nombre = request.getParameter("nombre");
    String telefono = request.getParameter("telefono");

    if (id != null && nombre != null && telefono != null) {
        Connection conexion = null;
        PreparedStatement pstmt = null;

        try {
            // Cargar el controlador JDBC
            Class.forName("org.postgresql.Driver");

            // Conectar a la base de datos
            conexion = DriverManager.getConnection("jdbc:postgresql://localhost:5432/agenda", "yuyis", "43870841");

            // Crear la consulta SQL para actualizar el registro
            String sql = "UPDATE usuarios SET nombre = ?, telefono = ? WHERE id = ?";
            pstmt = conexion.prepareStatement(sql);
            pstmt.setString(1, nombre);
            pstmt.setString(2, telefono);
            pstmt.setInt(3, Integer.parseInt(id));
            int rowsAffected = pstmt.executeUpdate();

            if (rowsAffected > 0) {
                out.println("Datos actualizados correctamente.");
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
        out.println("Datos no proporcionados.");
    }
%>
<a href="mostrar.jsp">Regresar</a>
</body>
</html>
