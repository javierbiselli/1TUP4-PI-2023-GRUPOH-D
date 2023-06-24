Algoritmo sistema_gestion
	Definir usuarios Como Caracter
	Dimension usuarios(100, 2) // array de usuarios registrados, maxima cantidad de usuarios: 100
	Definir cantidadUsuarios como Entero
	Definir opcionSeleccionada Como Entero
	Definir productosCargados como Cadena
	Definir idProducto Como Entero
	//DEFINO ARRAY PARA ALMACENAR LOS DATOS CARGADOS POR USUARIO LUEGO DEL LOGIN. FILAS: 100 (PRODUCTOS), COLUMNAS: 4 (1.ID 2.NOMBRE PRODUCTO 3.STOCK 4.PRECIO)
	Dimension productosCargados[100,4] 
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
					Repetir
						opcionSeleccionada <- menuOpciones()
						Segun opcionSeleccionada Hacer
							1:
								cargaProductos(productosCargados,idProducto)
							2:
								//ver inventario --- tipos de vistas con ordenamiento
							3:
								// buscar producto y mostrar
							4:	
								editarProducto(productosCargados, 100)
						Fin Segun
					Hasta Que opcionSeleccionada=5
				FinSi
			2:
				Si register(usuarios, cantidadUsuarios) Entonces
					Escribir "Ya puede loguearse"
				FinSi
			3:
				Escribir "Adios"
		Fin Segun
	Mientras Que opcionSeleccionada <> 3 y opcionSeleccionada <> 1 
	// si es 5 sale y se termina el programa, si es 1 entra en el bucle para el logueo, y al salir, ya sea falso o verdadero el return del logueo, ya no se vuelve e ejecutar el welcomeMenu
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
Subproceso cargaProductos(productosCargados Por Referencia,idProducto Por Referencia)
	Definir nombreProducto, otroProducto, otroProductoMayuscula como cadena
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
		
		Repetir
			Escribir "Desea agregar otro producto? SI/NO"
			Leer otroProducto
			otroProductoMayuscula<-Mayusculas(otroProducto)
			Si otroProductoMayuscula="NO" Entonces
				confirmaProducto<-Falso
			Sino 
				Si otroProductoMayuscula<>"SI" y otroProductoMayuscula<>"NO" Entonces
					Escribir "Opción no válida, vuelva a intentarlo"
				FinSi
			FinSi
		Mientras Que  otroProductoMayuscula<>"SI" y otroProductoMayuscula<>"NO"
	Hasta Que confirmaProducto=Falso
FinSubProceso


//FUNCION PARA MENU CON OPCIONES DE CARGA Y VER INVENTARIO
Funcion return<-menuOpciones()
	Definir return Como Entero
	
	Escribir "Ingrese una opción:"
	Escribir "1- Agregar productos"
	Escribir "2- Ver inventario"
	Escribir "3- Buscar producto"
	Escribir "4- Editar producto"
	Escribir "5- Salir"
	Repetir	
		Leer return
		Si return > 5 o return <1 Entonces
			Escribir "Ingrese una opción correcta"
		FinSi
	Hasta Que return>0 y return<6
FinFuncion



//Subproceso editar producto (nombre, stock o precio)
Subproceso editarProducto(productosCargados Por Referencia, filas)
	Definir  nuevoNombre como Cadena
	Definir numeroId, filaProductoEncontrado, opcionMenu, nuevoStock, nuevoPrecio Como Entero
	
	
	Repetir
		Escribir "Ingrese el código ID del producto que desea editar"
		Leer numeroId
		Si numeroId<0 Entonces
			Escribir "El ID debe ser mayor o igual a 0"
		FinSi
	Mientras Que numeroId <0
	
	
	filaProductoEncontrado<- buscarProducto(productosCargados,filas,0,ConvertirATexto(numeroID))
	
	Si filaProductoEncontrado = -1
		Escribir "Producto no encontrado"
	SiNo
		Escribir "Ingrese una opción: 1-Editar nombre 2-Editar stock 3-Editar precio"
		Repetir
			Leer opcionMenu
			Si opcionMenu<1 o opcionMenu>3 Entonces
				Escribir "Opción no válida, intente nuevamente."
			FinSi
		Hasta Que opcionMenu>0 y opcionMenu<4
		
		Segun opcionMenu Hacer
			1:
				Escribir "Ingrese el nuevo nombre del producto"
				Leer nuevoNombre
				productosCargados[filaProductoEncontrado,1]<-nuevoNombre
			2:
				Escribir "Ingrese el nuevo stock del producto"
				Leer nuevoStock
				productosCargados[filaProductoEncontrado,2]<-ConvertirATexto(nuevoStock)
			3:
				Escribir "Ingrese el nuevo precio del producto"
				Repetir
					Leer nuevoPrecio	
					Si nuevoPrecio<0 Entonces
						Escribir "El precio debe ser mayor a 0, ingrese nuevamente:"
					FinSi
				Hasta Que nuevoPrecio>0
				productosCargados[filaProductoEncontrado,3]<-ConvertirATexto(nuevoPrecio)
		Fin Segun
		
	FinSi
	
	
	
FinSubProceso

//Funcion para buscar  el índice donde se encuentra un producto en el array 
Funcion return<- buscarProducto(array,n,columnaAbuscar,elementoABuscar)
	Definir i Como Entero;
	i<-0;
	elementoEncontrado <- Falso;
	Mientras i <= n-1 y no elementoEncontrado
		si array[i,columnaAbuscar] == elementoABuscar Entonces
			elementoEncontrado <- Verdadero;
		SiNo
			i <- i +1; 
		FinSi
	FinMientras
	Si elementoEncontrado Entonces
		return <- i;
	SiNo
		return <- -1;
	FinSi
FinFuncion
	