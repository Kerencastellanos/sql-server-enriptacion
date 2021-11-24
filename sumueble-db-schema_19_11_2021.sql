

CREATE DATABASE SuMuebleDb
GO

Use SuMuebleDb
GO

CREATE TABLE [Categorias](
	[IdCategoria] [int] PRIMARY KEY IDENTITY(1,1) NOT NULL,
	[Categoria] [nvarchar](50) NOT NULL
)
GO
insert into Categorias 
VALUES('Muebles'),('Electrodomisticos'),('Motocicletas')
/****** Object:  Table [Clientes]    Script Date: 11/8/2021 08:55:21 ******/

CREATE TABLE [Clientes](
	IdCliente int PRIMARY KEY IDENTITY,
	[DNI] [nvarchar](13) unique NOT NULL,
	[RTN] [nvarchar](15) NULL,
	[Nombre] [nvarchar](200) NOT NULL,
	[Direccion] [nvarchar](255) NULL,
	[Email] [nvarchar](320) unique NULL,
	[Telefono] [nvarchar](8) NOT NULL,
	[Registrado] [date] NULL
) 
GO

/****** Object:  Table [Puestos]    Script Date: 11/8/2021 08:55:21 ******/

CREATE TABLE [Puestos](
	[IdPuesto] [int] PRIMARY KEY IDENTITY(1,1) NOT NULL,
	[Puesto] [nvarchar](50) NOT NULL
)
GO
insert into Puestos 
values('Gerente'),
('Secretaria'),
('Administrador Ventas'),
('Administrador Bodega')


/****** Object:  Table [Colaboradores]    Script Date: 11/8/2021 08:55:21 ******/

CREATE TABLE [Colaboradores](
	IdColaborador int PRIMARY KEY IDENTITY,
	[DNI] [nvarchar](13) unique NOT NULL,
	[RTN] [nvarchar](14) unique NOT NULL,
	[Nombre] [nvarchar](255) NOT NULL,
	[Clave] [nvarchar](450) NOT NULL,
	[PuestoFk] [int] FOREIGN KEY REFERENCES Puestos(IdPuesto) NOT NULL,
	[Direccion] [nvarchar](255) NULL,
	[Telefono] [nvarchar](8) NOT NULL,
	[Email] [nvarchar](320) unique NOT NULL,
	[FechaNacimiento] [date] NOT NULL,
	[FechaContratado] [datetime] NOT NULL default (getdate()),
	[FechaFinContrato] [datetime] NULL,
	[Activo] [bit] NULL default (1)
)
GO

create table ProductoEstado(
	IdEstado int PRIMARY KEY IDENTITY,
	Estado nvarchar(20) -- usado,nuevo
)
go

insert into ProductoEstado values('Nuevo'),('Usado')
go
/****** Object:  Table [Productos]    Script Date: 11/8/2021 08:55:21 ******/

CREATE TABLE [Productos](
	[IdProducto] [int] PRIMARY KEY IDENTITY(1,1) NOT NULL,
	[Codigo] [nvarchar](25) unique not null,
	[NombreProducto] [nvarchar](100) NOT NULL,
	[Existencias] [int] NOT NULL,
	[PrecioUnitario] [decimal](7,2) NOT NULL,-- 400*0.15 -- 
	[ISV] [decimal](7,2) NULL,--0.15 --0.18 --0    
	[CategoriaFk] [int] FOREIGN KEY REFERENCES Categorias(IdCategoria) NOT NULL,
	EstadoFk int foreign key references ProductoEstado(IdEstado),
	[Activo] [bit] NULL DEFAULT (1)
)
GO

/****** Object:  Table [TiposVentas]    Script Date: 11/8/2021 08:55:21 ******/

CREATE TABLE [TiposVentas](
	[IdTipoVenta] [int] PRIMARY KEY IDENTITY(1,1) NOT NULL,
	[Tipo] [nvarchar](50) NOT NULL
)
GO

INSERT INTO TiposVentas values('Al Contado'),('Al Credito')
go
/****** Object:  Table [Ventas]    Script Date: 11/8/2021 08:55:21 ******/

CREATE TABLE [Ventas](
	[IdVenta] [int] PRIMARY KEY IDENTITY NOT NULL,
	[ClienteFk] [int] FOREIGN KEY REFERENCES Clientes(IdCliente) NOT NULL,
	[ColaboradorFk] [int] FOREIGN KEY REFERENCES Colaboradores(IdColaborador) NOT NULL,
	[TipoVentaFk] [int] FOREIGN KEY REFERENCES TiposVentas(IdTipoVenta) NOT NULL,
	[Prima] [decimal](7,2) NULL,
	[Cuotas] [int] NULL,
	[FechaVenta] [datetime] NULL default (getdate()),
	[FechaFinCredito] [datetime] NULL
) 
GO


/****** Object:  Table [DetallesVentas]    Script Date: 11/8/2021 08:55:21 ******/

CREATE TABLE [DetallesVentas](
	[VentaFk] [int] FOREIGN KEY REFERENCES Ventas(IdVenta) NOT NULL,
	[ProductoFk] [int] FOREIGN KEY REFERENCES Productos(IdProducto) NOT NULL,
	[PrecioVenta] [decimal](7,2)NOT NULL,
	[Cantidad] [int] NOT NULL,
	[Descuento] [decimal](7,2) NULL
)
GO
/****** Object:  Table [Devoluciones]    Script Date: 11/8/2021 08:55:21 ******/

CREATE TABLE [Devoluciones](
	[IdDevolucion] [int] PRIMARY KEY IDENTITY(1,1) NOT NULL,
	[VentaFk] [int] FOREIGN KEY REFERENCES Ventas(IdVenta) NOT NULL,
	[ColaboradorFk] [int] FOREIGN KEY REFERENCES Colaboradores(IdColaborador) NOT NULL,
	[Fecha] [nvarchar](50) NULL
) 
GO
CREATE TABLE DetalleDevolucion(
	[DevolucionFk] [int] FOREIGN KEY REFERENCES Devoluciones(IdDevolucion) NOT NULL,
	[ProductoFk] [int] FOREIGN KEY REFERENCES Productos(IdProducto) NOT NULL,
	[Cantidad] [int] NOT NULL,
	[Motivo] [nvarchar](20) NULL,
	[Observaciones] [nchar](50) NULL
)		


/****** Object:  Table [Pagos]    Script Date: 11/8/2021 08:55:21 ******/

CREATE TABLE [Pagos](
	[ColaboradorFk] [int] FOREIGN KEY REFERENCES Colaboradores(IdColaborador) NOT NULL,
	[VentaFk] [int] FOREIGN KEY REFERENCES Ventas(IdVenta) NOT NULL,
	[Monto] [decimal](7,2) NOT NULL, --1,000,000.99
	[Fecha] [date] NULL DEFAULT (getdate())
) 
GO



/****** Object:  Table [Referencias]    Script Date: 11/8/2021 08:55:21 ******/

CREATE TABLE [Referencias](
	[IdReferencia] [int] PRIMARY KEY IDENTITY(1,1) NOT NULL,
	[Nombre] [nvarchar](100) NOT NULL,
	[DNIReferencia] [nvarchar](13) NULL,
	[Telefono] [nvarchar](8) NOT NULL,
	[Direccion] [nvarchar](150) NULL,
	[CodigoRecibo] [nvarchar](7) NOT NULL,
	[VentaFk] [int] FOREIGN KEY REFERENCES Ventas(IdVenta) NOT NULL
)
GO

select * from colaboradores 
select * from ProductoEstado 
update Colaboradores set Activo = 1






