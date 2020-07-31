<%
    //Valor por defecto 
    
        String User = "";
        String Pass = "";
        Cookie[] logCookies = request.getCookies();
        
        if(logCookies!=null)
        {
            for(Cookie item_cookie: logCookies)
            {
                if("log.c_user".equals(item_cookie.getName()))
                {
                    User = item_cookie.getValue();
                }
                  if("log.pass".equals(item_cookie.getName()))
                {
                    Pass = item_cookie.getValue();
                }
            }
        }
     

%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <script src="Js/icons.js" type="text/javascript"></script>
        <link href="css/estilo.css" rel="stylesheet" type="text/css"/>
        <link href="css/bootstrap.css" rel="stylesheet" type="text/css"/>
        <title>Validaci&oacute;n</title>
    </head>
    <body>  
       
        
        <form class="container" id="formLog" name="formLog" action="validacion.jsp" method="post">
            
            <div class="card card-header" >
                <h1 class="titulo">  <i class="fas fa-lock"></i> Validaci&oacute;n</h1>
            </div>
            <br>

            <div class="log">
                
                <label>Usuario  :</label> 

                <input type="text" placeholder="Usuario" name="usuario" value="<%=User%>" required> 
            </div>   
            <br>
            <div class="log">
                <label>Password :</label> 
                <input type="password" placeholder="Password" name="clave" value="<%=Pass%>" required> 
            </div>
            <div>
            <br>
            <label id="checkbox" ><input class="form-check-input" name="recordar" type="checkbox" checked > Recordar</label> 
            </div> 
            <br>
            <div >
                <input class="btn btn-primary log_submit" type="submit" value="Ingresar clave">
            </div>
            
       

            
        </form>

   

            

        
        
    </body>
</html>
