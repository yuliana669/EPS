<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Registro de Médico</title>
</head>
<body>
    <h2>Registrar Médico</h2>
    <form action="registroMedico.jsp" method="post">
        Nombre: <input type="text" name="nombre" required><br>
        Especialidad: <input type="text" name="especialidad" required><br>
        Teléfono: <input type="text" name="telefono" required><br>
        <input type="submit" value="Registrar Médico">
    </form>
    <%
        String nombre = request.getParameter("nombre");
        String especialidad = request.getParameter("especialidad");
        String telefono = request.getParameter("telefono");

        if (nombre != null && especialidad != null && telefono != null) {
            try {
                Class.forName("org.postgresql.Driver");
                Connection conn = DriverManager.getConnection("jdbc:postgresql://localhost:5432/agenda", "yuyis", "43870841");

                String sql = "INSERT INTO medicos (nombre, especialidad, telefono) VALUES (?, ?, ?)";
                PreparedStatement pstmt = conn.prepareStatement(sql);
                pstmt.setString(1, nombre);
                pstmt.setString(2, especialidad);
                pstmt.setString(3, telefono);
                int resultado = pstmt.executeUpdate();

                if (resultado > 0) {
                    out.println("<p>Médico registrado exitosamente.</p>");
                } else {
                    out.println("<p>Error al registrar médico.</p>");
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
