class Archivo{
	var property nombre
	var property contenido
	
	constructor(_nombre, _contenido){
		nombre = _nombre
		contenido = _contenido
	}
	method agregarAContenido(texto){
		contenido = contenido + texto
	}
	method terminaCon(texto){
		return contenido.endsWith(texto)
	}
	method eliminarUltimosNCaracteres(num){
		contenido = contenido.reverse().drop(num).reverse()
	}
}

class Carpeta{
	var property nombre
	var property archivos = {}
	
	method contieneArchivo(nombreArchivo){
		return archivos.any{archivo => archivo.nombre().equals(nombreArchivo)}
	}
	
	method crear(nombreArchivo){
		var nuevoArchivo = new Archivo(nombreArchivo, "")
		archivos.add(nuevoArchivo)
	}
	
	method eliminar(nombreArchivo){
		archivos.remove(self.encontrarArchivoConNombre(nombreArchivo))
	}
	
	method agregar(nombreArchivo,textoAAgregar){
		self.encontrarArchivoConNombre(nombreArchivo).agregarAContenido(textoAAgregar)
	}
	
	method borrarTexto(nombreArchivo,textoAAgregar){
		var archivo = self.encontrarArchivoConNombre(nombreArchivo)
		if(archivo.terminaCon(textoAAgregar)){
			archivo.eliminarUltimosNCaracteres(textoAAgregar.size())
		}
		self.encontrarArchivoConNombre(nombreArchivo).agregarAContenido(textoAAgregar)
	}
	
	method encontrarArchivoConNombre(nombreArchivo){
		return archivos.find{archivo=>archivo.nombre().equals(nombreArchivo)}
	}
}

