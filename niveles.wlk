import wollok.game.*    
import ingredientes.*
import clientes.*

// INTRO
object imagenIntro {
    method position() = game.origin()
    method image() = "fondos/Intro.png"
}

// BOTONES
object botonIntro {
    method position() = game.at(5, 1)
    method image() = "botones/boton_Intro.png"
}

object botonEnviar {
    method position() = game.at(15, 1)
    method image() = "botones/boton_enviarPedido3.png"

    method clickear(nivel) {
        nivel.enviarPedido()
    }
}

object botonSeguir {
    method position() = game.at(9, 0)
    method image() = "botones/boton_Seguir.png"

    method clickear(nivel) {
        nivel.siguienteNivel()
    }

}

object botonReintentar {
    method position() = game.at(9, 0)
    method image() = "botones/boton_Reintentar.png"
    
    method clickear(nivel) {
        nivel.reintentar() 
    }
}

object pedidoCorrecto1 {
    method position() = game.origin()
    method image() = "juegor1/Pedido_Correcto.png"
}

object pedidoFueraDeTiempo1 {
    method position() = game.origin()
    method image() = "juegor1/Pedido_SinTiempo.png"
}


object estadoIntro {
    method procesarClick(nivel, posicion){ 
        nivel.empezar() 
        }   
    method pasoUnSegundo(nivel) { }
}

object estadoJugando {
    method procesarClick(nivel, posicion) {
        nivel.clickearElemento(posicion, nivel.listaIngredientes() + [botonEnviar])
    }
    method pasoUnSegundo(nivel) { nivel.descontarTiempo() }
}

object estadoSinTiempo {
    method procesarClick(nivel, posicion) {
        nivel.clickearElemento(posicion, [botonReintentar])
    }
    method pasoUnSegundo(nivel) { }
}

object estadoCorrecto {
    method procesarClick(nivel, posicion) {
        nivel.clickearElemento(posicion, [botonSeguir])
    }
    method pasoUnSegundo(nivel) { }
}

class Nivel {
    var estado = estadoIntro
    var tiempo = 30
    const segundos = 30

    const cliente
    const property listaIngredientes
    const pedidoCorrecto
    const pedidoFueraDeTiempo

    method clickPantalla(posicion) { 
    
        estado.procesarClick(self, posicion) 
        
        }

    method clickearElemento(posicion, elementos) {
        elementos.forEach({ elemento =>
            if (elemento.position() == posicion) elemento.clickear(self)
        })
    }

    method pasoUnSegundo() { 
        
        estado.pasoUnSegundo(self) 
        
        }

    method recibirIngrediente(ingrediente) { 
        
        cliente.recibirIngredientes(ingrediente, self) 
        
        }

    method descontarTiempo() {
        self.restarTiempo(1)
    }

    method restarTiempo(cantidad) {
        tiempo = tiempo - cantidad
        if (tiempo <= 0) {
            self.terminarNivel(estadoSinTiempo, pedidoFueraDeTiempo, botonReintentar)
        }
    }

    method enviarPedido() {
        if (cliente.resultadoCorrecto()) {
            self.terminarNivel(estadoCorrecto, pedidoCorrecto, botonSeguir)
        } else {
            game.say(cliente.estudianteEnMostrador(), "Mi pedido está incompleto")
        }
    }

    method siguienteNivel() {

        // PASO AL NIVEL 2

    }

    method empezar() {
        game.removeVisual(imagenIntro)
        game.removeVisual(botonIntro)
        self.iniciarPartida()
    }

    method iniciarPartida() {
        estado = estadoJugando
        tiempo = segundos

        game.addVisual(mostrador)
        game.addVisual(cliente.estudianteEnMostrador())
        listaIngredientes.forEach({ ing => game.addVisual(ing) })
        game.addVisual(botonEnviar)
        cliente.hacerPedido()
    }

    method terminarNivel(nuevoEstado, fondo, boton) {
        estado = nuevoEstado

        game.removeVisual(mostrador)
        game.removeVisual(cliente.estudianteEnMostrador())
        game.removeVisual(botonEnviar)
        game.removeVisual(cliente.pedidoReferencia())
        listaIngredientes.forEach({ ing => game.removeVisual(ing) })

        game.addVisual(fondo)
        game.addVisual(boton)
    }

    method reintentar() {
        game.removeVisual(pedidoFueraDeTiempo)
        game.removeVisual(botonReintentar)
        cliente.reiniciar()
        self.iniciarPartida()
    }

}

const nivel1 = new Nivel(
    cliente = estudiante,
    listaIngredientes = ingredientes1.lista(),
    pedidoCorrecto = pedidoCorrecto1,
    pedidoFueraDeTiempo = pedidoFueraDeTiempo1
)
