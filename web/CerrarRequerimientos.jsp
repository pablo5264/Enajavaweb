<%

    // Si intenta ingresar sin log
    if (request.getSession().getAttribute("web") == null) {
        response.sendRedirect("index.jsp");
    } else {
        // Si al haber entrado y estuvo exitoso pero cerro Sesión
        String s = (String) request.getSession().getAttribute("web");

        if (!s.equals("Ok")) {
            response.sendRedirect("index.jsp");
        }
    }

%>
<%@page import="modelos.vo.Area"%>
<%@page import="modelos.dao.AreaDao"%>
<%@page import="modelos.vo.Depto"%>
<%@page import="modelos.dao.DeptoDao"%>
<%@page import="modelos.vo.Gerencia"%>
<%@page import="modelos.dao.GerenciaDao"%>
<%@page import="modelos.vo.Requerimiento"%>
<%@page import="java.util.List"%>
<%@page import="modelos.dao.RequerimientoDao"%>
<%    int gerencia = 0;
    int dpto = 0;
    int asignar = 0;
    String Selec = "";
    String Buscar = "";

    if (request.getParameter("gerencia") != null) {
        gerencia = Integer.parseInt(request.getParameter("gerencia"));
    }

    if (request.getParameter("dpto") != null) {
        dpto = Integer.parseInt(request.getParameter("dpto"));
    }

    if (request.getParameter("asignar") != null) {
        asignar = Integer.parseInt(request.getParameter("asignar"));
    }
    if (request.getParameter("buscar") != null) {
        Buscar = request.getParameter("buscar");
    }

    RequerimientoDao dao = new RequerimientoDao();
    List<Requerimiento> listaRequerimientos = dao.Listar(gerencia, dpto, asignar, Buscar);

    GerenciaDao daoGerencias = new GerenciaDao();
    List<Gerencia> listagerencias = daoGerencias.Listar();

    DeptoDao daoDeptos = new DeptoDao();
    List<Depto> listadeptos = daoDeptos.Listar(gerencia);

    AreaDao daoAreas = new AreaDao();
    List<Area> listaAsignar = daoAreas.Listar();
%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link href="Css/Style.css" rel="stylesheet" type="text/css"/>
        <link href="Css/bootstrap.css" rel="stylesheet" type="text/css"/>
        <script src="Js/main.js" type="text/javascript"></script>
        <script src="Js/icons.js" type="text/javascript"></script>
        <title>Cerrar Requerimientos</title>
    </head>
    <style>
        body{
            background-color: #cccccc;
            border: 1px black solid;
        }
    </style>
    <body>
        <img scr="C:\Users\pablo\Desktop\ena\TPC302-3600-181652349-PABLO RAMIREZ\WebRequerimientov2.0\web\img" width="100px" height="100px"/>
        <div class="container">
            <div class="card card-header">
                <h1 class="titulo"><i class="fas fa-times-circle"></i> Cerrar Requerimientos</h1>
            </div>
            <form id="formCerar" action="CerrarRequerimientos.jsp" >

                <div class="fm_req">
                    <label>Gerencia:</label>  
                    <select name="gerencia" onchange="goCerrar()"> 
                        <option value="0">Todos</option>
                        <%
                            for (Gerencia item : listagerencias) {
                                if (gerencia == item.getId_gerencia()) {
                                    Selec = "selected";
                                } else {
                                    Selec = "";
                                }
                        %>
                        <option  <%= Selec%> value="<%= item.getId_gerencia()%>" > <%= item.getNombre()%> </option>
                        <%
                            }
                        %>     
                    </select>
                </div>
                <div class="fm_req">
                    <label>Depto.:</label> 
                    <select name="dpto" onchange="goCerrar()"> 
                        <option value="0">Todos</option>
                        <%
                            for (Depto item : listadeptos) {
                                if (dpto == item.getId_depto()) {
                                    Selec = "selected";
                                } else {
                                    Selec = "";
                                }
                        %>
                        <option <%= Selec%> value="<%= item.getId_depto()%>" > <%= item.getDepto()%> </option>
                        <%
                            }
                        %>     
                    </select> 
                </div>
                <div class="fm_req_busq">
                    <label>Asignar a:</label> 
                    <select name="asignar" onchange="goCerrar()"> 
                        <option value="0">Todos</option>
                        <%
                            for (Area item : listaAsignar) {
                                if (asignar == item.getId_area()) {
                                    Selec = "selected";
                                } else {
                                    Selec = "";
                                }
                        %>
                        <option <%= Selec%> value="<%= item.getId_area()%>" > <%= item.getArea()%> </option>
                        <%
                            }
                        %>     
                    </select> 

                    <input name="buscar" type="text" value="" placeholder="Buscar">
                </div>  
            </form>

            <div class="card">   
                <table class="table table-bordered table-striped">
                    <thead class="bg-primary text-white">
                        <tr>
                            <th>Gerencia</th> 
                            <th>Depto.</th> 
                            <th>Asignado a </th> 
                            <th>Requerimiento</th> 
                            <th>Cerrar</th> 
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            for (Requerimiento item : listaRequerimientos) {
                        %>
                        <tr>
                            <td><%= item.gerencia%></td>
                            <td><%= item.depto%></td>
                            <td><%= item.area%></td>
                            <td><%= item.requerimiento%></td>


                            <td><a class="btn btn-danger" href="Cierre.jsp?code=<%=item.id_requerimiento%>">Cerrar</a></td>
                        </tr>
                        <%
                            }
                        %>
                    </tbody>

                </table>
            </div>

            <div class="card card-header menu">

                <a class="btn btn-primary" href="menu.jsp">Volver a Men&uacute;</a>

            </div>
        </div>
    </body>
</html>
