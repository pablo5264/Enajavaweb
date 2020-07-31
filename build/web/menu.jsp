<%
    
    // Si intenta ingresar sin log
    if(request.getSession().getAttribute("web") == null)
    {
        response.sendRedirect("index.jsp");
    }
    else
    {
        // Si al haber entrado y estuvo exitoso pero cerro Sesión
        String s = (String)request.getSession().getAttribute("web");
        
        
        if(!s.equals("Ok"))
        {
            response.sendRedirect("index.jsp");
        }
    }
    
%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="Css/Style.css" rel="stylesheet" type="text/css"/>
        <link href="Css/bootstrap.css" rel="stylesheet" type="text/css"/>
         <script src="Js/icons.js" type="text/javascript"></script>
        <title>Men&uacute; Principal</title>
    </head>
    <style>
        body{
            background-color: #cccccc;
            border: 1px black solid;
            margin: auto;
        }
    </style>
    <body>
        <img scr="img\logo-aiep-footer" width="100px" height="100px"/>
        <div class="container">
            <div class="setion_log">
                <p>
                     Bienvenido <%=request.getSession().getAttribute("usuario") %> tipo <%=request.getSession().getAttribute("rol") %>
                </p>
                <a class="btn btn-dark" href="CerrarSesion.jsp"> Cerrar sesi&oacute;n</a>

            </div>
            <div class="card card-header" >
               <h1 class="titulo"><i class="fab fa-elementor"></i> Men&uacute; Principal</h1>
            </div>

            <div class="card card-header menu">

                    <a class="btn btn-primary" href="IngresarRequerimiento.jsp"> Ingresar Requerimiento</a>

                    <a class="btn btn-primary" href="ConsultarRequerimientos.jsp">Consultar Requerimientos</a>

                    <a class="btn btn-primary" href="CerrarRequerimientos.jsp">Cerrar Requerimiento</a>

            </div>
        </div>
    </body>
</html>
