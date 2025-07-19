// Declaramos el paquete donde se encuentra este servlet
package cibertec.edu.pe.lab06;

// Importamos las clases necesarias para el uso de Servlets en Jakarta EE
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.*; // Importamos clases de entrada/salida como InputStream y PrintWriter

// Registramos el servlet usando la anotación @WebServlet
// Este servlet responderá a las solicitudes dirigidas a la URL "/datosPeru"
// La anotación @WebServlet es una anotación de Jakarta EE (antes Java EE) que se utiliza para declarar y registrar un servlet sin necesidad de configurarlo manualmente en el archivo web.xml.

@WebServlet(name = "datosPeruServlet", value = "/datosPeru")
public class DatosPeruServlet extends HttpServlet
{
    // Método de inicialización (opcional). Se ejecuta una sola vez cuando se carga el servlet.
    public void init()
    {
    }

    // Método que procesa tanto peticiones GET como POST
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException
    {
        // Obtenemos el valor del parámetro 'ext' de la URL (por ejemplo: ?ext=json)
        String ext  = request.getParameter("ext");

        // Construimos el nombre del archivo con base en la extensión recibida
        // Por ejemplo: "departamento.json" o "departamento.xml"
        String name = "departamento." + ext;

        // Leemos el archivo desde el classpath usando un InputStream
        // El archivo debe estar ubicado en src/main/resources
        InputStream is = getClass().getClassLoader().getResourceAsStream(name);

        // Obtenemos el tamaño total del archivo
        int size = is.available();

        // Creamos un arreglo de bytes para almacenar el contenido del archivo
        byte[] buffer = new byte[size];

        // Leemos el contenido del archivo en el arreglo de bytes
        is.read(buffer);

        // Convertimos el contenido leído a una cadena de texto (UTF-8 por defecto del sistema)
        String content = new String(buffer);

        // Según el tipo de extensión, configuramos el tipo de contenido en la respuesta
        if (ext.equals("json"))
            response.setContentType("application/json;charset=UTF-8"); // Para JSON
        else
            response.setContentType("text/html;charset=UTF-8"); // Para XML o cualquier otro

        // Enviamos el contenido al navegador como respuesta
        try (PrintWriter out = response.getWriter())
        {
            out.println(content);
        }
    }

    // Método que maneja peticiones HTTP GET (por ejemplo, desde el navegador o AJAX)
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException
    {
        // Redirigimos la lógica al método común processRequest()
        processRequest(request, response);
    }

    // Método que maneja peticiones HTTP POST (por ejemplo, desde formularios)
    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException
    {
        // Redirigimos la lógica al método común processRequest()
        processRequest(request, response);
    }

    // Método de destrucción del servlet (opcional), se ejecuta cuando el servlet es eliminado del servidor
    public void destroy()
    {
    }
}
