class Golosina{
    var property precio 
    var property sabor 
    var property peso 
    var property gluten
    method contieneGluten(){
        return gluten
    }

    method darMordisco(){}
}

class Bombon inherits Golosina(precio = 5, sabor = frutilla, peso = 15, gluten = false) {
    override method darMordisco() {
        peso -= self.peso() * 0.2 + 1 
    }
}

class BombonDuro inherits Bombon {
    override method darMordisco(){
        peso *= 0.9
    }
}

class Alfajor inherits Golosina(precio = 12, sabor = chocolate, peso = 300, gluten = true) {
    override method darMordisco() {
        peso -= self.peso() * 0.2
    }
}

class Caramelo inherits Golosina(precio = 1, peso = 5, gluten = false){
    override method darMordisco() {  
         if (!sabor.saborCarameloValido()){
            throw new UserException(message = "Sabor de caramelo inválido")
        } else {
            peso -= 1
        }
    }

    override method sabor(){
        if (!sabor.saborCarameloValido()){
            throw new UserException(message = "Sabor de caramelo inválido")
        } else {
            return sabor
        }
    }  
}

class CarameloRelleno inherits Caramelo() {
    override method darMordisco(){
        super()
        self.sabor(chocolate)
    }
}

class Chupetin inherits Golosina(precio = 2, sabor = naranja, peso = 7, gluten = false){
    override method darMordisco() {
        if (peso >= 2){
            peso -= self.peso() * 0.1
        }
    }
}

class Oblea inherits Golosina(precio = 5, sabor = vainilla, peso = 250, gluten = true){
    override method darMordisco() {
        if (self.peso() >= 70) {
            peso /= 2
        } else {
            peso *= 0.75
        }
    }
}

class ObleaCrujiente inherits Oblea() {
    const crujiente = new Crujiente()
    override method darMordisco() {
        super()
        peso -= crujiente.darMordisco()
    }
}

class Crujiente{
    var peso_adicional_perdido = 0          //Peso adicional que se pierde porque es crujiente
    method darMordisco(){
        if (peso_adicional_perdido < 9){    //Si se mordió más de tres veces, no se pierde peso adicional
            peso_adicional_perdido += 3
            return 3
        } else {
            return 0
        }
        
    }
}

class Chocolatin inherits Golosina(sabor = chocolate, gluten = true, precio = peso * 0.5){
    override method darMordisco() {
        peso -= 2
    }
}

class ChocolatinVip inherits Chocolatin(){
    const humedad

    override method peso(){
        return super() * (1 + humedad)
    }
}

class ChocolatinPremium inherits ChocolatinVip(){
    override method peso(){
        return super() / 2
    }
}

class Banada inherits Golosina(){
    var property base
    var property banio = 0
    override method precio() = base.precio() + 2
    override method contieneGluten() = self.base().contieneGluten()

    override method darMordisco() {
        self.base().darMordisco()
        self.banio().darMordisco()
    }

    method banar(golosina){
        base = golosina
        sabor = self.base().sabor()
        peso = self.base().peso() + 4 
        precio = self.base().precio() + 2
        banio = new Banado()
    }

    override method sabor() = base.sabor()
    override method peso(){
        return base.peso() + self.banio().peso()
    }
}

class Banado{
    var property peso = 4
    method darMordisco(){
        if (peso > 0){
            peso -= 2
        }
    }
}

class Pastilla inherits Golosina(sabor = frutilla, peso = 5, precio = if (self.contieneGluten()) 10 else 7){ 
    override method darMordisco(){
        sabor = (self.sabor().pastillaSiguiente())
    }
}

object frutilla{
    method pastillaSiguiente() = chocolate
    method saborCarameloValido() = true
}
object chocolate{
    method pastillaSiguiente() = naranja
    method saborCarameloValido() = true
}
object naranja{
    method pastillaSiguiente() = frutilla
    method saborCarameloValido() = true
}
object vainilla{
    method saborCarameloValido() = false
}

object melon{
    method saborCarameloValido() = false
}

object mariano {
    const golosinas_compradas = []
    method golosinasCompradas() = golosinas_compradas
    method comprar(golosina){ golosinas_compradas.add(golosina)} 
    method desechar(golosina){ golosinas_compradas.remove(golosina)}
    method probarGolosinas(){ golosinas_compradas.forEach{golosina => golosina.darMordisco()}}
    method hayGolosinaSinTACC() = golosinas_compradas.any({golosina => !golosina.contieneGluten()})
    method preciosCuidados() = golosinas_compradas.all({golosina => golosina.precio() <= 10})
    method golosinaDeSabor(sabor) = golosinas_compradas.find{golosina => golosina.sabor() == sabor}
    method golosinasDeSabor(sabor) = golosinas_compradas.filter({golosina => golosina.sabor() == sabor})
    method sabores() = golosinas_compradas.map{golosina => golosina.sabor()}.asSet()
    method golosinaMasCara() = golosinas_compradas.max{golosina => golosina.precio()} 
    method pesoGolosinas() = golosinas_compradas.sum{golosina => golosina.peso()}

    method golosinasFaltantes(golosinas_deseadas) = golosinas_deseadas.filter({golosina => !golosinas_compradas.contains(golosina)})
    method gustosFaltantes(gustos_deseados) = gustos_deseados.filter({gusto => !self.sabores().contains(gusto)})

    method baniar(golosina){
        //VER EN CLASE
    }
}

class UserException inherits Exception {}