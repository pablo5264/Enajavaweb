/*creacion de base*/
--create database req_negocio
/*usar database*/
use req_negocio


GO
DROP TABLE tb_rol;
GO
CREATE TABLE tb_rol
(
r_id_rol INT PRIMARY KEY IDENTITY(1,1),
u_tipo VARCHAR(50) not null, 
u_status INT not null DEFAULT 1,
)
GO

GO
DROP TABLE tb_usuario;
GO
CREATE TABLE tb_usuario
(
u_id_user INT PRIMARY KEY IDENTITY(1,1),
u_user VARCHAR(50) not null UNIQUE, 
u_password VARCHAR(50) not null,
u_id_rol INT not null, 
u_status INT not null DEFAULT 1,
FOREIGN KEY(u_id_user) REFERENCES  tb_rol(r_id_rol)
)
GO

GO
DROP TABLE tb_gerencia;
GO
CREATE TABLE tb_gerencia
(
id_gerencia INT PRIMARY KEY IDENTITY(100,100),
gerencia VARCHAR(50) not null UNIQUE, 
g_status INT not null DEFAULT 1,
)
GO

GO
DROP TABLE tb_dpto;
GO
CREATE TABLE tb_dpto
(
id_dpto INT PRIMARY KEY IDENTITY(10,10),
depto VARCHAR(50) not null UNIQUE, 
d_status INT not null DEFAULT 1,
id_gerencia int not null,
FOREIGN KEY(id_gerencia) REFERENCES tb_gerencia(id_gerencia)
)
GO

GO
DROP TABLE tb_area;
GO
CREATE TABLE tb_area
(
id_area INT PRIMARY KEY IDENTITY(10,10),
area VARCHAR(50) not null UNIQUE, 
d_status INT not null DEFAULT 1,
)
GO

GO
DROP TABLE tb_encargados;
GO
CREATE TABLE tb_encargados
(
id INT PRIMARY KEY IDENTITY(1000,1),
nombre VARCHAR(50) not null, 
apPaterno VARCHAR(50) not null,
apMaterno VARCHAR(50) not null,
correo VARCHAR(50) not null unique,
e_status INT not null DEFAULT 1,
id_area int not null,
FOREIGN KEY(id_area) REFERENCES tb_area(id_area)
)
GO

GO
DROP TABLE tb_requerimientos;
GO
CREATE TABLE tb_requerimientos
(
id_requerimiento INT PRIMARY KEY IDENTITY(1,1),
id_gerencia int not null, 
id_depto int not null,
id_area int not null,
id_encargado int not null,
requerimiento varchar(100) not null,
fecha date not null,
e_status INT not null DEFAULT 1,
FOREIGN KEY(id_gerencia) REFERENCES tb_gerencia(id_gerencia),
FOREIGN KEY(id_depto) REFERENCES tb_dpto(id_dpto),
FOREIGN KEY (id_area) REFERENCES tb_area(id_area)
)
GO

drop procedure sp_requerimientos;
go
create procedure sp_requerimientos
@in_gerencia int,
@in_dpto int,
@in_area int,
@in_buscar varchar(100)
as	
	select id_requerimiento, tb_requerimientos.id_gerencia, tb_gerencia.gerencia,
	tb_requerimientos.id_depto, tb_dpto.depto, tb_requerimientos.id_area, tb_area.area,
	tb_requerimientos.id_encargado, tb_encargados.nombre, tb_encargados.apPaterno as paterno, tb_encargados.apMaterno as materno,
	tb_requerimientos.fecha, tb_requerimientos.e_status as estado,  requerimiento
	from tb_requerimientos
	inner join tb_gerencia
	on tb_gerencia.id_gerencia=tb_requerimientos.id_gerencia
	inner join tb_dpto
	on tb_requerimientos.id_depto = tb_dpto.id_dpto
	inner join tb_area
	on tb_requerimientos.id_area = tb_area.id_area
	inner join tb_encargados
	on tb_requerimientos.id_encargado = tb_encargados.id
	where tb_requerimientos.e_status = 1 
	and 
	(tb_requerimientos.id_gerencia = @in_gerencia or @in_gerencia = 0)
	and
	(tb_requerimientos.id_depto = @in_dpto or @in_dpto = 0)
	and
	(tb_requerimientos.id_area = @in_area or @in_area = 0)
	and
	(tb_gerencia.gerencia like '%'+@in_buscar+'%' or 
	tb_dpto.depto like '%'+@in_buscar+'%' or 
	tb_area.area like '%'+@in_buscar+'%' or	
	tb_encargados.nombre like '%'+@in_buscar+'%' or 
	tb_encargados.apPaterno like '%'+@in_buscar+'%' or 
	tb_encargados.apMaterno like '%'+@in_buscar+'%' or
	requerimiento like '%'+@in_buscar+'%' )
go



drop procedure sp_insert_requerimiento;
go
create procedure sp_insert_requerimiento
@in_gerencia int,
@in_depto int,
@in_area int,
@in_encargado int,
@in_requerimiento varchar(100)
as
	insert into tb_requerimientos (id_gerencia , id_depto, id_area, id_encargado, requerimiento, fecha)
	values(@in_gerencia,@in_depto,@in_area, @in_encargado, @in_requerimiento, GETDATE());
go



drop procedure sp_valida;
go
create procedure sp_valida
@u_usuario varchar(50),
@u_pass varchar(50)
as
	SELECT u_id_user as id, u_user as usuario, u_id_rol as id_rol, u_tipo as tipo, usuario.u_status as estado FROM tb_usuario as usuario
	INNER JOIN tb_rol as rol
	On usuario.u_id_rol = rol.r_id_rol
	where u_user = @u_usuario and u_password = @u_pass

go

drop procedure sp_lista_gerencia;
go
create procedure sp_lista_gerencia
as
	Select id_gerencia as id, gerencia as nombre, g_status as estado from tb_gerencia where g_status = 1
go

drop procedure sp_lista_dpto;
go
create procedure sp_lista_dpto
@in_gerencia int
as
	Select id_dpto as id, depto as nombre, d_status as estado, tb_gerencia.id_gerencia as gerencia from tb_dpto  
	inner join tb_gerencia
	on tb_dpto.id_gerencia = tb_gerencia.id_gerencia
	where d_status = 1 and tb_dpto.id_gerencia = @in_gerencia
go

drop procedure sp_lista_dpto_asignar;
go
create procedure sp_lista_dpto_asignar
as
	Select id_dpto as id, depto as nombre, d_status as estado, tb_gerencia.id_gerencia as gerencia from tb_dpto  
	inner join tb_gerencia
	on tb_dpto.id_gerencia = tb_gerencia.id_gerencia
	where d_status = 1
go

drop procedure sp_lista_encargado;
go
create procedure sp_lista_encargado
@in_area int
as
	select id, nombre, apMaterno as paterno, apMaterno as materno, correo, tb_encargados.e_status as estado, tb_encargados.id_area from tb_encargados 
	inner join tb_area
	on tb_encargados.id_area = tb_area.id_area
	where e_status = 1 and tb_encargados.id_area = @in_area
go


select * from tb_requerimientos

drop procedure sp_cerrar_requerimiento;
go
create procedure sp_cerrar_requerimiento
@in_id_requerimiento int
as
	update tb_requerimientos set e_status = 0 where id_requerimiento =  @in_id_requerimiento
go

INSERT INTO tb_rol (u_tipo) VALUES ('Administrador');
/*Insert tb_usuario*/
INSERT INTO tb_usuario (u_user, u_password, u_id_rol) VALUES ('admin','12345',1);
INSERT INTO tb_usuario (u_user, u_password, u_id_rol) VALUES ('pablo','12345',1);


INSERT INTO tb_gerencia(gerencia) VALUES ('Gerente de Cliente');
INSERT INTO tb_gerencia(gerencia) VALUES ('Gerente de Ventas');



INSERT INTO tb_dpto (depto, id_gerencia) VALUES ('Departamento de Cliente ', 100);
INSERT INTO tb_dpto (depto, id_gerencia) VALUES ('Departamento de Ventas ', 200);


INSERT INTO tb_area (area) VALUES ('Abastecimiento');
INSERT INTO tb_area (area) VALUES ('soporte TI');


INSERT INTO tb_encargados (nombre, apPaterno, apMaterno, correo, id_area) VALUES ('Pablo','Ramirez','Acu�a','pablo.ramirezac@correoaiel.cl', 10);
INSERT INTO tb_encargados (nombre, apPaterno, apMaterno, correo, id_area) VALUES ('juanito','guerrero','Reyes','juanito56@correo.cl',10);
INSERT INTO tb_encargados (nombre, apPaterno, apMaterno, correo, id_area) VALUES ('Carlos','perez','Prieto','carlosperes5@correo.cl',10);
INSERT INTO tb_encargados (nombre, apPaterno, apMaterno, correo, id_area) VALUES ('Guillermo','mora','saez','guillermo25642@correo.cl',10);
INSERT INTO tb_encargados (nombre, apPaterno, apMaterno, correo, id_area) VALUES ('julia','Venegas','Aliagada','juliavenegas1@correo.cl',20);
INSERT INTO tb_encargados (nombre, apPaterno, apMaterno, correo, id_area) VALUES ('Ana','Ordenes','Barra','anaordenes@correo.cl',20);
INSERT INTO tb_encargados (nombre, apPaterno, apMaterno, correo, id_area) VALUES ('Ariel','Caceres','Flores','arielcaceres@correo.cl',20);
INSERT INTO tb_encargados (nombre, apPaterno, apMaterno, correo, id_area) VALUES ('Robero','Padilla','gonzales','sapadilla@correo.cl',20);
INSERT INTO tb_encargados (nombre, apPaterno, apMaterno, correo, id_area) VALUES ('Pablo','Mardones','Roa','pablomardones@correo.cl',20);
INSERT INTO tb_encargados (nombre, apPaterno, apMaterno, correo, id_area) VALUES ('manuel','Aguilera','Valenzuala','m.peaguilera@correo.cl',20);

select * from tb_encargados
select * from tb_gerencia
select * from tb_dpto
select * from tb_area
select * from tb_usuario
 
 