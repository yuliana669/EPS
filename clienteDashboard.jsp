<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page session="false" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <title>Panel de Cliente</title>
    <!-- Incluir Bootstrap CSS -->
    <link href="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f8f9fa; /* Color de fondo claro */
        }
        .container-custom {
            background-color: #ffffff; /* Fondo blanco para el contenido */
            border-radius: 8px; /* Bordes redondeados */
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); /* Sombra ligera */
            padding: 20px; /* Espaciado interno */
        }
        .btn-agendar {
            background-color: #007bff; /* Color del botón */
            color: white; /* Color del texto */
            border: none; /* Sin borde */
            border-radius: 5px; /* Bordes redondeados */
            font-weight: bold; /* Texto en negrita */
        }
        .btn-agendar:hover {
            background-color: #0056b3; /* Color al pasar el ratón */
        }
    </style>
</head>
<body>
    <div class="container mt-5">
        <div class="container-custom">
            <h1 class="text-center">Bienvenido, Cliente</h1>
            <p class="text-center">Opciones de cliente aquí.</p>
            <div class="text-center">
                <!-- Botón para agendar cita -->
                <a href="solicitudCita.jsp" class="btn btn-agendar">Agendar Cita</a>
                <br><br>
                <!-- Botón para cerrar sesión -->
                <a href="logout.jsp" class="btn btn-danger">Cerrar sesión</a>
            </div>
        </div>
    </div>
    <!-- Incluir Bootstrap JS y dependencias -->
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.5.3/dist/umd/popper.min.js"></script>
    <script src="https://maxcdn.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
