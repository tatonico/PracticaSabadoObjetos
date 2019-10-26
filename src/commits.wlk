class Commit {
	var property autor
	var property cambios = {}
	var property descripcion
	
	method aplicarCambios(carpeta){
		cambios.foreach{cambio => cambio.aplicarseEn(carpeta)}
	}
	
	method afectaAlArchivo(archivo){
		return cambios.any{cambio => cambio.afectaAlArchivo(archivo)}
	}
	method informarAutor(persona){
		autor = persona
	}
	method cambiarDescripcion(nueva){
		descripcion = nueva
	}
	method establecerCambiosReversos(){
		cambios.foreach{cambio=>cambio.obtenerReverso()}.reverse()
	}
}

class Cambio{
	var property nombreArchivo
	
	method aplicarseEn(carpeta)
	method obtenerReverso()
	
	method afectaAlArchivo(archivo){
		return nombreArchivo.equals(archivo)
	}
}

class Crear inherits Cambio{
	constructor (_nombre){
		nombreArchivo = _nombre
	}
	override method aplicarseEn(carpeta){
		if(carpeta.contieneArchivo(nombreArchivo).negate()){
			carpeta.crear(nombreArchivo)
		}else{
			throw new Exception(message="No existe archivo")
		}
	}
	override method obtenerReverso(){
		return new Eliminar(nombreArchivo)
	}
}

class Eliminar inherits Cambio{
	constructor (_nombre){
		nombreArchivo = _nombre
	}
	override method aplicarseEn(carpeta){
		if(carpeta.contieneArchivo(nombreArchivo)){
			carpeta.eliminar(nombreArchivo)
		}else{
			throw new Exception(message="No existe archivo")
		}
	}
	override method obtenerReverso(){
		return new Crear(nombreArchivo)
	}
}
class Agregar inherits Cambio{
	var property texto
	constructor (_nombre, _texto){
		nombreArchivo = _nombre
		texto = _texto
	}
	
	override method aplicarseEn(carpeta){
		if(carpeta.contieneArchivo(nombreArchivo)){
			carpeta.agregarTextoA(nombreArchivo, texto)
		}else{
			throw new Exception(message="No existe archivo")
		}
	}
	override method obtenerReverso(){
		return new Sacar(nombreArchivo, texto)
	}
}

class Sacar inherits Agregar{
	constructor (_nombre, _texto){
		nombreArchivo = _nombre
		texto = _texto
	}
	override method aplicarseEn(carpeta){
		if(carpeta.contieneArchivo(nombreArchivo)){
			carpeta.borrarTexto(nombreArchivo, texto)
		}else{
			throw new Exception(message="No existe archivo")
		}
	}
	override method obtenerReverso(){
		return new Agregar(nombreArchivo, texto)
	}
}
