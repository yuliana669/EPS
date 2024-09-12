<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Editar Datos</title>
</head>
<body>
<h2>Editar Datos de Usuario</h2>
<%
    String id = request.getParameter("id");
    Connection conexion = null;
    PreparedStatement pstmt = null;
    ResultSet rs = null;

    if (id != null) {
        try {
            // Cargar el controlador JDBC
            Class.forName("org.postgresql.Driver");

            // Conectar a la base de datos
            conexion = DriverManager.getConnection("jdbc:postgresql://localhost:5432/agenda", "yuyis", "43870841");

            // Obtener los datos actuales del usuario
            String sql = "SELECT nombre, telefono FROM usuarios WHERE id = ?";
            pstmt = conexion.prepareStatement(sql);
            pstmt.setInt(1, Integer.parseInt(id));
            rs = pstmt.executeQuery();

            if (rs.next()) {
                String nombre = rs.getString("nombre");
                String telefono = rs.getString("telefono");
        %>
        <form action="actualizar.jsp" method="post">
            <input type="hidden" name="id" value="<%= id %>">
            <label for="nombre">Nombre:</label>
            <input type="text" id="nombre" name="nombre" value="<%= nombre %>" required><br>
            <label for="telefono">Telefono:</label>
            <input type="text" id="telefono" name="telefono" value="<%= telefono %>" required><br>
            <input type="submit" value="Actualizar">
        </form>
        <%
            } else {
                out.println("No se encontró el registro con el ID proporcionado.");
            }
        } catch (ClassNotFoundException e) {
            out.println("Error accediendo al driver: " + e.getMessage());
        } catch (SQLException e) {
            out.println("Error en la base de datos: " + e.getMessage());
        } finally {
            // Cerrar los recursos
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
    } else {
        out.println("ID no proporcionado.");
    }
%>
<a href="mostrar.jsp">Regresar</a>
</body>
</html>
