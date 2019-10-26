class Branch {
	var property listaCommits
	var property colaboradores
	var property autor
	var property carpeta
	
	constructor(creador, _colaboradores){
		colaboradores = _colaboradores
		autor = creador
	}
	
	method checkout(){
		listaCommits.foreach{commit => commit.aplicarCambios(carpeta)}
	}
	method log(archivo){
		return listaCommits.filter{commit => commit.afectaAlArchivo(archivo)}
	}	
	method personaPuedeCommitear(persona){
		return autor == persona || colaboradores.contains(persona) || persona.esAdmin() 
	}
	method blame(archivo){
		//return self.log(archivo).map{commit=>commit.autor()}.asSet()
		return (listaCommits.filter{commit => commit.afectaAlArchivo(archivo)}).map{commit => commit.autor()}.asSet()
	}
	method agregarCommit(persona, commit){
		if(self.personaPuedeCommitear(autor)){
			listaCommits.add(commit)
		}
	}
}
