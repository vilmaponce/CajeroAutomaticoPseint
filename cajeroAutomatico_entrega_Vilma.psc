Proceso cajeroAutomatico
	//Version final
	//definir variables
	Definir usuarios, usuario, claves, clave, eleccionTexto  Como cadena;
	Definir n, n2, eleccionNumero Como Entero;
	Definir saldos Como Real;
	//arrays
	Dimension usuarios[5], claves[5], saldos[5];
	
	//asignar valores de base a las variables de usuarios, claves y saldos 
	inicializarCajero(usuarios, claves, saldos);
	
	Repetir
		Escribir "BANCO ARGENTINO";
		Escribir "";
		Escribir "Por favor, ingrese su tarjeta";
		Escribir "Usuario:";
		Leer usuario;
		iniciarSesion(usuarios, usuario, n); //para comprobar si coincide con algun nombre de usuario, si no coincide le pide que ingrese de nuevo, si coincide se guarda el índice en n, sigue y le pide la clave
		Escribir "Clave:";
		Leer clave;
		mientras clave<>claves[n] Hacer //no llama al subproceso de iniciar sesion, solamente comprueba si coincide con el índice n del usuario que ya se autenticó
			Escribir "Clave incorrecta. Inténtelo nuevamente.";
			leer clave;
		FinMientras
		Escribir "";
		Escribir "BIENVENIDO, ", usuario;
		
		Repetir //para que una vez que termine de realizar una acción vuelva a preguntarle qué quiere hacer, hasta que elija salir del sistema o apagar el cajero
			Escribir "¿Qué desea hacer ", usuario,"?";
			
			Escribir "1 - Consultar saldo";
			Escribir "2 - Retirar";
			Escribir "3 - Depositar";
			Escribir "4 - Transferir";
			Escribir "5 - Salir del sistema";
			Escribir "0 - Apagar";
			Escribir "";
			
			leer eleccionTexto; //es cadena para que no se rompa el programa si ingresa algo que no sea un número
			
			mientras eleccionTexto <> "0" y eleccionTexto <> "1" y eleccionTexto <> "2" y eleccionTexto <> "3" y eleccionTexto <> "4" y eleccionTexto <> "5" Hacer
				//comprueba si el valor ingresado es diferente a todos los números de tipo cadena entre 0 y 5, si es diferente a todos entra al mientras y le pide ingresar otro valor, si es igual a alguno no entra al mientras
				Escribir "La opción ingresada es inválida. Ingrese una opción correcta.";
				leer eleccionTexto;
			FinMientras
			
			//una vez que ingresa un valor que coincide con la condición no entra al mientras y convierte ese valor en tipo número
			eleccionNumero<-ConvertirANumero(eleccionTexto);
			
			Segun eleccionNumero Hacer
				1: 
					consultaSaldo(saldos, usuario, n);
				2: 
					retirarSaldo(saldos, n);
				3: 
					depositarSaldo(saldos, n);
				4: 
					n2<-0; //inicializa la variable de índice de la cuenta a transferir
					transferirSaldo(usuarios, saldos, n, n2);
			FinSegun
		Hasta Que eleccionNumero == 5 o eleccionNumero == 0; 
		
		si eleccionNumero == 5 Entonces
			Escribir "Por favor, retire su tarjeta";
			esperarLimpiar;
		SiNo
			Escribir "¡Gracias por utilizar nuestros servicios!";
		FinSi
		
	Hasta Que eleccionNumero==0;

FinProceso

//PROCEDIMIENTO
SubProceso inicializarCajero(usuarios Por Referencia, claves Por Referencia, saldos Por Referencia)
	usuarios[0] <- "fede";
	claves[0] <- "1234";
	saldos[0] <- 4000;

	usuarios[1] <- "lau";
	claves[1] <- "6412";
	saldos[1] <- 36000;
	
	usuarios[2] <- "paul";
	claves[2] <- "3345";
	saldos[2] <- 13500;
	
	usuarios[3] <- "sofi";
	claves[3] <- "2350";
	saldos[3] <- 7700;
	
	usuarios[4] <- "marce87";
	claves[4] <- "5675";
	saldos[4] <- 28000;	
FinSubProceso

//PROCEDIMIENTO
/// PUNTO 1 - Escriba su c?digo dentro de este SubProceso 
SubProceso iniciarSesion(asignado, ingresado Por Referencia, n Por Referencia)
	
	Repetir
		n<-0; //si se repite vuelve a contar desde 0
		mientras ingresado<>asignado[n] y n<4 Hacer //si el valor ingresado es diferente al valor asignado en el índice n, y n vale entre 0 y 3 entra al mientras
			n<-n + 1; // se incrementa el valor de n hasta que vale 4, cuando vale 4 no entra al mientras
		FinMientras
		// no puede ser mientras n<5 o n<=4 porque:
		// si n==4 puede entrar al mientras
		// n se incrementa en 1 y pasa a valer 5
		// pregunta si ingresado <> asignado [5] y da error porque asignado[5] no existe
		si ingresado<>asignado[n] entonces //entra si el valor ingresado no coincide con el valor guardado en el índice 4
			Escribir "Usuario no encontrado. Inténtelo nuevamente.";
			leer ingresado; //pide otro valor, por eso es por referencia
			// no hacemos n<-0 porque si el ingresado de arriba coincidiera con asignado [4] ya podría salir del repetir sin volver a hacer todo el proceso
		FinSi
	Hasta Que ingresado==asignado[n]; //si ingresado es igual a asignado [4] sale del repetir, sino vuelve a repetirse
	
FinSubProceso

//PROCEDIMIENTO
/// PUNTO 2 - Escriba su c?digo dentro de este SubProceso 
SubProceso consultaSaldo(saldos Por Referencia, usuario, n) 
	
	si saldos[n]>0 Entonces
		Escribir usuario, " su saldo es de $", saldos[n];
	SiNo
		Escribir usuario, ", no tiene fondos en su cuenta";
	FinSi
	
	Escribir "";
	
	esperarLimpiar;
FinSubProceso

//PROCEDIMIENTO
/// PUNTO 3 - Escriba su c?digo dentro de este SubProceso
SubProceso retirarSaldo(saldos Por Referencia, n)
	
	Definir retiraTexto, respuestaCadena como cadena;
	Definir retiraNumero Como Real;
	Definir respuestaNumero Como Entero;
	
	si saldos[n]>0 Entonces//ingresa si tiene saldo
		Escribir "Ingrese el monto a retirar";
		leer retiraTexto;//pide un valor de tipo cadena
		retiraNumero<-cadena_o_numero(retiraTexto);//funcion que pide un valor hasta que sea sí o sí un número en cadena y lo pasa a número real
		
		mientras retiraNumero>saldos[n] Hacer//entra si quiere retirar más de lo que tiene en la cuenta, y le pide ingresar otro valor
			Escribir "No tiene suficientes fondos para retirar esa cantidad de dinero. Ingrese un monto menor.";
			Leer retiraTexto; //pide un valor de tipo cadena
			retiraNumero<-cadena_o_numero(retiraTexto);//funcion que pide un valor hasta que sea sí o sí un número en cadena y lo pasa a número real
		FinMientras
		
		Escribir "Está a punto de retirar $", retiraNumero;
		
		respuestaCadena<-"";
		respuestaNumero<-continuar_o_cancelar(respuestaCadena);
		
		segun respuestaNumero Hacer
			1:
				saldos[n]<-saldos[n] - retiraNumero;
				Escribir "Su nuevo saldo es $", saldos[n];
			0:
				Escribir "Su operación se ha cancelado.";
		FinSegun
		
	SiNo
		Escribir "No tiene fondos en su cuenta."; //ingresa si no tiene saldo
	FinSi
	
	Escribir "";
	
	esperarLimpiar;
FinSubProceso

//PROCEDIMIENTO
/// PUNTO 4 - Escriba su c?digo dentro de este SubProceso
SubProceso depositarSaldo(saldos Por Referencia, n)
	
	Definir depositarNumero como real;
	Definir depositarTexto, respuestaCadena Como cadena;
	Definir respuestaNumero Como Entero;
	
	Escribir "Ingrese el monto a depositar";
	leer depositarTexto;//pide un valor de tipo cadena
	depositarNumero<-cadena_o_numero(depositarTexto);//funcion que pide un valor hasta que sea sí o sí un número en cadena y lo pasa a número real
	
	Escribir "Está a punto de depositar $", depositarNumero;
	
	respuestaCadena<-"";
	respuestaNumero<-continuar_o_cancelar(respuestaCadena);
	
	segun respuestaNumero Hacer
		1:
			saldos[n]<-saldos[n] + depositarNumero;
			Escribir "Su nuevo saldo es $", saldos[n];
		0:
			Escribir "Su operación se ha cancelado";
	FinSegun
	
	Escribir "";
	
	esperarLimpiar;
FinSubProceso

//PROCEDIMIENTO
/// PUNTO 5 - (OPTATIVO) Escriba su c?digo dentro de este SubProceso 
SubProceso transferirSaldo(usuarios, saldos Por Referencia, n, n2 Por Referencia)
	
	// n es el usuario que transfiere
	// n2 es la cuenta a la que le transfiere
	
	Definir userTransferir, montoTransferirCadena, respuestaCadena Como cadena;
	Definir montoTransferir Como Real;
	Definir respuestaNumero Como Entero;
	
	Si saldos[n]>0 Entonces //entra si tiene saldo
		
		Escribir "Ingrese la cuenta a la que desea transferirle.";
		Leer userTransferir;
		
		iniciarSesion(usuarios, userTransferir, n2); //comprueba si el nombre de usuario coincide con alguno de los usuarios guardados, sino pide otro hasta que coincida
		
		Mientras userTransferir==usuarios[n] Hacer //comprueba que el usuario no se transfiera a sí mismo
			Escribir "No puede transferirse a su propia cuenta. Ingrese una cuenta diferente";
			leer userTransferir;
			iniciarSesion(usuarios, userTransferir, n2);
		FinMientras
		
		Escribir "Ingrese el monto a transferir.";
		leer montoTransferirCadena; //pide un valor de tipo cadena
		montoTransferir<-cadena_o_numero(montoTransferirCadena); //comprueba si la cadena es de números, si no es sigue pidiendo, si es lo pasa a tipo real
		
		mientras montoTransferir>saldos[n] Hacer //entra si quiere transferir más de lo que tiene
			Escribir "No tiene suficientes fondos para transferir, ingrese un monto menor.";
			leer montoTransferirCadena; //pide monto en tipo cadena
			montoTransferir<-cadena_o_numero(montoTransferirCadena); //comprueba si la cadena es de números, si no es sigue pidiendo, si es lo pasa a tipo real
		FinMientras
		
		Escribir "Está a punto de transferir $", montoTransferir, " a la cuenta de ", userTransferir;
		
		respuestaCadena<-"";
		respuestaNumero<-continuar_o_cancelar(respuestaCadena); //convierte el valor de cadena a número
		
		segun respuestaNumero Hacer
			1:
				saldos[n]<-saldos[n] - montoTransferir;
				saldos[n2]<-saldos[n2] + montoTransferir;
				Escribir "Su transferencia se ha realizado con éxito.";
			0:
				Escribir "Su transferencia se ha cancelado.";
		FinSegun
		
	SiNo //entra si no tiene saldo
		Escribir "No tiene fondos en su cuenta.";
	FinSi
	
	Escribir "";
	
	esperarLimpiar;
FinSubProceso

//FUNCION 
SubProceso  resultado<-cadena_o_numero(textoBase)
	Definir resultado Como Real;
	Definir c Como Caracter; //c de caracter
	Definir x, contadorNum, contadorDec Como Real;
	
	contadorNum<-0; //cantidad de números
	contadorDec<-0; //cantidad de puntos decimales (.)
	x<-0; //contador
	c<-Subcadena(textoBase,x,x); //c está en el índice 0
	
	Repetir
		//el mientras sirve para que apenas ingrese un caracter que no coincida con las condiciones no entre, entre al si y pida otro valor
		//si usara un PARA tendría que pasar por todos los caracteres de la cadena sí o sí
		mientras x<Longitud(textoBase) y ((c=="0" o c=="1" o c=="2" o c=="3" o c=="4" o c=="5" o c=="6" o c=="7" o c=="8" o c=="9") o (c=="." y x>0 y x<>(Longitud(textoBase)-1))) Hacer
			//si x vale entre 0 y la longitud de la cadena - 1, y el caracter es un número, o un punto decimal que no esté en el índice 0 ni el último índice de la cadena, entra al mientras
			si c=="." Entonces // si es un punto decimal
				contadorDec<-contadorDec + 1;
			SiNo // si es un número
				contadorNum<-contadorNum + 1;
			FinSi
			x<-x+1; //aumenta contador
			c<-Subcadena(textoBase,x,x); // c cambia de índice
		FinMientras
		
		si ((contadorNum + contadorDec) <> (Longitud(textoBase))) o (contadorDec>1) Entonces
			Escribir "Valor inválido.";
			leer textoBase;
			contadorNum<-0;
			contadorDec<-0;
			x<-0;
			c<-Subcadena(textoBase,x,x); //c está en el índice 0
		FinSi
	Hasta Que ((contadorNum + contadorDec) = (Longitud(textoBase))) y (contadorDec==0 o contadorDec==1);
	//solo cuando la suma de números y puntos decimales == longitud de la cadena y haya 0 o 1 puntos decimales sale del repetir
	
	resultado<-ConvertirANumero(textoBase); //convierte la cadena a tipo real
	
FinSubProceso

//FUNCION
SubProceso respuestaNumero<-continuar_o_cancelar(respuestaCadena Por Referencia)
	Definir respuestaNumero Como Entero;
	
	Escribir "Escriba 1 si desea continuar";
	Escribir "Escriba 0 si desea cancelar la operación";
	
	leer respuestaCadena;
	
	mientras respuestaCadena <> "0" y respuestaCadena <> "1" Hacer //si respuesta de tipo cadena no es ni 0 ni 1 sigue pidiendo
		Escribir "Valor inválido";
		leer respuestaCadena;
	FinMientras
	
	respuestaNumero<-ConvertirANumero(respuestaCadena); //convierte el valor de cadena a número
	
FinSubProceso

SubProceso esperarLimpiar
	Escribir "";
	Escribir "";
	Escribir "Presione una tecla para continuar...";
	Esperar Tecla;
	Limpiar Pantalla;
FinSubProceso