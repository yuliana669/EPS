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
        Médico: <select name="medico_id" required>
            <!-- Aquí deberías cargar dinámicamente los médicos disponibles -->
            <%
                try {
                    Class.forName("org.postgresql.Driver
