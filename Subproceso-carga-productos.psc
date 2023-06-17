Algoritmo sistema_gestion
	Definir usuarios Como Caracter
	Dimension usuarios(100, 2) // array de usuarios registrados, maxima cantidad de usuarios: 100
	Definir cantidadUsuarios como Entero
	Definir opcionSeleccionada,opcionMenu Como Entero
	Definir productosCargados como Cadena
	Definir idProducto Como Entero
	//DEFINO ARRAY PARA ALMACENAR LOS DATOS CARGADOS POR USUARIO LUEGO DEL LOGIN. FILAS: 5 PRODUCTOS(EJEMPLO), COLUMNAS 1.ID 2.NOMBRE PRODUCTO 3.STOCK 4.PRECIO
	Dimension productosCargados[5,4]
	idProducto<-0	
	
	// usuario de prueba
	usuarios(0, 0) <- "usertest"
	usuarios(0, 1) <- "pass123"
	cantidadUsuarios <- 1 // esta variable se usa en la funcion logIn y register como index de las filas en el array de usuarios, se le suma 1 por cada nuevo usuario
	
	Escribir "Bienvenido al sistema de gestion"
	
	Repetir
		opcionSeleccionada <- welcomeMenu()
		
		Segun opcionSeleccionada Hacer
			1:
				Si logIn(usuarios, cantidadUsuarios) Entonces
					Escribir "Hola!"
					opcionMenu <- menuOpciones()
					Segun opcionMenu Hacer
						1:
							cargaProductos(productosCargados,idProducto)
						2:
							//ver inventario y dem�s opciones de ordenamiento y b�squedas
					Fin Segun
				FinSi
			2:
				Si register(usuarios, cantidadUsuarios) Entonces
					Escribir "Ya puede loguearse"
				FinSi
			3:
				Escribir "Adios"
		Fin Segun
	Mientras Que opcionSeleccionada <> 3 y opcionSeleccionada <> 1 
	// si es 3 sale y se termina el programa, si es 1 entra en el bucle para el logueo, y al salir, ya sea falso o verdadero el return del logueo, ya no se vuelve e ejecutar el welcomeMenu
FinAlgoritmo


// menu de inicio, devuelvo la opcion seleccionada
Funcion return <- welcomeMenu()
	Definir return Como Entero // uso return como opcion del menu
	Repetir
		Escribir "Seleccione una opcion: "
		Escribir "1.- Loguearse"
		Escribir "2.- Registrarse"
		Escribir "3.- Salir"
		
		Leer return
		
		Si return  < 1 o return > 3 Entonces
			Escribir "Ingrese una opcion correcta"
		FinSi
	Mientras Que return < 1 o return > 3
FinFuncion


// funcion para registrarse, retorna verdadero si el registro ocurre con exito, falso si no
Funcion return <- register(usuarios Por Referencia, cantidadUsuarios Por Referencia)
	Definir user, pass Como Caracter
	Definir return Como Logico
	
	Escribir "Registrar un nuevo usuario:"
	
	Repetir
		Escribir "Ingrese su usuario (10 caracteres como maximo): "
		Leer user
	Mientras Que Longitud(user) > 10
	Repetir
		Escribir "Ingrese su contrasena (entre 6 y 10 caracteres)"
		Leer pass
	Mientras Que Longitud(pass) < 6 o Longitud(pass) > 10
	
	Si Longitud(user) <= 10 y Longitud(pass) >= 6 y Longitud(pass) <= 10 Entonces
		// si los datos ingresados cumplen las condiciones, se agrega el usuario a la lista de usuarios usando de index la variable cantidadUsuarios
		usuarios(cantidadUsuarios, 0) <- user
		usuarios(cantidadUsuarios, 1) <- pass
		cantidadUsuarios <- cantidadUsuarios + 1 // se le suma 1 a la cantidad de usuarios
		Escribir "Usuario registrado con exito"
		return <- Verdadero
	SiNo
		Escribir "Error en el registro"
		return <- Falso
	FinSi
FinFuncion


// funcion para loguearse, retorna verdadero si el logueo es correcto, falso si no
Funcion return <- logIn(usuarios Por Referencia, cantidadUsuarios Por Referencia)
	Definir user, pass Como Caracter
	Definir contadorIntentos, cantidadMaximaIntentos Como Entero
	Definir return Como Logico
	
	return <- Falso
	contadorIntentos <- 0
	cantidadMaximaIntentos <- 5
	
	Definir i como entero
	i <- 0
	
	Escribir "Loguearse:"
	
	Repetir
		Escribir "Ingrese su usuario: "
		Leer user
		Escribir "Ingrese su contrasena: "
		Leer pass
		
		// busco en la lista de usuarios
		Mientras i < cantidadUsuarios Hacer
			Si user == usuarios(i, 0) y pass == usuarios(i, 1)
				Escribir "Se logueo correctamente"
				return <- Verdadero
			FinSi
			i <- i + 1
		Fin Mientras
		i <- 0
		
		Si return = Falso Entonces
			Escribir "Usuario o contrasena incorrectos"
			contadorIntentos <- contadorIntentos + 1
			Si contadorIntentos >= cantidadMaximaIntentos Entonces
				Escribir "Ha superado la cantidad maxima de intentos permitidos, vuelva a intentarlo mas tarde"
			FinSi
		FinSi
	Mientras Que return = Falso y contadorIntentos < cantidadMaximaIntentos
FinFuncion

// CARGA Y ALMACENAMIENTO EN ARRAY
Subproceso cargaProductos(productosCargados,idProducto Por Referencia)
	Definir nombreProducto, otroProducto como cadena
	Definir stockProducto Como Entero
	Definir precioProducto como Real
	Definir confirmaProducto como Logico 
	confirmaProducto<-Verdadero
	
	Repetir 
		Escribir "Ingrese el nombre del producto a cargar:"
		Leer nombreProducto
		
		Escribir  "Ingrese el stock del producto:"
		Leer stockProducto
		
		Escribir "Ingrese el precio del producto cargado:"
		Repetir
			Leer precioProducto
			Si precioProducto<=0
				Escribir "El valor ingresado debe ser mayor a 0"
			FinSi
		Hasta Que precioProducto>0
		
		productosCargados[idProducto,0]<-ConvertirATexto(idProducto)
		productosCargados[idProducto,1]<-nombreProducto
		productosCargados[idProducto,2]<-ConvertirATexto(stockProducto)
		productosCargados[idProducto,3]<-ConvertirATexto(precioProducto)
		
		idProducto<- idProducto+1
		
		Escribir "Desea agrear otro producto? si/no"
		Leer otroProducto
		Si otroProducto="no" Entonces
			confirmaProducto<-Falso
		FinSi
	Hasta Que confirmaProducto=Falso
	
FinSubProceso

//FUNCION PARA OPCIONES DE CARGA Y VER INVENTARIO
Funcion return<-menuOpciones()
	Definir return Como Entero
	Repetir
		Escribir "Ingrese una opci�n:"
		Escribir "1- Agregar productos"
		Escribir "2- Ver inventario"
		Leer return
		Si return <>1 y return<>2 Entonces
			Escribir "Ingrese una opci�n correcta"
		FinSi
	Hasta Que return=1 o return=2
FinFuncion