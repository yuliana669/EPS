<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Solicitar Cita</title>
    <link href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css" rel="stylesheet">
    <style>
        body {
            background-color: #f0f8ff; /* Color de fondo similar a EPS */
        }
        .container {
            background-color: #ffffff;
            border: 1px solid #dcdcdc;
            border-radius: 8px;
            padding: 20px;
            box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.1);
        }
        .form-label {
            font-weight: bold;
        }
        .img-container {
            text-align: center;
            margin-top: 20px;
        }
        .img-container img {
            max-width: 100%;
            height: auto;
            transition: transform 0.3s ease-in-out, box-shadow 0.3s ease-in-out;
        }
        .img-container img:hover {
            transform: scale(1.1);
            box-shadow: 0px 8px 16px rgba(0, 0, 0, 0.3);
        }
        .btn-back {
            display: block;
            margin-top: 20px;
            text-align: center;
        }
    </style>
</head>
<body>
    <div class="container mt-5">
        <h1 class="text-center mb-4">Solicitar Cita Médica</h1>
        <form action="procesarCita.jsp" method="post">
            <div class="form-group">
                <label for="cliente_id" class="form-label">ID del Cliente:</label>
                <input type="number" id="cliente_id" name="cliente_id" class="form-control" required>
            </div>
            <div class="form-group">
                <label for="medico_id" class="form-label">ID del Médico:</label>
                <input type="number" id="medico_id" name="medico_id" class="form-control" required>
            </div>
            <div class="form-group">
                <label for="fecha" class="form-label">Fecha:</label>
                <input type="datetime-local" id="fecha" name="fecha" class="form-control" required>
            </div>
            <div class="form-group">
                <label for="estado" class="form-label">Estado:</label>
                <input type="text" id="estado" name="estado" class="form-control" maxlength="20" required>
            </div>
            <button type="submit" class="btn btn-primary">Solicitar Cita</button>
        </form>
        <div class="img-container">
            <img src="https://www.topdoctors.es/files/Image/large/f570072560cbf0828355f8df1c7bff7d.jpg" alt="Imagen de Ejemplo" class="img-fluid">
        </div>
        <div class="btn-back">
            <a href="clienteDashboard.jsp" class="btn btn-secondary">Volver</a>
        </div>
    </div>
    <script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"></script>
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.9.3/dist/umd/popper.min.js"></script>
    <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"></script>
</body>
</html>
