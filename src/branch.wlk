class Branch {
	var property listaCommits
	var property colaboradores
	var property autor
	
	constructor(creador, _colaboradores){
		colaboradores = _colaboradores
		autor = creador
	}
	
	method checkout(carpeta){
		listaCommits.map{commit => commit.aplicarCambios(carpeta)}
	}
	method log(archivo){
		listaCommits.filter{commit => commit.afectaAlArchivo(archivo)}
	}	
	method personaPuedeCommitear(persona){
		return autor == persona || colaboradores.contains(persona) || persona.esAdmin() 
	}
	method blame(archivo){
		(listaCommits.filter{commit => commit.afectaAlArchivo(archivo)}).map{commit => commit.autor()}
	}
}
