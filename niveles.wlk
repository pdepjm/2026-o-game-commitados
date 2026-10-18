import wollok.game.*    
import visuales.*
import ingredientes.*
import clientes.*
import sonidos.*

// INTRO
object imagenIntro inherits Visual(rutaImagen = "fondos/Intro.png", posicion = game.origin()) { }

object botonIntro inherits Visual(rutaImagen = "botones/boton_Intro.png", posicion = game.at(5, 1)) { }

// BOTONES
// Todos son Clickeable: heredan image() y position() y estan obligados a definir clickear(nivel).
object botonEnviar inherits Clickeable(rutaImagen = "botones/boton_enviarPedido3.png", posicion = game.at(15, 1)) {
    override method clickear(nivel) {
        nivel.enviarPedido()
    }
}

object botonSeguir inherits Clickeable(rutaImagen = "botones/boton_Seguir.png", posicion = game.at(9, 0)) {
    override method clickear(nivel) {
        nivel.siguienteNivel()
    }
}

object botonReintentar inherits Clickeable(rutaImagen = "botones/boton_Reintentar.png", posicion = game.at(9, 0)) {
    override method clickear(nivel) {
        nivel.reintentar() 
    }
}

object botonReiniciar inherits Clickeable(rutaImagen = "botones/boton_Reiniciar.png", posicion = game.at(5, 1)) {
    override method clickear(nivel) {
        nivel.volverAlInicio()
    }
}


// Pantalla de resultados: un Visual que por defecto ocupa toda la pantalla (desde el origen)
class PantallaResultado inherits Visual(posicion = game.origin()) { }

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

// Los estadps  en los que solo importa UN boton (y el tiempo no corre) comparten esta clase
class EstadoConBoton {
    const boton

    method procesarClick(nivel, posicion) {
        nivel.clickearElemento(posicion, [boton])
    }
    method pasoUnSegundo(nivel) { }
}

object estadoSinTiempo inherits EstadoConBoton(boton = botonReintentar) { }

object estadoCorrecto inherits EstadoConBoton(boton = botonSeguir) { }

//estado nuevo : si Click coincide con el boton de reiniciar se reincia el juego completo 
object estadoFinal inherits EstadoConBoton(boton = botonReiniciar) { }

class Nivel {
    var estado = estadoIntro
    var tiempo = 30
    const segundos = 30

    const cliente
    const property listaIngredientes
    const pedidoCorrecto
    const pedidoFueraDeTiempo
    const property siguiente = null // nivel que sigue (en NivelFinal queda null)

    // getters para poder consultar el nivel (por ejemplo en los tests)
    method estado() = estado
    method tiempoRestante() = tiempo

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
            self.alCompletarPedido()
        } else {
            game.say(cliente.estudianteEnMostrador(), "Mi pedido está incompleto")
        }
    }

    // Que pasa cuando el pedido esta bien. NivelFinal lo redefine (override).
    method alCompletarPedido() {
        self.terminarNivel(estadoCorrecto, pedidoCorrecto, botonSeguir)
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

    // vueve al estadoIntro una vez que termine el juego
    method reiniciarEstado() {
        estado = estadoIntro
        tiempo = segundos
        cliente.reiniciar()
    }

}

// El ultimo nivel es un Nivel que, al completarse, no pasa a otro nivel:
// termina el juego (estadoFinal) y ofrece reiniciar todo.
class NivelFinal inherits Nivel {

    override method alCompletarPedido() {
        self.terminarNivel(estadoFinal, pedidoCorrecto, botonReiniciar)
    }

    method volverAlInicio() {
        game.removeVisual(pedidoCorrecto)
        game.removeVisual(botonReiniciar)
        juego.reiniciar()
    }
}

const nivel3 = new NivelFinal(
    cliente = matias,
    listaIngredientes = ingredientes3.lista(),
    pedidoCorrecto = pedidoCorrecto3,
    pedidoFueraDeTiempo = pedidoFueraDeTiempo3
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

object juego {

    // empieza con nivel 1
    var nivelActual = nivel1

    method nivelActual() = nivelActual

    method clickPantalla(posicion) { nivelActual.clickPantalla(posicion) }

    method pasoUnSegundo() { nivelActual.pasoUnSegundo() }

  
    method avanzar() {
        nivelActual = nivelActual.siguiente()
        nivelActual.iniciarPartida()
    }


    method reiniciar() {
        [nivel1, nivel2, nivel3].forEach({ nivel => nivel.reiniciarEstado() })
        nivelActual = nivel1
        game.addVisual(imagenIntro)
        game.addVisual(botonIntro)
    }
}
