/* Los sabores */
object frutilla { }
object chocolate { }
object vainilla { }
object naranja { }
object limon { }


/* Golosinas */
class Bombon {
	var peso = 15
	
	method precio() = 5 
	method peso() = peso 
	method mordisco() { peso = peso * 0.8 - 1 }
	method sabor() = frutilla 
	method libreGluten() = true 
}

class BombomDuro inherits Bombon{

	override method mordisco() { peso = peso  - 1 }
	method gradoDeDureza() {
		if (peso > 12){
			return 3 
		}else if (peso.between(8, 12)){
			return 2 
		}else{
			return 1
		} 
	}
}

class Alfajor {
	var peso = 15
	
	method precio() = 12 
	method peso() = peso 
	method mordisco() { peso = peso * 0.8 }
	method sabor() = chocolate 
	method libreGluten() = false 
}

class Caramelo {
	var peso = 5
	var property sabor = frutilla

	method precio() = 12 
	method peso() = peso 
	method mordisco() { peso = peso - 1 }
	method sabor() = frutilla 
	method libreGluten() = true 
}

class CarameloCorazonChoco inherits Caramelo{
	override method mordisco() {
		super()
		self.sabor(chocolate)
	}
	override method precio () = super() + 1  /// super me va a dar el resultado del metodo precio de Caramelo
	
}


class Chupetin {
	var peso = 7
	
	method precio() = 2 
	method peso() = peso 
	method mordisco() { 
		if (peso >= 2) {
			peso = peso * 0.9
		}
	}
	method sabor() = naranja 
	method libreGluten() = true 
}

class Oblea {
	var peso = 250
	
	method precio() = 5 
	method peso() = peso 
	method mordisco() {
		if (peso >= 70) {
			// el peso pasa a ser la mitad
			peso = peso * 0.5
		} else { 
			// pierde el 25% del peso
			peso = peso - (peso * 0.25)
		}
	}	
	method sabor() = vainilla 
	method libreGluten() = false 
}

class ObleaCrujiente inherits Oblea{
	var cantMordiscos =  0
	override method mordisco() {
	  	super()
		cantMordiscos += 1
		if (cantMordiscos <= 3){
			peso = peso - 3 
		}  
	}
	method estaDebil() = cantMordiscos > 3
	
}
class Chocolatin {
	// hay que acordarse de *dos* cosas, el peso inicial y el peso actual
	// el precio se calcula a partir del precio inicial
	// el mordisco afecta al peso actual
	var pesoInicial
	var comido = 0
	
	method pesoInicial(unPeso) { 
		pesoInicial = unPeso 
		}
	method precio() = pesoInicial * 0.50 
	method peso() { return (pesoInicial - comido).max(0) }
	method mordisco() { comido = comido + 2 }
	method sabor() = chocolate 
	method libreGluten() = false 
}

object heladera {
	var property humedad = 0
}
class ChocolatinesVip inherits Chocolatin{
	override method peso() = super() * (1 + self.humedad())
	method humedad() = heladera.humedad() // hago una especie de subtarea para poder modificarlo en la otra class
}
class ChocolatinesPremium inherits ChocolatinesVip{
	override method humedad() = super() / 2  // hago override solo sobre el pedazo que necesito que sea distinto
}
class GolosinaBaniada {
	var golosinaInterior
	var pesoBanio = 4
	
	method golosinaInterior(unaGolosina) { golosinaInterior = unaGolosina }
	method precio() { return golosinaInterior.precio() + 2 }
	method peso() { return golosinaInterior.peso() + pesoBanio }
	method mordisco() {
		golosinaInterior.mordisco()
		pesoBanio = (pesoBanio - 2).max(0) 
	}	
	method sabor() { return golosinaInterior.sabor() }
	method libreGluten() { return golosinaInterior.libreGluten() }	
}


class Tuttifrutti {
	var libreDeGluten
	const sabores = [frutilla, chocolate, naranja]
	var saborActual = 0
	
	method mordisco() { saborActual += 1 }	
	method sabor() { return sabores.get(saborActual % 3) }	

	method precio() { return (if(self.libreGluten()) 7 else 10) }
	method peso() { return 5 }
	method libreGluten() { return libreDeGluten }	
	method libreGluten(valor) { libreDeGluten = valor }
}