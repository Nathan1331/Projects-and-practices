------------------------------1
CREATE procedure[dbo].[sp_insertDatosCliente] 
@Nombre varchar(50),
@identificacion varchar(50)
as
begin
INSERT  INTO  Datos(NombreCompleto, Identificacion)
VALUES(@Nombre,
@identificacion)
Declare @TipoUsuario int = 2
Declare @IdDatos int
select @IdDatos = IdDatos from dbo.Datos where Identificacion = @identificacion
insert into Usuario(IdDatos, IdTipoUsuario)
values
(@IdDatos, @TipoUsuario)

end
go

----------------------------------------------------2

Create procedure [dbo].[sp_insertProveedor]
@Nombre varchar(50),
@identificacion varchar(50)
as
begin
INSERT  INTO  Datos(NombreCompleto, Identificacion)
VALUES(@Nombre,
@identificacion)
Declare @TipoUsuario int = 3
Declare @IdDatos int
select @IdDatos = IdDatos from dbo.Datos where Identificacion = @identificacion
insert into Usuario(IdDatos, IdTipoUsuario)
values
(@IdDatos, @TipoUsuario)

end 
GO
----------------------------------------------------3
Create procedure [dbo].[sp_insertVendedor]
@Nombre varchar(50),
@identificacion varchar(50)
as
begin
INSERT  INTO  Datos(NombreCompleto, Identificacion)
VALUES(@Nombre,
@identificacion)
Declare @TipoUsuario varchar(1) = 2
Declare @IdDatos int
select @IdDatos = IdDatos from dbo.Datos where Identificacion = @identificacion 
insert into Usuario(IdDatos, IdTipoUsuario)
values
(@IdDatos, @TipoUsuario)

end

Go
----------------------------------------------------4
CREATE procedure[dbo].[sp_insertProd]
@Descripcion varchar(10),
@Catalogo varchar(10),
@Precio int,
@PrecioPorMayor int,
@Costo int,
@IdFamiliaProd int
as
begin
insert into DescripcionDeProducto (Descripcion, Catalogo)
values
(@Descripcion, @Catalogo)

insert into PreciosDeProducto(Precio, PrecioPorMayor, Costo)
values
(@Precio, @PrecioPorMayor, @Costo)

declare @IdDescripcion varchar(50), @IdPreciosDeProducto varchar(50)
select @IdDescripcion= IdDescipcionDeProducto from DescripcionDeProducto where Descripcion= @Descripcion 
select @IdPreciosDeProducto= @IdPreciosDeProducto from PreciosDeProducto where (Precio= @Precio and PrecioPorMayor= @PrecioPorMayor and Costo= @Costo) 

INSERT  INTO Producto(IdDescripcionDeProducto, IdPreciosDeProducto, Saldo, IdFamiliaProducto)
VALUES(@IdDescripcion, @IdPreciosDeProducto, @IdFamiliaProd)
end
go

----------------------------------------------------5
Create procedure[dbo].[sp_insertmetasVendedor]
@Meta int ,
@IdUsuario int
as
begin 
insert into MetasVendedor(Meta,IdUsuario)
VALUES (@Meta,
@IdUsuario)
end
go

----------------------------------------------------6

Create procedure [dbo].[sp_insertMetasSucursal]
@Meta int ,
@IdUsuario int 
as
begin
insert into MetasSucursal
values (@Meta,@IdUsuario)
end
go 

----------------------------------------------------7

Create procedure [dbo].[sp_insertEncargadosOc]
@idCliente int,
@Nombre varchar (50),
@correo varchar (50)
as
begin
insert into EncargadoOc
values (
@Nombre,
@correo,
@idCliente)
end
go 

----------------------------------------------------8
Create procedure [dbo].[sp_insertFacturas]
@idVendedor int,
@idCliente int,
@idSucursal int
as
begin

insert into Documento(IdVendedor, IdCliente, IdSucursal, IdTipoDocumento,Total)
values (@idVendedor,
@idCliente,
@idSucursal,
1,
0)
declare @IdDetalleDocumento int
select @IdDetalleDocumento = max(iddetalledocumento) from dbo.DetalleDocumento
print 'Favor agregar codigos, La factura creada es ' 
print @IdDetalleDocumento
end
go

----------------------------------------------------9
Create procedure [dbo].[sp_insertLineasDeFactura]
@iddocumento int,
@idproducto int,
@cantidad int
as
begin
insert into DetalleDocumento(IdProducto, Cantidad, IdDocumento)
values (@idproducto, @cantidad, @iddocumento)

declare @precio int
select @precio = precio from Producto inner join PreciosDeProducto  on producto.IdPreciosDeProducto = PreciosDeProducto.IdDatosDeProducto 

update documento
set
MontoTotal = MontoTotal +(@precio*@cantidad)
where IdDocumento= @iddocumento

end 
go
--------------------------------------------10
create procedure sp_insertcorreo
@correo varchar(50),
@IdtipoDeCorreo int,
@idusuario int
as
begin
insert into Correo (Correo,IdTipoCorreo, IdUsuario)
values
(@correo, @IdtipoDeCorreo, @idusuario)
end
go

-------------update-------------------1
CREATE procedure[dbo].[sp_UpdateDatosUsuario] 
@iddatos int,
@Nombre varchar(50),
@identificacion varchar(50),
@IdtipodeUsuario int
as
begin
UPDATE Datos
   SET NombreCompleto =@Nombre,
       Identificacion=@Identificacion,
       @IdtipodeUsuario=@IdtipodeUsuario
 WHERE	IdDatos=@iddatos
 end
GO
-------------update-------------------2
CREATE procedure[dbo].[sp_UpdateDescProd]
@idProducto int,
@Descripcion varchar(10),
@Catalogo varchar(10)
as
begin
UPDATE [dbo].DescripcionDeProducto
   SET Descripcion= Descripcion,
       Catalogo =Catalogo
 WHERE  IdDescipcionDeProducto =@idProducto
 end
GO
-------------------------------------------3
Create procedure[dbo].[sp_UpdateDetalleDoc]
@iddetalledocumento int,
@idProducto int not null,
@Cantidad int not null
as
begin 
UPDATE [dbo].DetalleDocumento
   SET IdProducto =IdProducto,
       Cantidad = Cantidad
 WHERE IdDetalleDocumento=@iddetalledocumento
 end
GO



-------------update-------------------4
Create procedure [dbo].[sp_UpdateCorreo]
@idCorreo int,
@correo varchar(50),
@idTipoCorreo int,
@IdUsuario int
as 
begin
UPDATE [Correo]
   SET Correo =@correo,
       IdTipoCorreo =@idTipoCorreo,
       IdUsuario =@IdUsuario
 WHERE IdCorreo=@idCorreo
 end
GO




-------------update-------------------5
Create procedure [dbo].[sp_UpdateMetasSucursal]
@idMeta int,
@Meta int,
@idSucursal int
as
begin
UPDATE MetasSucursal
   SET IdSucursal =@idSucursal,
       Meta=@Meta
 WHERE IdMetaSucursal=@idMeta
 end
GO

-------------update-------------------6
Create procedure [dbo].[sp_UpdateMetasVendedor]
@idmeta int ,
@Meta int,
@idUsuario int
as
begin

UPDATE MetasVendedor
   SET Meta=@Meta,
       idUsuario=@idUsuario
       WHERE IdMetasVendedor = @idmeta
 end
GO


-------------update-------------------7
Create procedure [dbo].[sp_UpdateVendedoresPorSucursal]
@idVendedorporSuc int ,
@IdVendedor int,
@IdSucursal int
as
begin
UPDATE VendedoresPorSucursal
   SET IdVendedor = @IdVendedor,
      IdSucursal = @IdSucursal
 WHERE IdVendedoresPorSucursal=@idVendedorporSuc
 end
GO

-------------update-------------------8
Create procedure [dbo].[sp_UpdateEncargadosOc]
@idEncargadoOC int,
@Nombre varchar (50),
@correo varchar (50),
@idusuario int
as
begin
UPDATE EncargadoOc
   SET nombre= @Nombre,
       IdUsuario = @idusuario,
       correo =correo
 WHERE IdEncargadoOc = @idEncargadoOC

 end
 go
-------------update-------------------9
Create procedure [dbo].sp_updatecalificacionCli
@idCalificacionCliente int,
@idCliente int,
@Calificacion int,
@Nota varchar(50)
as
begin
UPDATE [dbo].CalificacionCliente
   SET IdCliente =@idCliente,
       Calificacion =@Calificacion,
       Nota =@Nota
 WHERE IdCalificacionCliente =@idCalificacionCliente,
 end
GO



-------------update-------------------10

Create procedure [dbo].[sp_UpdateProdCompleto]
@IdDatosDeProducto int,
@Precio int,
@PrecioPorMayor int,
@Costo int,
@Descirpcion varchar (50),
@Catalogo varchar (50)
as
begin
UPDATE [dbo].PreciosDeProducto
   SET IdDatosDeProducto = @IdDatosDeProducto,
		precio = @Precio,
		PrecioPorMayor = @PrecioPorMayor,
		Costo= @Costo
 WHERE IdDatosDeProducto=@IdDatosDeProducto
 
 declare @idproducto int
 select @idproducto = idproducto from Producto where IdPreciosDeProducto=@IdDatosDeProducto


 exec sp_UpdateDescProd idproducto, @Descirpcion, @Catalogo

 end
GO

--1
CREATE PROCEDURE SP_VerProveedores
AS

SELECT usuario.IdUsuario, tiposusuario.Tipo, NombreCompleto, Identificacion, Correo, tipocorreo.tipo, telefono from Usuario
inner join TiposUsuario on usuario.IdTipoUsuario = TiposUsuario.IdTipoUsuario  
inner join Datos on usuario.IdDatos = datos.IdDatos 
inner join correo on usuario.IdUsuario = correo.IdCorreo 
inner join TipoCorreo on correo.IdTipoCorreo = TipoCorreo.IdTipoCorreo 
inner join telefono on Usuario.IdUsuario = telefono.idusuario 
where tiposusuario.IdTipoUsuario= '3'


GO

exec SP_VerProveedores
--------------------------------
--2
CREATE PROCEDURE SP_VerClientes
AS

SELECT usuario.IdUsuario, tiposusuario.Tipo, NombreCompleto, Identificacion, Correo, tipocorreo.tipo, telefono from Usuario
inner join TiposUsuario on usuario.IdTipoUsuario = TiposUsuario.IdTipoUsuario  
inner join Datos on usuario.IdDatos = datos.IdDatos 
inner join correo on usuario.IdUsuario = correo.IdCorreo 
inner join TipoCorreo on correo.IdTipoCorreo = TipoCorreo.IdTipoCorreo 
inner join telefono on Usuario.IdUsuario = telefono.idusuario 
where tiposusuario.IdTipoUsuario= '2'
go


exec SP_VerClientes


--------------------------------
--3
CREATE PROCEDURE SP_VerVendedroesYMetas
AS

SELECT usuario.IdUsuario, tiposusuario.Tipo, NombreCompleto, Identificacion, Correo, tipocorreo.tipo, telefono, Meta from Usuario
inner join TiposUsuario on usuario.IdTipoUsuario = TiposUsuario.IdTipoUsuario  
inner join Datos on usuario.IdDatos = datos.IdDatos 
inner join correo on usuario.IdUsuario = correo.IdCorreo 
inner join TipoCorreo on correo.IdTipoCorreo = TipoCorreo.IdTipoCorreo 
inner join telefono on Usuario.IdUsuario = telefono.idusuario 
inner join MetasVendedor on Usuario.IdUsuario = MetasVendedor.IdUsuario
where tiposusuario.IdTipoUsuario= 1
exec
 SP_VerVendedroesYMetas
GO
exec SP_VerVendedroesYMetas

--------------------------------
--4
CREATE PROCEDURE sp_metasSucursall 
AS
SELECT Meta, Nombre, Direccion, CentralTelefonica from dbo.MetasSucursal 
inner join Sucursal on MetasSucursal.IdSucursal = Sucursal.IdSucursal 
inner join DatosSucursal on sucursal.IdDatosSucursal = DatosSucursal.IdDatosSucursal
GO
exec sp_metasSucursall
-----------------------------------
--5
CREATE PROCEDURE SP_SucursalYVendedores
AS
select Nombre,Direccion, CentralTelefonica, NombreCompleto from Sucursal
inner join DatosSucursal on sucursal.IdDatosSucursal = DatosSucursal.IdDatosSucursal 
inner join VendedoresPorSucursal on VendedoresPorSucursal.IdSucursal = Sucursal.IdSucursal
inner join Usuario on IdVendedor = IdUsuario
inner join Datos on IdUsuario = datos.IdDatos
GO
exec SP_SucursalYVendedores



------------------------------------------------------------------------
CREATE VIEW view_telefonosproveedores AS  --1
SELECT NombreCompleto, Telefono from usuario inner join Telefono on usuario.IdUsuario = Telefono.IdUsuario
inner join TiposUsuario on usuario.IdTipoUsuario = TiposUsuario.IdTipoUsuario
inner join datos on usuario.IdUsuario = TiposUsuario.IdTipoUsuario where telefono.IdTelefono = 3

go

CREATE VIEW view_telefonosClientes AS --2
SELECT NombreCompleto, Telefono from usuario inner join Telefono on usuario.IdUsuario = Telefono.IdUsuario
inner join TiposUsuario on usuario.IdTipoUsuario = TiposUsuario.IdTipoUsuario
inner join datos on usuario.IdUsuario = TiposUsuario.IdTipoUsuario where telefono.IdTelefono = 2

go

CREATE VIEW view_telefonosvendedores AS --3
SELECT NombreCompleto, Telefono from usuario inner join Telefono on usuario.IdUsuario = Telefono.IdUsuario
inner join TiposUsuario on usuario.IdTipoUsuario = TiposUsuario.IdTipoUsuario
inner join datos on usuario.IdUsuario = TiposUsuario.IdTipoUsuario where telefono.IdTelefono = 1

go
create view view_metasvendedores --4
as
select Meta, NombreCompleto  from MetasVendedor inner join Usuario on MetasVendedor.IdUsuario = usuario.IdUsuario
inner join TiposUsuario on usuario.IdTipoUsuario = TiposUsuario.IdTipoUsuario
inner join Datos on datos.IdDatos = usuario.IdUsuario
where tiposusuario.IdTipoUsuario =1
go
create view view_metasSucursales --5
as
select Meta, Nombre  from MetasSucursal inner join Sucursal on MetasSucursal.IdSucursal = Sucursal.IdSucursal
inner join DatosSucursal on sucursal.IdDatosSucursal = DatosSucursal.IdDatosSucursal
go

create view view_ventasSucursales --6
as
select Monto, Mes,  Nombre  from VentasSucursal inner join Sucursal on VentasSucursal.IdSucursal = Sucursal.IdSucursal
inner join DatosSucursal on sucursal.IdDatosSucursal = DatosSucursal.IdDatosSucursal
go


create view view_ventasvendedores --7
as
select monto, Mes, NombreCompleto  from VentasVendedor inner join Usuario on VentasVendedor.IdUsuario = usuario.IdUsuario
inner join TiposUsuario on usuario.IdTipoUsuario = TiposUsuario.IdTipoUsuario
inner join Datos on datos.IdDatos = usuario.IdUsuario
where tiposusuario.IdTipoUsuario =1
go

create view ViewcorreosVendedores --8
as
select NombreCompleto, Correo from usuario 
inner join TiposUsuario on usuario.IdTipoUsuario= tiposusuario.IdTipoUsuario 
inner join Datos on usuario.IdDatos = datos.IdDatos
inner join Correo on Correo.IdUsuario = usuario.IdUsuario
where TiposUsuario.IdTipoUsuario=3

go

create view viewUsuariosDetalle --9
as
select tiposusuario.Tipo, NombreCompleto, Identificacion, correo  from usuario 
inner join TiposUsuario on usuario.IdTipoUsuario= tiposusuario.IdTipoUsuario 
inner join Datos on usuario.IdDatos = datos.IdDatos
inner join Correo on Correo.IdUsuario = usuario.IdUsuario
inner join TipoCorreo on TipoCorreo.IdTipoCorreo = correo.IdTipoCorreo
go


create view ViewListaPreciosProductos -- 10
as
select IdProducto, Saldo, Descripcion, Catalogo, Precio, PrecioPorMayor, Costo from Producto inner join DescripcionDeProducto on Producto.IdDescripcionDeProducto = DescripcionDeProducto.IdDescipcionDeProducto 
inner join PreciosDeProducto on Producto.IdPreciosDeProducto = PreciosDeProducto.IdDatosDeProducto
inner join FamiliasProducto on producto.IdFamiliaProducto = FamiliasProducto.IdFamiliaProducto
go


--Nathan Rosales    30-11-2019
declare CursorUsuarios cursor scroll
for select * from viewUsuariosDetalle

open CursorUsuarios
declare @TipoUsuario varchar(20),@Nombre varchar(20), @Ident varchar(20), @Correo varchar(20) 

fetch next from CursorUsuarios into @TipoUsuario ,@Nombre, @Ident, @Correo

while (@@FETCH_STATUS = 0)
begin
print 'Tipo Usuario: '+ @TipoUsuario+'   Nombre: ' +@Nombre+'  Identificacion: ' +@Ident+'  Correo: ' +@Correo
fetch next from CursorUsuarios into @TipoUsuario ,@Nombre, @Ident, @Correo


end

close CursorUsuarios
deallocate CursorUsuarios


--Nathan Rosales   

declare CursorMetas cursor 
for select * from view_metasvendedores


DECLARE @META VARCHAR(50), @NOMBREE VARCHAR(50)

open CursorMetas
fetch next from CursorMetas into @META ,@NOMBREE 
while (@@FETCH_STATUS = 0)
begin
print 'Meta: '+ @META+'   Nombre: ' +@NOMBREE
fetch next from CursorMetas into @META ,@NOMBREE


end

close CursorMetas
deallocate CursorMetas