<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.DriverManager" %>
<%@ page import="java.sql.SQLException" %>

<%
String nombre = request.getParameter("nombre");
String email = request.getParameter("email");
String password = request.getParameter("password");
String rol = request.getParameter("rol"); // 'admin' o 'cliente'

Connection conexion = null;
Statement sentencia = null;

int filas = 0;

try {
    Class.forName("org.postgresql.Driver");

    conexion = DriverManager.getConnection(
        "jdbc:postgresql://dpg-crh1lpaj1k6c73dqit3g-a.oregon-postgres.render.com:5432/eps", 
        "yuli", 
        "qjjU935SUx35JXFRhTBhidGS2Qx943x9"
    );

    sentencia = conexion.createStatement();

    String consultaSQL = "INSERT INTO usuarios (nombre, email, password, rol) VALUES ";
    consultaSQL += "('" + nombre + "', '" + email + "', '" + password + "', '" + rol + "')";

    filas = sentencia.executeUpdate(consultaSQL);

    if (filas > 0) {
        out.println("Registro exitoso. <a href='login.html'>Volver al inicio de sesión</a>");
    } else {
        out.println("Error al registrar. <a href='register.html'>Intentar de nuevo</a>");
    }
}
catch (ClassNotFoundException e) {
    out.println("Error accediendo a la Base de Datos: " + e.getMessage());
}
catch (SQLException e) {
    out.println("Error en la Base de Datos: " + e.getMessage());
}
finally {
    if (sentencia != null) {
        try {
            sentencia.close();
        }
        catch (SQLException e) {
            out.println("Error cerrando la sentencia: " + e.getMessage());
        }
    }

    if (conexion != null) {
        try {
            conexion.close();
        }
        catch (SQLException e) {
            out.println("Error cerrando la conexión: " + e.getMessage());
        }
    }
}
%>
