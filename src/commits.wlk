class Commit {
	var property autor
	var property cambios = {}
	var property descripcion
	
	method aplicarCambios(carpeta){
		cambios.map{cambio => cambio.aplicarseEn(carpeta)}
	}
	
	method afectaAlArchivo(archivo){
		cambios.any{cambio => cambio.afectaAlArchivo(archivo)}
	}
	method informarAutor(persona){
		autor = persona
	}
}

class Cambio{
	var property nombreArchivo
	
	method aplicarseEn(carpeta)
	method obtenerReverso()
	
	method afectaAlArchivo(archivo){
		nombreArchivo.equals(archivo)
	}
}

class Crear inherits Cambio{
	constructor (_nombre){
		nombreArchivo = _nombre
	}
	override method aplicarseEn(carpeta){
		if(carpeta.contieneArchivo(nombreArchivo).negate()){
			carpeta.crear(nombreArchivo)
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
			carpeta.agregar(nombreArchivo, texto)
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
