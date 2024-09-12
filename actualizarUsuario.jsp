<%@ page import="java.sql.Connection, java.sql.PreparedStatement, java.sql.SQLException" %>
<%@ include file="conexion.jsp" %>
<%
    int id = Integer.parseInt(request.getParameter("id"));
    String nombre = request.getParameter("nombre");
    String email = request.getParameter("email");
    String rol = request.getParameter("rol");
    
    Connection conn = null;
    PreparedStatement stmt = null;
    
    try {
        conn = (Connection) application.getAttribute("conexion");
        String sql = "UPDATE usuarios SET nombre = ?, email = ?, rol = ? WHERE id = ?";
        stmt = conn.prepareStatement(sql);
        stmt.setString(1, nombre);
        stmt.setString(2, email);
        stmt.setString(3, rol);
        stmt.setInt(4, id);
        stmt.executeUpdate();
        response.sendRedirect("adminDashboard.jsp");
    } catch (SQLException e) {
        e.printStackTrace();
    } finally {
        if (stmt != null) try { stmt.close(); } catch (SQLException e) { e.printStackTrace(); }
        if (conn != null) try { conn.close(); } catch (SQLException e) { e.printStackTrace(); }
    }
%>
