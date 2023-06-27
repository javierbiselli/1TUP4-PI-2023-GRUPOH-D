Algoritmo sistema_gestion
	Definir usuarios Como Caracter
	Dimension usuarios(100, 2) // array de usuarios registrados, maxima cantidad de usuarios: 100
	Definir cantidadUsuarios como Entero
	Definir opcionSeleccionada Como Entero
	Definir productosCargados como Cadena
	Definir idProducto, filas, cantidadProductosCargados Como Entero
	//DEFINO ARRAY PARA ALMACENAR LOS DATOS CARGADOS POR USUARIO LUEGO DEL LOGIN. FILAS: 100 (PRODUCTOS), COLUMNAS: 4 (1.ID 2.NOMBRE PRODUCTO 3.STOCK 4.PRECIO)
	
	filas <- 100
	cantidadProductosCargados <- 0
	
	Dimension productosCargados[filas,4] 
	idProducto<-0	
	
	// usuario de prueba
	usuarios(0, 0) <- "usertest"
	usuarios(0, 1) <- "pass123"
	cantidadUsuarios <- 1 // esta variable se usa en la funcion logIn y register como index de las filas en el array de usuarios, se le suma 1 por cada nuevo usuario
	
	Escribir "Bienvenido al sistema de gestion"
	Escribir ""
	
	Repetir
		opcionSeleccionada <- welcomeMenu()
		
		Segun opcionSeleccionada Hacer
			1:
				Si logIn(usuarios, cantidadUsuarios) Entonces
					Repetir
						opcionSeleccionada <- menuOpciones()
						Segun opcionSeleccionada Hacer
							1:
								cargaProductos(productosCargados,idProducto, cantidadProductosCargados)
							2:
								//ver inventario --- tipos de vistas con ordenamiento
							3:
								buscarProductoNombre(productosCargados, filas, cantidadProductosCargados)
							4:	
								editarProducto(productosCargados, filas, cantidadProductosCargados)
							5:
								borrarProducto(productosCargados, filas, cantidadProductosCargados)
						Fin Segun
					Hasta Que opcionSeleccionada = 6
				FinSi
			2:
				Si register(usuarios, cantidadUsuarios) Entonces
					Escribir ""
					Escribir "Ya puede loguearse"
					Escribir ""
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
			Escribir ""
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
		Escribir ""
		return <- Verdadero
	SiNo
		Escribir "Error en el registro"
		Escribir ""
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
	
	Escribir ""
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
Subproceso cargaProductos(productosCargados Por Referencia, idProducto Por Referencia, cantidadProductosCargados Por Referencia)
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
		
		Escribir "Ingrese el precio del producto:"
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
		
		idProducto <- idProducto + 1
		cantidadProductosCargados <- cantidadProductosCargados + 1
		
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
	
	Escribir ""
	Escribir "Ingrese una opción:"
	Escribir "1- Agregar productos"
	Escribir "2- Ver inventario"
	Escribir "3- Buscar producto"
	Escribir "4- Editar producto"
	Escribir "5- Borrar producto"
	Escribir "6- Cerrar sesion"
	
	Repetir	
		Leer return
		Si return < 1 o return > 6 Entonces
			Escribir "Ingrese una opción correcta"
			Escribir ""
		FinSi
	Mientras que return < 1 o return > 6
FinFuncion


//Subproceso editar producto (nombre, stock o precio)
Subproceso editarProducto(productosCargados Por Referencia, filas Por Referencia, cantidadProductosCargados Por Referencia)
	Si cantidadProductosCargados == 0 Entonces
		Escribir "No hay productos cargados en el sistema"
	SiNo
		Definir  nuevoNombre como Cadena
		Definir numeroId, filaProductoEncontrado, opcionMenu, nuevoStock, nuevoPrecio Como Entero
		
		Repetir
			Escribir "Ingrese el código ID del producto que desea editar"
			Leer numeroId
			Si numeroId<0 Entonces
				Escribir "El ID debe ser mayor o igual a 0"
				Escribir ""
			FinSi
		Mientras Que numeroId <0
		
		filaProductoEncontrado<- buscarIndiceProducto(productosCargados,filas,0,ConvertirATexto(numeroID))
		
		Si filaProductoEncontrado = -1
			Escribir "Producto no encontrado"
			Escribir ""
		SiNo
			Escribir ""
			Escribir "Nombre: " productosCargados[filaProductoEncontrado, 1]
			Escribir "Stock: " productosCargados[filaProductoEncontrado, 2]
			Escribir "Precio: " productosCargados[filaProductoEncontrado, 3]
			Escribir ""
			Escribir "Ingrese una opción: 1-Editar nombre 2-Editar stock 3-Editar precio 4-Volver atras"
			
			Repetir
				Leer opcionMenu
				Si opcionMenu<1 o opcionMenu>4 Entonces
					Escribir "Opción no válida, intente nuevamente."
				FinSi
			Hasta Que opcionMenu>0 y opcionMenu<5
			
			Segun opcionMenu Hacer
				1:	
					Escribir "Nombre actual: " 	productosCargados[filaProductoEncontrado,1]	
					Escribir "Ingrese el nuevo nombre del producto:"
					Leer nuevoNombre
					productosCargados[filaProductoEncontrado,1]<-nuevoNombre
				2:	
					Escribir "Stock actual: " productosCargados[filaProductoEncontrado,2]
					Escribir "Ingrese el nuevo stock del producto:"
					Leer nuevoStock
					productosCargados[filaProductoEncontrado,2]<-ConvertirATexto(nuevoStock)
				3:	
					Escribir "Precio actual: " productosCargados[filaProductoEncontrado,3]
					Escribir "Ingrese el nuevo precio del producto:"
					Repetir
						Leer nuevoPrecio	
						Si nuevoPrecio<0 Entonces
							Escribir "El precio debe ser mayor a 0, ingrese nuevamente:"
						FinSi
					Hasta Que nuevoPrecio>0
					productosCargados[filaProductoEncontrado,3]<-ConvertirATexto(nuevoPrecio)
				4: 
					Escribir "Volviendo..."
			Fin Segun
		FinSi
		
	FinSi
FinSubProceso


// Funcion para buscar el índice donde se encuentra un producto en el array 
Funcion return <- buscarIndiceProducto(array, n, columnaAbuscar, elementoABuscar)
	Definir i, return Como Entero;
	Definir elementoEncontrado Como Logico
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


// busca un producto por nombre y da opciones de editar y borrar
SubProceso buscarProductoNombre(productosCargados Por Referencia, filas Por Referencia, cantidadProductosCargados Por Referencia)
	Si cantidadProductosCargados == 0 Entonces
		Escribir "No hay productos cargados en el sistema"
	SiNo
		Definir nombre Como Caracter
		Definir opcionMenu Como Entero
		
		Escribir "Ingrese el nombre del producto que desea buscar"
		Leer nombre
		
		filaProductoEncontrado <- buscarIndiceProducto(productosCargados, filas, 1, nombre)
		
		Si filaProductoEncontrado = -1
			Escribir "Producto no encontrado"
		SiNo
			Escribir ""
			Escribir "ID: " productosCargados[filaProductoEncontrado, 0]
			Escribir "Nombre: " productosCargados[filaProductoEncontrado, 1]
			Escribir "Stock: " productosCargados[filaProductoEncontrado, 2]
			Escribir "Precio: " productosCargados[filaProductoEncontrado, 3]
			
			Escribir ""
			Escribir "Ingrese una opción: 1-Editar producto 2-Borrar producto 3-Volver atras"
			
			Repetir
				Leer opcionMenu
				Si opcionMenu<1 o opcionMenu>3 Entonces
					Escribir "Opción no válida, intente nuevamente."
				FinSi
			Hasta Que opcionMenu>0 y opcionMenu<4
			
			Segun opcionMenu Hacer
				1:	
					editarProducto(productosCargados, filas, cantidadProductosCargados)
				2:	
					borrarProducto(productosCargados, filas, cantidadProductosCargados)
				3:	
					Escribir "Volviendo..."
			Fin Segun
		FinSi
		
	FinSi
FinSubProceso

Subproceso borrarProducto(productosCargados Por Referencia, filas Por Referencia, cantidadProductosCargados Por Referencia)
	Si cantidadProductosCargados == 0 Entonces
		Escribir "No hay productos cargados en el sistema"
	SiNo
		Definir numeroID, confirmacion Como Entero
		
		Repetir
			Escribir "Ingrese el código ID del producto que desea borrar"
			Leer numeroID
			Si numeroId < 0 Entonces
				Escribir "El ID debe ser mayor o igual a 0"
				Escribir ""
			FinSi
		Mientras Que numeroId < 0
		
		filaProductoEncontrado <- buscarIndiceProducto(productosCargados,filas,0,ConvertirATexto(numeroID))
		
		Si filaProductoEncontrado = -1
			Escribir "Producto no encontrado"
		SiNo
			Escribir ""
			Escribir "Nombre: " productosCargados[filaProductoEncontrado, 1]
			Escribir "Stock: " productosCargados[filaProductoEncontrado, 2]
			Escribir "Precio: " productosCargados[filaProductoEncontrado, 3]
			Escribir ""
			
			Repetir
				Escribir "Ingrese 1 si esta seguro de que desea borrar " productosCargados[filaProductoEncontrado, 1]
				Escribir "Ingrese 0 para cancelar la operacion"
				Leer confirmacion
				Si confirmacion <> 0 y confirmacion <> 1 Entonces
					Escribir "Opción no válida, intente nuevamente."
				FinSi
			Mientras que confirmacion <> 0 y confirmacion <> 1
			
			Definir i, j Como Entero
			Si confirmacion == 1 Entonces
				Para i <- filaProductoEncontrado Hasta filas-2 Hacer
					Para j <- 0 Hasta 3 Hacer
						productosCargados[i, j] <- productosCargados[i+1, j] // sube una fila al elemento hasta llegar a la ultima
					FinPara
				FinPara
				filas <- filas - 1 // elimina la ultima fila
				Escribir "Producto eliminado con exito"
				cantidadProductosCargados <- cantidadProductosCargados - 1
				filas <- filas + 1 // vuelvo a sumar 1 a las filas para no perder el espacio (hay que ver si esto funciona bien cuando hagamos lo de ver inventario)
			SiNo
				Escribir "Operacion cancelada"
			FinSi
		FinSi
		
	FinSi
FinSubProceso
