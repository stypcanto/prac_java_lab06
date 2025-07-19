<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!-- Esta directiva JSP define el tipo de contenido que se enviará al navegador y la codificación usada para la página -->

<!DOCTYPE html>
<html lang="es">
<head>
    <meta charset="UTF-8">
    <!-- Define la codificación de caracteres para el navegador (UTF-8) -->

    <title>Consulta Departamentos del Perú</title>
    <!-- Título que aparecerá en la pestaña del navegador -->

    <script src="jq/jquery-3.3.1.min.js"></script>
    <!-- Se carga la biblioteca jQuery desde una carpeta local (asegúrate que jq/jquery-3.3.1.min.js exista) -->

    <style>
        /* Estilos CSS internos para dar diseño moderno a la página */

        body {
            font-family: 'Segoe UI', sans-serif; /* Fuente moderna */
            background: #9ab7f3;                  /* Color de fondo suave */
            margin: 0;
            padding: 2rem;
            display: flex;                        /* Flexbox para centrar */
            justify-content: center;
            align-items: center;
            min-height: 100vh;                    /* Alto mínimo igual al viewport */
        }

        .container {
            background: #ffffff;                  /* Fondo blanco */
            padding: 2rem 3rem;                   /* Espaciado interno */
            border-radius: 16px;                  /* Bordes redondeados */
            box-shadow: 0 8px 20px rgba(0, 0, 0, 0.1); /* Sombra elegante */
            width: 100%;
            max-width: 600px;                     /* Ancho máximo del contenedor */
        }

        h1 {
            text-align: center;
            color: #333;
            margin-bottom: 2rem;
        }

        .card {
            background-color: #fafafa;            /* Fondo claro */
            border: 1px solid #ddd;               /* Borde gris claro */
            border-left: 5px solid #007bff;       /* Línea azul en el lado izquierdo */
            border-radius: 12px;
            padding: 1rem 1.5rem;
            margin-bottom: 1.5rem;
            transition: all 0.3s ease;
        }

        .card.json {
            border-left-color: #28a745;           /* Cambia a verde si es tipo JSON */
        }

        .card:hover {
            background-color: #f5faff;            /* Fondo cambia al pasar el mouse */
            box-shadow: 0 4px 12px rgba(0, 0, 0, 0.08); /* Sombra más fuerte */
        }

        label {
            font-weight: bold;
            display: block;
            margin-bottom: 0.5rem;
            color: #555;
        }

        select {
            width: 100%;
            padding: 0.6rem;
            font-size: 1rem;
            border: 1px solid #ccc;
            border-radius: 8px;
        }
    </style>

    <script>
        // Ejecuta esta función cuando el documento esté completamente cargado
        $(function() {
            // Primera llamada AJAX: obtiene datos en formato XML
            $.ajax({
                url: "datosPeru?ext=xml", // Solicita al servlet datos con extensión xml
                success: function(data) {
                    // Se construye el HTML de las opciones del combo box
                    let options = "<option disabled selected>Seleccione un departamento (XML)</option>";
                    $(data).find('nodo').each(function() {
                        // Agrega cada nodo XML como una opción del select
                        options += "<option value='" + $(this).attr('id') + "'>" + $(this).text() + "</option>";
                    });
                    $("#departamentoXML").html(options); // Se actualiza el combo con las opciones
                },
                error: function() {
                    // Si hay error, se muestra mensaje de error en el combo box
                    $("#departamentoXML").html("<option>Error al cargar XML</option>");
                }
            });

            // Segunda llamada AJAX: obtiene datos en formato JSON
            $.ajax({
                url: "datosPeru?ext=json", // Solicita al servlet datos con extensión json
                dataType: "json",          // Le indicamos que esperamos una respuesta JSON
                success: function(data) {
                    // Construimos las opciones del combo
                    let options = "<option disabled selected>Seleccione un departamento (JSON)</option>";
                    data.forEach(function(obj) {
                        // Agrega cada objeto JSON como opción
                        options += "<option value='" + obj.id + "'>" + obj.texto + "</option>";
                    });
                    $("#departamentoJSON").html(options); // Actualiza el combo
                },
                error: function() {
                    // Muestra mensaje si hubo error
                    $("#departamentoJSON").html("<option>Error al cargar JSON</option>");
                }
            });
        });
    </script>
</head>
<body>

<!-- Contenedor principal de la interfaz -->
<div class="container">
    <h1>Departamentos del Perú</h1>

    <!-- Primera tarjeta: datos desde archivo XML -->
    <div class="card xml">
        <label for="departamentoXML">Cargado desde XML</label>
        <select id="departamentoXML">
            <option>Cargando XML...</option> <!-- Mensaje temporal mientras carga -->
        </select>
    </div>

    <!-- Segunda tarjeta: datos desde archivo JSON -->
    <div class="card json">
        <label for="departamentoJSON">Cargado desde JSON</label>
        <select id="departamentoJSON">
            <option>Cargando JSON...</option> <!-- Mensaje temporal mientras carga -->
        </select>
    </div>
</div>

</body>
</html>
