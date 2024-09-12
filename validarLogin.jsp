<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.ResultSet, java.sql.SQLException" %>
<%@ include file="conexion.jsp" %>

<%
    String email = request.getParameter("email");
    String password = request.getParameter("password");

    PreparedStatement pstmt = null;
    ResultSet rs = null;
    
    try {
        // Consulta para verificar el correo y contraseña
        String sql = "SELECT * FROM usuarios WHERE email = ? AND password = ?";
        pstmt = conexion.prepareStatement(sql);
        pstmt.setString(1, email);
        pstmt.setString(2, password);
        rs = pstmt.executeQuery();

        if (rs.next()) {
            // Si las credenciales son válidas, identificar el rol del usuario
            String rol = rs.getString("rol");
            session.setAttribute("usuario", email); // Guardar el usuario en la sesión
            
            if ("admin".equals(rol)) {
                response.sendRedirect("admin.jsp"); // Redirigir a página de administrador
            } else if ("cliente".equals(rol)) {
                response.sendRedirect("cliente.jsp"); // Redirigir a página de cliente
            } else {
                out.println("<div class='alert alert-danger'>Rol no reconocido.</div>");
            }
        } else {
            out.println("<div class='alert alert-danger'>Correo o contraseña incorrectos.</div>");
        }
    } catch (SQLException e) {
        out.println("Error en la base de datos: " + e.getMessage());
    } finally {
        if (rs != null) {
            try { rs.close(); } catch (SQLException e) { out.println("Error cerrando ResultSet: " + e.getMessage()); }
        }
        if (pstmt != null) {
            try { pstmt.close(); } catch (SQLException e) { out.println("Error cerrando PreparedStatement: " + e.getMessage()); }
        }
        if (conexion != null) {
            try { conexion.close(); } catch (SQLException e) { out.println("Error cerrando conexión: " + e.getMessage()); }
        }
    }
%>
