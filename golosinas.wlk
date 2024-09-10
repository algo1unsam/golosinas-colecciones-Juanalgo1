object bombon {
    var property precio = 5
    var property sabor = frutilla
    var property peso = 15
    method contieneGluten() = false

    method darMordisco() {
        peso -= self.peso() * 0.2 + 1 
    }
}

object alfajor {
    var property precio = 12
    var property sabor = chocolate
    var property peso = 300
    method contieneGluten() = true
 
    method darMordisco() {
        peso -= self.peso() * 0.2
    }
}

object caramelo {
    var property precio = 1
    var property sabor = frutilla
    var property peso = 5
    method contieneGluten() = false

    method darMordisco() {
        peso -= 1
    }
}

object chupetin {
    var property precio = 2
    var property sabor = naranja
    var property peso = 7
    method contieneGluten() = false
 
    method darMordisco() {
        if (peso >= 2){
            peso -= self.peso() * 0.1
        }
    }
}

object oblea {
    var property precio = 5
    var property sabor = vainilla
    var property peso = 250
    method contieneGluten() = true
 
    method darMordisco() {
        if (self.peso() >= 70) {
            peso /= 2
        } else {
            peso *= 0.75
        }
    }
}

object chocolatin {
    var property sabor = chocolate
    var peso = 0
    var peso_inicial = 0
    var property precio = 0

    method peso() = peso
    method peso(valor) {
        peso = valor
        peso_inicial = valor
        precio = valor * 0.5
    }

    method contieneGluten() = true
 
    method darMordisco() {
        peso -= 2
    }
}

object banada {
    var property base = 0
    var sabor = 0
    var peso = 0
    var property precio = 0
    method contieneGluten() = self.base().contieneGluten()

    method sabor() = base.sabor()
    method peso(){
        if (mordiscos == 0){
            return self.base().peso() + 4
        } else if (mordiscos == 1){
            return self.base().peso() + 2
        } else {
            return self.base().peso()
        }

    }
 
    method banar(golosina){
        base = golosina
        sabor = self.base().sabor()
        peso = self.base().peso() + 4 
        precio = self.base().precio() + 2
    }

    var property mordiscos = 0

    method darMordisco() {
        mordiscos += 1
        self.base().darMordisco()
        if (mordiscos <= 2){
            peso -= 2
        }
    }
}

object pastilla {
    var property sabor = frutilla
    var property peso = 5
    var gluten = true
    method contieneGluten() = self.gluten()
    var property precio = 0

    method gluten(valor){
        gluten = valor
        if (valor){
            precio = 10
        } else {
            precio = 7
        }
    }
    method gluten() = gluten

 
    method darMordisco(){
        sabor = self.sabor().pastillaSiguiente()
    }
}

object frutilla{
    method pastillaSiguiente() = chocolate
}
object chocolate{
    method pastillaSiguiente() = naranja
}
object naranja{
    method pastillaSiguiente() = frutilla
}
object vainilla{}
/*
object mariano {
    const golosinas_compradas = []
    method comprar(golosina){ golosinas_compradas.add(golosina)} 
    method desechar(golosina){ golosinas_compradas.remove(golosina)}
    method probarGolosinas(){ golosinas_compradas.forEach{golosina => golosina.darMordisco()}}
    method hayGolosinaSinTACC() = golosinas_compradas.any({golosina => !golosina.contieneGluten()})
    method preciosCuidados() = golosinas_compradas.all({golosina => golosina.precio() <= 10})
* `golosinaDeSabor(unSabor)` : devuelve _la primer golosina_ que encuentra en la bolsa del sabor escogido.
* `golosinasDeSabor(unSabor)` : devuelve _las golosinas_ que encuentre dentro de la bolsa del sabor escogido.
* `sabores()` : que devuelve los sabores de las golosinas de la bolsa, idealmente sin repetidos. <br> 
  P.ej. aunque Mariano tenga tres golosinas de sabor naranja, en lo que devuelve `sabores()` el naranja debería aparecer una sola vez. <br> Una forma de resolver esto es usando **conjuntos**; revolver en el apunte sobre colecciones y closures: [https://objetos1wollokunq.gitlab.io/material/guia-colecciones-basicas.pdf](https://objetos1wollokunq.gitlab.io/material/guia-colecciones-basicas.pdf).
* `golosinaMasCara()` : devuelve la golosina mas cara en la bolsa de golosinas compradas.
* `pesoGolosinas()` : devuelve el peso de la bolsa de golosinas compradas, o sea, la suma del peso de cada golosina. 
}*/