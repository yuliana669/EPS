<%@ page import="java.sql.Connection, java.sql.DriverManager, java.sql.SQLException" %>
<%
    String url = "jdbc:postgresql://dpg-crh1lpaj1k6c73dqit3g-a.oregon-postgres.render.com:5432/eps";
    String usuario = "yuli";
    String contrasena = "qjjU935SUx35JXFRhTBhidGS2Qx943x9";
    Connection conexion = null;

    try {
        // Cargar el controlador JDBC
        Class.forName("org.postgresql.Driver");

        // Establecer la conexión
        conexion = DriverManager.getConnection(url, usuario, contrasena);

        // Guardar la conexión en el contexto de la aplicación
        application.setAttribute("conexion", conexion);

    } catch (ClassNotFoundException e) {
        out.println("Error al cargar el controlador JDBC: " + e.getMessage());
    } catch (SQLException e) {
        out.println("Error en la conexión a la base de datos: " + e.getMessage());
    }
%>

