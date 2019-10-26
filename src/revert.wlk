class Revert {
	var property commit
	
	method obtenerRevert(){
		commit.descripcion(commit.descripcion() + "revert")
		commit.cambios().map{cambio=>cambio.obtenerReverso()}.reverse()
}
