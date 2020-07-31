<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="modelos.vo.Usuario"%>
<%@page import="modelos.dao.UsuarioDao"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="Css/Style.css" rel="stylesheet" type="text/css"/>
        <link href="Css/bootstrap.css" rel="stylesheet" type="text/css"/>
        <script src="Js/icons.js" type="text/javascript"></script>
        <title>Valida</title>
    </head>

    <style>
        body{
            background-color: #cccccc;
            border: 1px black solid;

        }
    </style>
    <style>
        caja{
            width: 300px;
            height: 300px;
            background-image: url(https://www.google.com/url?sa=i&url=https%3A%2F%2Fsistemab.org%2Faiep%2F&psig=AOvVaw3WCGhx3AS2atNIf31kh7aP&ust=1596255228194000&source=images&cd=vfe&ved=0CAIQjRxqFwoTCJjFvaLQ9uoCFQAAAAAdAAAAABAJ);
        }
    </style>
    <body>

        <img scr="C:\Users\pablo\Desktop\ena\TPC302-3600-181652349-PABLO RAMIREZ\WebRequerimientov2.0\web\img" width="100px" height="100px"/>
        <div class="container">
            <%

                String User = request.getParameter("usuario");
                String Pass = request.getParameter("clave");
                String recordar = request.getParameter("recordar");
                String Rol = "";

                UsuarioDao dao = new UsuarioDao();
                List<Usuario> lista = dao.valida(new Usuario(1, User, Pass, 0, "", 0));
                if (lista.size() > 0) {
                    for (Usuario item : lista) {
                        Rol = item.getRol();
                    }

                    request.getSession().setAttribute("web", "Ok");
                    request.getSession().setAttribute("usuario", User);
                    request.getSession().setAttribute("rol", Rol);
                    if (recordar != null) {
                        Cookie cookie_user = new Cookie("log.c_user", User);
                        Cookie cookie_pass = new Cookie("log.pass", Pass);
                        cookie_user.setMaxAge(2 * 24 * 60 * 60); // duracion de la cokie 2 semanas 
                        cookie_pass.setMaxAge(2 * 24 * 60 * 60);
                        response.addCookie(cookie_user);
                        response.addCookie(cookie_pass);
                    } else {
                        Cookie cookie_user = new Cookie("log.c_user", User);
                        Cookie cookie_pass = new Cookie("log.pass", Pass);
                        cookie_user.setMaxAge(0); // duracion de la cokie 2 semanas 
                        cookie_pass.setMaxAge(0);
                        response.addCookie(cookie_user);
                        response.addCookie(cookie_pass);
                    }

                    response.sendRedirect("menu.jsp");

            %>   


            <h1 class="titulo"> Puede Ingresar </h1>

            <%        } else {
                request.getSession().setAttribute("web", "Error");

            %>
            <div class="card card-header">
                <h1 class="titulo"><i class="fas fa-exclamation-triangle"></i> Error de Acceso </h1>
            </div>

            <p class="titulo">Usuario y/o clave incorrectos</p>
            <%            }

            %>


            <div class="card card-header menu">
                <a class="btn btn-primary" href="index.jsp">Volver a iniciar</a>
            </div>
        </div>
    </body>
</html>
