<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.ResultSet, java.sql.Statement, java.sql.SQLException" %>

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Mostrar Datos</title>
</head>
<body>
<h2>Datos de Usuarios</h2>
<table border="1">
    <thead>
        <tr>
            <th>Nombre</th>
            <th>Telefono</th>
            <th>Acciones</th>
        </tr>
    </thead>
    <tbody>
        <%
        Connection conexion = null;
        Statement sentencia = null;
        ResultSet rs = null;

        try {
            // Cargar el controlador JDBC
            Class.forName("org.postgresql.Driver");

            // Conectar a la base de datos
            conexion = DriverManager.getConnection("jdbc:postgresql://localhost:5432/agenda", "yuyis", "43870841");

            // Crear la consulta SQL
            sentencia = conexion.createStatement();
            String consultaSQL = "SELECT id, nombre, telefono FROM usuarios";
            rs = sentencia.executeQuery(consultaSQL);

            // Mostrar los resultados en la tabla HTML
            while (rs.next()) {
        %>
            <tr>
                <td><%= rs.getString("nombre") %></td>
                <td><%= rs.getString("telefono") %></td>
                <td>
                    <a href="editar.jsp?id=<%= rs.getInt("id") %>">Editar</a> |
                    <a href="eliminar.jsp?id=<%= rs.getInt("id") %>">Eliminar</a>
                </td>
            </tr>
        <%
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
            if (sentencia != null) {
                try {
                    sentencia.close();
                } catch (SQLException e) {
                    out.println("Error cerrando Statement: " + e.getMessage());
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
        %>
    </tbody>
</table>
<a href="index.jsp">Regresar</a>
</body>
</html>
