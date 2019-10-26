class Autor {
	var property tipo //admin o no
	var property dni
	
	method agregarCommit(branch, commit){
		if(branch.personaPuedeCommitear(self)){
			branch.agregarCommit(commit)
		}
	}
	
	method convertirEnAdminA(conjunto){
		if(self.esAdmin()){
			conjunto.foreach{persona => persona.hacerAdmin()}
		}
	}
	
	method sacarAdminA(persona){
		if(self.esAdmin()){
			persona.noMasAdmin()
		}
	}
	
	method esAdmin(){
		return tipo.equals("admin")
	}
	method hacerAdmin(){
		tipo = "admin"
	}
	method noMasAdmin(){
		tipo = "normal"
	}
}
