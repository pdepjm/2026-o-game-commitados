import wollok.game.*    
import ingredientes.*
import clientes.*
import sonidos.*

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

object botonReiniciar {
    method position() = game.at(5, 1)
    method image() = "botones/boton_Reiniciar.png"  

    method clickear(nivel) {
        nivel.volverAlInicio()
    }
}


// Pantalla de resultados (nuevo)
class PantallaResultado {
    const rutaImagen
    method position() = game.origin()
    method image() = rutaImagen
}

const pedidoCorrecto1 = new PantallaResultado(rutaImagen = "juegor1/Pedido_Correcto.png")
const pedidoFueraDeTiempo1 = new PantallaResultado(rutaImagen = "juegor1/Pedido_SinTiempo.png")

const pedidoCorrecto2 = new PantallaResultado(rutaImagen = "juegor2/Pedido_Correcto.png")
const pedidoFueraDeTiempo2 = new PantallaResultado(rutaImagen = "juegor2/Pedido_SinTiempo.png")

const pedidoCorrecto3 = new PantallaResultado(rutaImagen = "fondos/Final.png")
const pedidoFueraDeTiempo3 = new PantallaResultado(rutaImagen = "jugador3/Pedido_SinTiempo.png")

// Estados 
object estadoIntro {
    method procesarClick(nivel, posicion){ 
        sonidos.iniciarMusica()
        nivel.empezar() 
        }   
    method pasoUnSegundo(nivel) { }
}

object estadoJugando {
    
    method procesarClick(nivel, posicion) {
        nivel.clickearElemento(posicion, nivel.listaIngredientes() + [botonEnviar]) // elementos: Ingredientes + botonEnviar
    }
    method pasoUnSegundo(nivel) { nivel.descontarTiempo() }
}

object estadoSinTiempo {
    method procesarClick(nivel, posicion) {
        nivel.clickearElemento(posicion, [botonReintentar]) //elementos: botonReintentar
    }
    method pasoUnSegundo(nivel) { }
}

object estadoCorrecto {
    method procesarClick(nivel, posicion) {
        nivel.clickearElemento(posicion, [botonSeguir]) // elementos: botonSeguir
    }
    method pasoUnSegundo(nivel) { }
}

//estado (nuevo) : si Click coincide con el boton de reiniciar, se reincia el juego completo 

object estadoFinal {
    method procesarClick(nivel, posicion) {
        nivel.clickearElemento(posicion, [botonReiniciar]) // elementos : botonReiniciar
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
    const esElUltimo = false         // para saber si es el ultimo nivel 
    const property siguiente = null // nivel que sigue (el ultimo queda null)

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
        
        cliente.recibirIngredientes(ingrediente, self)  //self es el nivel
        
        }

    method descontarTiempo() {
        self.restarTiempo(1)
    }

    method restarTiempo(cantidad) {
        tiempo = tiempo - cantidad
        if (tiempo <= 0) {
            sonidos.sinTiempo()
            self.terminarNivel(estadoSinTiempo, pedidoFueraDeTiempo, botonReintentar)
        }
    }

    method enviarPedido() {
        if (cliente.resultadoCorrecto()) {
            sonidos.pedidoCorrecto()
            if (esElUltimo) {
                self.terminarNivel(estadoFinal, pedidoCorrecto, botonReiniciar)
            } else {
                self.terminarNivel(estadoCorrecto, pedidoCorrecto, botonSeguir)
            }
        } else {
            game.say(cliente.estudianteEnMostrador(), "Mi pedido está incompleto")
        }
    }

    // Empezar: inicia la partida 

    method empezar() {
        game.removeVisual(imagenIntro)
        game.removeVisual(botonIntro)
        self.iniciarPartida()
    }

    // iniciarPartida: pasa al estadoJugando, carga cliente + hacePedido , ingredintes y boton enviar.
    method iniciarPartida() {
        estado = estadoJugando
        tiempo = segundos

        game.addVisual(mostrador)
        game.addVisual(cliente.estudianteEnMostrador())
        listaIngredientes.forEach({ ing => game.addVisual(ing) })
        game.addVisual(botonEnviar)
        cliente.hacerPedido()
    }


    // limpiarPantalla : saca todo de la pantalla 

    method limpiarPantalla() {
        game.removeVisual(mostrador)
        game.removeVisual(cliente.estudianteEnMostrador())
        game.removeVisual(botonEnviar)
        game.removeVisual(cliente.pedidoReferencia())
        listaIngredientes.forEach({ ing => game.removeVisual(ing) })
    }

    // terminarNivel:  para estadoCorrecto, estadoSinTiempo , estadoFinal

    method terminarNivel(nuevoEstado, fondo, boton){
        estado = nuevoEstado
        self.limpiarPantalla()

        game.addVisual(fondo)
        game.addVisual(boton)
    }



    // si estamos en estadoCorrecto: Avisa a juego que pase al nivel siguiente

    method siguienteNivel() {
        game.removeVisual(pedidoCorrecto)
        game.removeVisual(botonSeguir)
        juego.avanzar()
    }


    // si estamos en estadoSinTiempo: se reiniar el nivel 

    method reintentar() {
        game.removeVisual(pedidoFueraDeTiempo)
        game.removeVisual(botonReintentar)
        cliente.reiniciar()
        self.iniciarPartida()
    }

    // si estamos en estadoFinal: avisa a juego de reiniciar todo el juego
 
    method volverAlInicio() {
        game.removeVisual(pedidoCorrecto)
        game.removeVisual(botonReiniciar)
        juego.reiniciar()
    }

    // vueve al estadoIntro una vez que termine el juego
    method reiniciarEstado() {
        estado = estadoIntro
        tiempo = segundos
        cliente.reiniciar()
    }


}

// Los niveles se declaran de atrás hacia adelante para poder indicar cuál es el siguiente
const nivel3 = new Nivel(
    cliente = matias,
    listaIngredientes = ingredientes3.lista(),
    pedidoCorrecto = pedidoCorrecto3,
    pedidoFueraDeTiempo = pedidoFueraDeTiempo3,
    esElUltimo = true
)

const nivel2 = new Nivel(
    cliente = maria,
    listaIngredientes = ingredientes2.lista(),
    pedidoCorrecto = pedidoCorrecto2,
    pedidoFueraDeTiempo = pedidoFueraDeTiempo2,
    siguiente = nivel3
)

const nivel1 = new Nivel(
    cliente = estudiante,
    listaIngredientes = ingredientes1.lista(),
    pedidoCorrecto = pedidoCorrecto1,
    pedidoFueraDeTiempo = pedidoFueraDeTiempo1,
    siguiente = nivel2
)


// Juego se encarga de saber en que nivel estas
// El .WPGM le manda los clicks y el tiempo a Juego y el se lo envia al nivel actual.

object juego {

    // empieza con nivel 1
    var nivelActual = nivel1

    // juego envia los clicks al nivelActual
    method clickPantalla(posicion) { nivelActual.clickPantalla(posicion) }

    // juego avisa al nivel actual para que se descuente el tiempo
    method pasoUnSegundo() { nivelActual.pasoUnSegundo() }

    // pasa del nivelActual al siguiente nivel1 -> nivel2 -> nivel3:
  
    method avanzar() {
        nivelActual = nivelActual.siguiente()
        nivelActual.iniciarPartida()
    }

    // si estoy en estadoFinal: se reinicia a nivel1

    method reiniciar() {
        [nivel1, nivel2, nivel3].forEach({ nivel => nivel.reiniciarEstado() })
        nivelActual = nivel1
        game.addVisual(imagenIntro)
        game.addVisual(botonIntro)
    }
}