<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Solicitar Cita</title>
</head>
<body>
    <h2>Solicitar Cita</h2>
    <form action="solicitudCita.jsp" method="post">
        <label for="medico_id">Médico:</label>
        <select name="medico_id" required>
            <option value="">Seleccione un médico</option>
            <%
                try {
                    Class.forName("org.postgresql.Driver");
                    Connection conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/agenda", "yuyis", "43870841");

                    String sql = "SELECT id, nombre FROM medicos";
                    PreparedStatement pstmt = conn.prepareStatement(sql);
                    ResultSet rs = pstmt.executeQuery();

                    while (rs.next()) {
                        int medicoId = rs.getInt("id");
                        String medicoNombre = rs.getString("nombre");
                        out.println("<option value=\"" + medicoId + "\">" + medicoNombre + "</option>");
                    }

                    rs.close();
                    pstmt.close();
                    conn.close();
                } catch (Exception e) {
                    e.printStackTrace();
                    out.println("<option value=\"\">Error al cargar médicos</option>");
                }
            %>
        </select><br>
        <label for="fecha">Fecha:</label>
        <input type="date" name="fecha" required><br>
        <label for="hora">Hora:</label>
        <input type="time" name="hora" required><br>
        <input type="submit" value="Solicitar Cita">
    </form>
    <%
        String medicoId = request.getParameter("medico_id");
        String fecha = request.getParameter("fecha");
        String hora = request.getParameter("hora");

        if (medicoId != null && fecha != null && hora != null) {
            try {
                Class.forName("org.postgresql.Driver");
                Connection conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/agenda", "yuyis", "43870841");

                // Asumiendo que la tabla citas tiene campos: id, cliente_id, medico_id, fecha, hora, estado
                String sql = "INSERT INTO citas (cliente_id, medico_id, fecha, hora, estado) VALUES (?, ?, ?, ?, 'pendiente')";
                PreparedStatement pstmt = conn.prepareStatement(sql);
                pstmt.setInt(1, (Integer) session.getAttribute("cliente_id")); // Suponiendo que el ID del cliente está en la sesión
                pstmt.setInt(2, Integer.parseInt(medicoId));
                pstmt.setDate(3, java.sql.Date.valueOf(fecha));
                pstmt.setTime(4, java.sql.Time.valueOf(hora));
                int resultado = pstmt.executeUpdate();

                if (resultado > 0) {
                    out.println("<p>Cita solicitada exitosamente.</p>");
                } else {
                    out.println("<p>Error al solicitar la cita.</p>");
                }

                pstmt.close();
                conn.close();
            } catch (Exception e) {
                e.printStackTrace();
                out.println("<p>Error en la conexión a la base de datos.</p>");
            }
        }
    %>
</body>
</html>
